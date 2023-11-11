FROM debian:bookworm-slim

RUN useradd -ms /bin/bash git && \
    mkdir /srv/git && \
    chown git /srv/git && \
    mkdir /var/run/sshd && \
    chmod 0755 /var/run/sshd

RUN apt update -y && \
    apt upgrade -y && \
    apt install -y git openssh-server && \
    cd /etc/ssh/ && \
    ssh-keygen -A && \
    service ssh --full-restart

RUN sed -E -i 's|#AuthorizedKeysFile(\s*).ssh/authorized_keys.*|AuthorizedKeysFile\1/home/git/.ssh/authorized_keys|' /etc/ssh/sshd_config && \
    sed -i 's/#PubkeyAuthentication/PubkeyAuthentication/' /etc/ssh/sshd_config && \
    service ssh start
    

USER git
WORKDIR /home/git/

RUN cd /home/git && \
    mkdir .ssh && \
    chmod 700 .ssh && \
    touch .ssh/authorized_keys && \
    chmod 600 .ssh/authorized_keys 

# example empty project
RUN cd /srv/git && \
    mkdir project.git && \
    cd project.git && \
    git init --bare

# switch back to root, otherwise it will fail for no hostkeys, as only root can see them
USER root

# restrict git user to not allow ssh, while still allowing pulls/pushes/clones
RUN echo $(which git-shell) >> /etc/shells && \
    chsh git -s $(which git-shell)

EXPOSE 22
# "-e" lets us get logs from the sshd service directly through docker logs, good for troubleshooting weird ssh issues
CMD ["/usr/sbin/sshd","-D", "-e"]

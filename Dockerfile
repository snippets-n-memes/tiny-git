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

RUN service ssh start

USER git
WORKDIR /home/git/

RUN cd && \
    mkdir .ssh && \
    chmod 700 .ssh && \
    touch .ssh/authorized_keys && \
    chmod 600 .ssh/authorized_keys 

# example empty project
RUN cd /srv/git && \
    mkdir project.git && \
    cd project.git && \
    git init --bare


EXPOSE 22
CMD ["/usr/sbin/sshd","-D"]
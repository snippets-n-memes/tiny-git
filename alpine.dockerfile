FROM alpine   
VOLUME [ "/sys/fs/cgroup" ]

RUN adduser -S git && \
    mkdir /srv/git && chown git /srv/git && \
    mkdir /var/run/sshd && chmod 0755 /var/run/sshd

RUN apk add --no-cache openssh-server openrc git vim
# RUN rc-update add sshd 
# RUN /etc/init.d/sshd start

RUN ssh-keygen -A \
    && echo -e "PasswordAuthentication no" >> /etc/ssh/sshd_config \
    && echo -e "PubkeyAuthentication yes" >> /etc/ssh/sshd_config \
    && mkdir -p /run/openrc \
    && touch /run/openrc/softlevel

# USER git
# WORKDIR /home/git/

RUN echo "/usr/bin/git-shell" | lchsh git

RUN cd /home/git/ && \
    mkdir .ssh && chmod 700 .ssh && \
    touch .ssh/authorized_keys && chmod 600 .ssh/authorized_keys && \
    chown -R git:nogroup .ssh 

# example empty project
RUN cd /srv/git && \
    mkdir project.git && \
    cd project.git && \
    git init --bare


EXPOSE 22
# ENTRYPOINT ["sh", "-c", "rc-status; rc-service sshd start"]
# CMD ["/usr/sbin/sshd","-D"]
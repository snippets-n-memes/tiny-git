FROM alpine   
VOLUME [ "/sys/fs/cgroup" ]

RUN adduser -S git && \
    mkdir /srv/git && chown git /srv/git && \
    mkdir /var/run/sshd && chmod 0755 /var/run/sshd

RUN apk add --no-cache openssh-server openrc git
RUN rc-update add sshd 
# RUN /etc/init.d/sshd start

USER git
WORKDIR /home/git/

RUN mkdir .ssh && chmod 700 .ssh && \
    touch .ssh/authorized_keys && chmod 600 .ssh/authorized_keys 

# example empty project
RUN cd /srv/git && \
    mkdir project.git && \
    cd project.git && \
    git init --bare


EXPOSE 22
# CMD ["/usr/sbin/sshd","-D"]
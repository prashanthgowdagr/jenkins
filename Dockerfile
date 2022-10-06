FROM ubuntu

RUN apt update && apt install  openssh-server sudo -y

RUN adduser remote-user && \
    echo "remote-user:test" | chpasswd && \
    mkdir /home/remote-user/.ssh && \
    chmod 700 /home/remote-user/.ssh

COPY remote-key.pub /home/remote-user/.ssh/authorized_keys

RUN chown jenkins:jenkins -R /home/remote-user/.ssh/ && \
    chown 600 /home/remote-user/.ssh/authorized_keys

RUN service ssh start

EXPOSE 22

CMD ["/usr/sbin/sshd","-D"]


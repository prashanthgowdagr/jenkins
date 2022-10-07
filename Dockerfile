FROM ubuntu

RUN apt update && apt install  openssh-server sudo -y

RUN adduser remote-user && \
    echo "remote-user:test" | chpasswd && \
    mkdir /home/remote-user/.ssh && \
    chmod 600 /home/remote-user/.ssh

COPY remote-key.pub /home/remote-user/.ssh/authorized_keys

RUN chown remote-user:remote-user -R /home/remote-user/.ssh/ && \
    chmod 600 /home/remote-user/.ssh/authorized_keys

RUN service ssh start

EXPOSE 22

CMD ["/usr/sbin/sshd","-D"]


FROM ubuntu

RUN apt update && apt install  openssh-server sudo -y

RUN useradd remote_user && \
    echo "remote_user:test" | chpasswd && \
    mkdir -p /home/remote_user/.ssh && \
    chmod 700 /home/remote_user/.ssh

COPY remote-key.pub /home/remote_user/.ssh/authorized_keys

RUN chown remote_user:remote_user -R /home/remote_user/.ssh/ && \
    chmod 600 /home/remote_user/.ssh/authorized_keys

RUN ssh-keygen -A

RUN service ssh start

CMD ["/usr/sbin/sshd","-D"]


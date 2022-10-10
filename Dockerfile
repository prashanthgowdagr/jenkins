FROM ubuntu

RUN apt update && apt install  openssh-server sudo -y

RUN adduser jenkins && \
    echo "jenkins:test" | chpasswd && \
    mkdir /home/jenkins/.ssh && \
    chmod 600 /home/jenkins/.ssh

COPY remote-key.pub /home/jenkins/.ssh/authorized_keys

RUN chown jenkins:jenkins -R /home/jenkins/.ssh/ && \
    chmod 600 /home/jenkins/.ssh/authorized_keys

RUN service ssh start

EXPOSE 22

CMD ["/usr/sbin/sshd","-D"]


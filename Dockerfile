FROM centos

RUN yum install openssh-server -y

RUN adduser jenkins && \
    echo "jenkins:jenkins" | chpasswd && \
    mkdir /home/jenkins/.ssh && \
    chmod 700 /home/jenkins/.ssh

COPY remote-key.pub /home/jenkins/.ssh/authorized_keys

RUN chown jenkins:jenkins -R /home/jenkins/.ssh/ && \
    chown 600 /home/jenkins/.ssh/authorized_keys

RUN /usr/sbin/sshd-keygen

CMD /usr/sbin/sshd -D

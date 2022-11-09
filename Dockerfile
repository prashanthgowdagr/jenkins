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



#1.  connect to jenkins container as root: docker exec -it -u root jenkins /bin/bash

#2. go to /tmp and change permissions of the remote-key file:  chown jenkins:jenkins remote-key

# ssh-keygen -f remote-ki -m PEM
#docker exec -u root jenkins bash -c "chown 1000:1000 /tmp/remote-ki" (((OR jenkins:jenkins)))

You could also see errors related to sshd-keygen. If so, just change this line from :

#RUN /usr/sbin/sshd-keygen
#to
#RUN ssh-keygen -A

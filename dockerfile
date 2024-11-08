FROM jenkins/jenkins:latest

USER root

RUN apt-get update && apt-get install -y sudo util-linux && \
    groupadd docker && usermod -aG docker jenkins && \
    echo "jenkins ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

USER jenkins;

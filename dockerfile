FROM jenkins/jenkins:latest


USER root


RUN apt-get update && apt-get install -y \
    sudo \
    curl \
    && rm -rf /var/lib/apt/lists/*


RUN groupadd docker && usermod -aG docker jenkins


RUN curl -fsSL https://get.docker.com -o get-docker.sh && \
    sh get-docker.sh && \
    rm get-docker.sh

# Allow jenkins user to run docker commands without sudo
RUN echo "jenkins ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

# Switch back to jenkins user
USER jenkins


EXPOSE 8080 50000

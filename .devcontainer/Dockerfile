FROM node:22

# Install Docker CLI
RUN apt-get update && apt-get install -y \
    apt-transport-https \
    ca-certificates \
    gnupg \
    lsb-release \
    sudo

# Add Docker’s official GPG key and repository
RUN curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
RUN echo \
  "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian \
  $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null
RUN apt-get update && apt-get install -y docker-ce-cli

# Install Act for local GitHub Actions testing
RUN curl https://raw.githubusercontent.com/nektos/act/master/install.sh | sudo bash

# Install pnpm globally
RUN npm install -g pnpm

# Allow node user to use sudo without a password
RUN echo "node ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

# Set up workspace directory
WORKDIR /workspace

USER node

FROM ubuntu:24.04

# Instalar dependencias
RUN apt-get update && apt-get install -y \
    openssh-server \
    sudo \
    python3 \
    cron \
    iproute2 \
    && rm -rf /var/lib/apt/lists/*

# Configurar usuario ubuntu
RUN echo "ubuntu:ubuntu" | chpasswd && \
    usermod -aG sudo ubuntu && \
    echo "ubuntu ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Configurar SSH
RUN mkdir /var/run/sshd && \
    sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config && \
    sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config

EXPOSE 22

# Arrancar SSH y cron
CMD ["bash", "-c", "service ssh start && service cron start && exec sleep infinity"]

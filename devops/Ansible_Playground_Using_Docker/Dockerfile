FROM debian:12-slim AS base
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    bash \
    curl \
    && rm -rf /var/lib/apt/lists/*
WORKDIR /workspace

FROM base AS controller
RUN apt-get update && apt-get install -y --no-install-recommends \
    ansible \
    openssh-client \
    sshpass \
    git \
    python3 \
    python3-venv \
    sudo \
    nano \
    vim \
    less \
    rsync \
    && rm -rf /var/lib/apt/lists/*
ENV ANSIBLE_HOST_KEY_CHECKING=False \
    ANSIBLE_RETRY_FILES_ENABLED=False \
    PYTHONUNBUFFERED=1
CMD ["/bin/bash"]

FROM base AS target
RUN apt-get update && apt-get install -y --no-install-recommends \
    openssh-server \
    python3 \
    sudo \
    && rm -rf /var/lib/apt/lists/*
RUN useradd -m -s /bin/bash ansible \
    && echo "ansible:ansible" | chpasswd \
    && usermod -aG sudo ansible \
    && mkdir -p /var/run/sshd \
    && echo "ansible ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/ansible \
    && chmod 0440 /etc/sudoers.d/ansible \
    && ssh-keygen -A
RUN sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config \
    && sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin no/' /etc/ssh/sshd_config \
    && printf '\nAllowUsers ansible\n' >> /etc/ssh/sshd_config
EXPOSE 22
CMD ["/bin/bash", "-lc", "exec /usr/sbin/sshd -D -e"]

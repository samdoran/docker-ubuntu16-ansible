FROM ubuntu:16.04
ENV container=docker

ENV CONTAINER=docker
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        apt-transport-https \
        aptitude \
        bash \
        curl \
        gcc \
        ca-certificates \
        iproute2 \
        libyaml-dev \
        python-apt \
        python-dev \
        python-pip \
        python-setuptools \
        python-wheel \
        software-properties-common \
        sudo \
        systemd \
        systemd-cron \
    && rm -rf /var/lib/apt/lists/* \
    && rm -Rf /usr/share/doc && rm -Rf /usr/share/man \
    && apt-get clean

RUN pip install ansible q

RUN mkdir -p /etc/ansible \
    && echo '[local]\nlocalhost ansible_connection=local ansible_python_interpreter=/usr/bin/python3' > /etc/ansible/hosts

VOLUME ["/sys/fs/cgroup", "/tmp", "/run"]
CMD ["/lib/systemd/systemd"]

FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y python3 python3-pip python3-venv wget && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir -p /uv/0.4.30 /uv/0.5.20

RUN python3 -m venv /uv/0.4.30 && \
    /uv/0.4.30/bin/pip install uv==0.4.30

# Install uv 0.5.20 in the second environment
RUN python3 -m venv /uv/0.5.20 && \
    /uv/0.5.20/bin/pip install uv==0.5.20

RUN wget -O /tmp/sf-python312_3.12.5-12.noble_amd64.deb https://github.com/gozdal/sf-python/raw/refs/heads/main/sf-python312_3.12.5-12.noble_amd64.deb && \
    apt-get install -y /tmp/sf-python312_3.12.5-12.noble_amd64.deb && \
    rm /tmp/sf-python312_3.12.5-12.noble_amd64.deb

RUN ln -s /opt/starfish/python3.12/bin/python3.12 /usr/local/bin

COPY example.py /uv
COPY uv-0.4.sh /uv
COPY uv-0.5.sh /uv

# Set the working directory
WORKDIR /uv

# Command to keep the container running
CMD ["tail", "-f", "/dev/null"]

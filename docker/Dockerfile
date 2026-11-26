FROM debian:12

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    gcc \
    g++ \
    make \
    git \
    wget \
    curl \
    file \
    bc \
    bison \
    flex \
    cpio \
    unzip \
    rsync \
    python3 \
    python3-setuptools \
    perl \
    patch \
    gzip \
    bzip2 \
    xz-utils \
    zstd \
    libncurses-dev \
    libssl-dev \
    libelf-dev \
    ca-certificates \
    openssh-client \
    && rm -rf /var/lib/apt/lists/*

ARG USER_ID=1000
ARG GROUP_ID=1000

RUN groupadd --gid ${GROUP_ID} builder && \
    useradd --uid ${USER_ID} --gid ${GROUP_ID} \
    --create-home --shell /bin/bash builder

USER builder
WORKDIR /workspace

CMD ["/bin/bash"]

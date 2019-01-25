FROM gitpod/workspace-full:latest

USER root

RUN apt-get update && apt-get install -yq \
        libsdl2-dev \
        build-essential \
        cmake \
        p7zip-full \
        wget \
    && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/*

# We need QT, but for comsic (which gitpod/workspace-full is currently based) offers only 5.11
# Unfortuantely, since QT v5.10.1, it uses a syscall 'statx' that is not allowed in Docker (and thus Gitpod).
# Issue: https://bugreports.qt.io/browse/QTBUG-66930
# Thus we have to install QT 5.10.0 manually. Because the official Qt script turned out to be way too painful
# we go with https://lnj.gitlab.io/post/qli-installer/
USER gitpod
RUN wget https://git.kaidan.im/lnj/qli-installer/raw/master/qli-installer.py
RUN chmod +x qli-installer.py
RUN pip install requests
RUN ./qli-installer.py 5.10.0 linux desktop

USER root
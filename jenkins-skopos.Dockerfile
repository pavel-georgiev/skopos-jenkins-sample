FROM jenkins

# Install Skopos CLI
# For this to work, you need to extract the Skopos CLI in this directory first
# i.e.
#
# mkdir -p bin
# rm -rf bin/sks-ctl
# touch bin/sks-ctl
# docker run                               \
#     --rm                                 \
#     -v $(pwd)/bin/sks-ctl:/skopos/bin/sks-ctl \
#     --entrypoint "/bin/bash"             \
#     datagridsys/skopos:stage              \
#     -c 'cp -a engine /skopos/bin/sks-ctl'

COPY bin/sks-ctl /skopos/bin/

# temporarily se uer to root to be able to use apt
USER root

# Install docker
RUN apt-get update && \
    apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common && \
    curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add - && \
    add-apt-repository \
        "deb [arch=amd64] https://download.docker.com/linux/debian \
        $(lsb_release -cs) \
        stable" && \
    apt-get update && \
    apt-get install -y docker-ce

USER jenkins

# Pre install Jenkins docker plugin
RUN /usr/local/bin/install-plugins.sh docker




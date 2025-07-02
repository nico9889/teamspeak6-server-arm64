# Using Ubuntu as the original image of TS6 server is based on Ubuntu as well
FROM ubuntu:latest

# Create a non-root user inside the container
ARG USERNAME=tsserver
ARG USER_UID=9987
ARG USER_GID=$USER_UID

RUN groupadd --gid $USER_GID $USERNAME \
    && useradd --uid $USER_UID --gid $USER_GID -m $USERNAME

# Install box64 emulator
RUN apt update && apt install gpg libcurl4 libgcc-s1 openssl ca-certificates wget -y && update-ca-certificates
RUN wget https://ryanfortner.github.io/box64-debs/box64.list -O /etc/apt/sources.list.d/box64.list && wget -qO- https://ryanfortner.github.io/box64-debs/KEY.gpg | gpg --dearmor -o /etc/apt/trusted.gpg.d/box64-debs-archive-keyring.gpg && apt update && apt install box64 -y

# Install libraries required by the TeamSpeak 6 server
RUN apt install libatomic1 -y

# Copying the server from the original TS6 image
COPY --from=teamspeaksystems/teamspeak6-server:latest --chown=9987:9987 /opt /opt

# Copying the start script and making it executable
COPY ./start.sh /opt/tsserver/start.sh
RUN chmod +x /opt/tsserver/start.sh

# Creating the workdir folder
RUN mkdir /var/tsserver
WORKDIR /var/tsserver

# Setting the container to run as the rootless user
USER $USERNAME

# Setting the start.sh script as the new entrypoint
ENTRYPOINT ["/opt/tsserver/start.sh"]

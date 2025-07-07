# TS6 ARM Server
This repository contains a Dockerfile and a script to run TeamSpeak 6 Server on ARM64 based platform, using Box64 bundled in the container instead of Qemu.

This should improve the performance by a lot.

On an Orange Pi 5,  the first boot of the server, which requires keys precomputation, took over 7 minutes with Qemu, and only 2 seconds using the image with Box64.

At this time I only tested that the server starts and it's possible to connect to it.

**Please note that ARM64 is not officially supported by TeamSpeak. If you encounter bugs by using this image, please avoid reporting them to TeamSpeak unless you are 100% sure they are not related to the emulator. You may want to report them to https://github.com/ptitSeb/box64 to attempt to improve the emulation support instead.**

I tested this image by using Podman, but it should work correctly on Docker as well as they are pretty much equivalent.

# How to use it

Clone this repository and open it:
```bash
git clone https://github.com/nico9889/teamspeak6-server-arm64
cd teamspeak6-server-arm64
```

Build the new image:
```bash
docker build . --tag 'ts6-arm'
```

Start the image:
```bash
docker run -it --rm \
  -p 9987:9987/udp \
  -p 30033:30033 \
  -e TSSERVER_LICENSE_ACCEPTED=accept \
  -v ts6-data:/var/tsserver
  ts6-arm
```

To use it with Podman, write the same commands replacing `docker` with `podman`.

Please refer to the original TeamSpeak 6 server repository (linked below) to know the environmental variables supported by the server for configuration.

If you need to pass command line arguments to `tsserver`, pass them to `start.sh` instead to ensure a correct execution.

# References
* Original TeamSpeak 6 server repository: https://github.com/teamspeak/teamspeak6-server




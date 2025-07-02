#!/bin/bash
# This should be done automatically by the tsserver executable, but for some reasons it fails. 
# We are doing the copy in this script as the container starts because you may want to set /var/tsserver as a volume as it contains the sqllite database :)
# Copying the file in the Dockerfile, while building the image, fails because the folder get override by the newly mounted container.
cp -r /opt/tsserver/sql /var/tsserver 

# Starting the TS6 server using the Box64 emulator
box64 /opt/tsserver/tsserver

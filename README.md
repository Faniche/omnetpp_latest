# OMNeT++ Docker Image

This repository contains a Dockerfile for building a Docker image with OMNeT++ installed. OMNeT++ is a discrete event simulation environment used for simulating network protocols and systems.

## Prerequisites

Ensure you have the following installed on your system:

- Docker
- Git

## Building the Docker Image

Clone the repository:

```bash
git clone https://github.com/Faniche/omnetpp_latest.git
cd omnetpp_latest
```

Build the Docker image:

```bash
docker build -t omnetpp:6.0.3 .
```

## Running the Docker Container

To run the OMNeT++ IDE from the Docker container, you need to allow Docker to use your X server for displaying the GUI. 

### Linux

Run the following commands to set up and start the container:

```bash
export DISPLAY=:0
xhost +
docker run -it -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix --device /dev/dri/ omnetpp
```
When entering container, run the following commands:

```bash
. setenv
omnetpp
```
### MacOS and Windows

Running GUI applications inside Docker containers on MacOS and Windows requires additional setup. You can use XQuartz on MacOS or an X server like VcXsrv on Windows. Refer to relevant guides to set up X11 forwarding for Docker on your platform.

## Environment Variables

- `DEBIAN_FRONTEND=noninteractive`: Prevents interactive prompts during package installation.
- `TZ=Asia/Tokyo`: Sets the timezone to Tokyo.
- `OMNETPP_VERSION=6.0.3`: Specifies the version of OMNeT++.
- `OMNETPP_ROOT=/opt/omnetpp`: Sets the root directory for OMNeT++ installation.
- `PATH=$OMNETPP_ROOT/bin:$PATH`: Adds OMNeT++ binaries to the system PATH.

## Troubleshooting

### Timezone Setting

If the build process asks for geographic area or timezone, ensure the `TZ` environment variable is set correctly in the Dockerfile.

### X11 Display Issues

If you encounter issues with displaying the OMNeT++ IDE, make sure:

- The X server is running on your host machine.
- You have set the correct DISPLAY environment variable.
- You have allowed local connections to the X server using `xhost`.

## License

This project is licensed under the MIT License.

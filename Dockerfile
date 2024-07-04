# Use an official Ubuntu as a parent image
FROM ubuntu:20.04

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Asia/Tokyo
ENV OMNETPP_VERSION=6.0.3
ENV OMNETPP_ROOT=/opt/omnetpp
ENV PATH=$OMNETPP_ROOT/bin:$PATH

# Install dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    clang \
    lld \
    gdb \
    bison \
    flex \
    perl \
    python3 \
    python3-pip \
    qtbase5-dev \
    qtchooser \
    qt5-qmake \
    qtbase5-dev-tools \
    libqt5opengl5-dev \
    libxml2-dev \
    zlib1g-dev \
    doxygen \
    graphviz \
    libwebkit2gtk-4.0-37 \
    xdg-utils \
    openscenegraph-plugin-osgearth \
    libosgearth-dev \
    wget && \
    apt-get clean


# Install Python packages
RUN python3 -m pip install --upgrade numpy pandas matplotlib scipy seaborn posix_ipc

# Download and install OMNeT++
RUN wget https://github.com/omnetpp/omnetpp/releases/download/omnetpp-${OMNETPP_VERSION}/omnetpp-${OMNETPP_VERSION}-linux-x86_64.tgz && \
    tar xvfz omnetpp-${OMNETPP_VERSION}-linux-x86_64.tgz && \
    mv omnetpp-${OMNETPP_VERSION} $OMNETPP_ROOT && \
    rm omnetpp-${OMNETPP_VERSION}-linux-x86_64.tgz

# Set up environment variables and build OMNeT++
RUN cd $OMNETPP_ROOT && \
    mkdir /usr/share/desktop-directories/ && \
    bash -c ". setenv && ./configure && make -j6"

# Create and set the working directory
RUN mkdir -p $OMNETPP_ROOT/OmnetppProjects

# Set the working directory
WORKDIR $OMNETPP_ROOT

# Default command to run when the container starts
CMD ["bash", "-c", ". $OMNETPP_ROOT/setenv && omnetpp && bash"]

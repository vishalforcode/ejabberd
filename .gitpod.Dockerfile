# Use Gitpod's official workspace-full image as the base image
FROM gitpod/workspace-full:latest

# Install Erlang and other required dependencies
USER root
RUN apt-get update && \
    apt-get install -y \
    erlang \
    build-essential \
    libexpat1-dev \
    libyaml-dev \
    curl \
    wget \
    autoconf \
    automake \
    libssl-dev \
    git \
    && apt-get clean

# Set environment variables (adjust as needed)
ENV ROOT_URL=http://localhost:3000

# Clone and install Ejabberd (optional, based on your needs)
RUN git clone https://github.com/vishalforcode/ejabberd.git /opt/ejabberd && \
    cd /opt/ejabberd && \
    ./autogen.sh && \
    ./configure && \
    make && \
    make install

# Expose Ejabberd ports (XMPP and Admin Interface)
EXPOSE 5222 5280

# Set default command (can be adjusted as necessary)
CMD ["ejabberdctl", "debug"]

FROM ubuntu:14.04
MAINTAINER Risul Islam <docker@risul.com>

ENV NODE_VERSION 0.10.39
ENV NPM_VERSION 2.11.3
ENV PORT=8080

# Set working dir
WORKDIR /tmp

# Install dependencies
RUN \
  apt-get update -y && \
  DEBIAN_FRONTEND=noninteractive apt-get install -y \
  automake build-essential curl python phantomjs
  
# verify gpg and sha256: http://nodejs.org/dist/v0.10.31/SHASUMS256.txt.asc
RUN gpg --keyserver pool.sks-keyservers.net --recv-keys 7937DFD2AB06298B2293C3187D33FF9D0246406D 114F43EE0176B71C7BC219DD50A3051F888C628D

#install node
RUN curl -SLO "https://nodejs.org/dist/v$NODE_VERSION/node-v$NODE_VERSION-linux-x64.tar.gz" \
	&& curl -SLO "https://nodejs.org/dist/v$NODE_VERSION/SHASUMS256.txt.asc" \
	&& gpg --verify SHASUMS256.txt.asc \
	&& grep " node-v$NODE_VERSION-linux-x64.tar.gz\$" SHASUMS256.txt.asc | sha256sum -c - \
	&& tar -xzf "node-v$NODE_VERSION-linux-x64.tar.gz" -C /usr/local --strip-components=1 \
	&& rm "node-v$NODE_VERSION-linux-x64.tar.gz" SHASUMS256.txt.asc \
	&& npm install -g npm@"$NPM_VERSION" \
	&& npm cache clear

#Install meteor
RUN curl https://install.meteor.com/ | sh
	
# Clean up
WORKDIR /
RUN apt-get remove -y automake build-essential curl \
    && apt-get autoremove -y \
    && apt-get autoclean \
    && apt-get clean \
    && rm -rf /usr/share/doc-base /usr/share/man /usr/share/locale /usr/share/zoneinfo \
    && rm -rf /var/lib/cache /var/lib/log \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
    && npm cache clear

VOLUME /app
WORKDIR /app
	
ADD dev-entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh	
	
#Exposing port, prepare app & run
EXPOSE $PORT
ENTRYPOINT /entrypoint.sh
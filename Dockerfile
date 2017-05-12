FROM library/ubuntu:14.04

MAINTAINER Ben Gibbons

# Debugging helpers
##################################################
RUN alias ll='ls -alG'

# Set environment variables
##################################################
ENV DEBIAN_FRONTEND noninteractive
ENV TERM xterm

# Install tools
##################################################
RUN apt-get update; \
  apt-get install -y apt-transport-https debconf-utils; \
  apt-key adv --keyserver  hkp://keyserver.ubuntu.com:80 --recv-keys 379CE192D401AB61; \
  sh -c "echo 'deb https://dl.bintray.com/vi4m/ralph wheezy main' >  /etc/apt/sources.list.d/vi4m_ralph.list"; \
  apt-get update; \
  apt-get install -y ralph-core redis-server; \
  sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password password ralph_ng'; \
  sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password ralph_ng'; \
  sudo apt-get -y install mysql-server

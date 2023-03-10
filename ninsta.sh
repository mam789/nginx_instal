#!/bin/bash

# Check if the user is running the script with root privileges
if [ "$EUID" -ne 0 ]
  then echo "Please run this script with root privileges."
  exit
fi

# Detect the operating system
if [ "$(uname)" == "Darwin" ]; then
  # Mac OS X platform
  brew install nginx
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
  # Linux platform
  if [ -f /etc/lsb-release ]; then
    # Ubuntu or Debian
    apt-get update
    apt-get install nginx
  elif [ -f /etc/redhat-release ]; then
    # Red Hat or CentOS
    yum update
    yum install nginx
  else
    echo "Unsupported Linux distribution"
    exit
  fi
else
  echo "Unsupported operating system"
  exit
fi

# Start the Nginx service
if [ "$(uname)" == "Darwin" ]; then
  brew services start nginx
else
  systemctl start nginx
fi


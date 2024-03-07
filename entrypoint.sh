#!/bin/sh

# Set the port from the environment variable, defaulting to 8080
PORT="${PORT:-8080}"

# Start Tomcat with the specified port
/usr/local/tomcat/bin/catalina.sh run -Dport.http=$PORT

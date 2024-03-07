#!/bin/bash
# Use exec to pass control to asadmin, including signal handling (like Ctrl-C)
exec /glassfish7/glassfish/bin/asadmin start-domain --verbose --port $PORT

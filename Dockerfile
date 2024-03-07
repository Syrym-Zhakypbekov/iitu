# Use Eclipse Temurin OpenJDK official image for JDK 21 on Alpine for a small footprint
FROM eclipse-temurin:21-jdk-alpine

# Set environment variables
ENV CATALINA_HOME /usr/local/tomcat
ENV PATH $CATALINA_HOME/bin:$PATH
ENV TOMCAT_VERSION 10.1.19

# Install required packages
RUN apk add --no-cache curl

# Download and install Tomcat
RUN mkdir -p "$CATALINA_HOME" && \
    curl -SL "https://dlcdn.apache.org/tomcat/tomcat-10/v$TOMCAT_VERSION/bin/apache-tomcat-$TOMCAT_VERSION.tar.gz" \
    | tar -xz -C "$CATALINA_HOME" --strip-components=1 && \
    rm -rf "$CATALINA_HOME/webapps/examples" "$CATALINA_HOME/webapps/docs" "$CATALINA_HOME/webapps/ROOT"

# Remove unneeded apps and files to make it lightweight
RUN rm -rf "$CATALINA_HOME/webapps/"*

# Copy configurations (server.xml, web.xml, etc) if you have any custom configurations
# COPY config/ $CATALINA_HOME/conf/

# Copy necessary files from your project directory
COPY target/ $CATALINA_HOME/webapps/
COPY setenv.sh $CATALINA_HOME/bin/
COPY entrypoint.sh /entrypoint.sh

# Make sure scripts in the bin directory are executable
RUN chmod +x $CATALINA_HOME/bin/* && \
    chmod +x /entrypoint.sh

# Expose port (Heroku will ignore this, but it's good documentation)
EXPOSE 8080

# Start Tomcat
CMD ["/entrypoint.sh"]

# Use an official Ubuntu base image
FROM ubuntu:20.04

# Set environment variables


ENV TOMCAT_USER=tomcat
ENV TOMCAT_GROUP=tomcat
ENV INSTALL_DIR=/opt/tomcat

# Update and install dependencies (Java)
RUN apt-get update -y && apt-get install -y \
    default-jdk \
    wget \
    tar \
    && rm -rf /var/lib/apt/lists/*

# Download and extract Tomcat
RUN mkdir -p /opt/tomcat \
    && cd /opt/tomcat \
    && wget https://downloads.apache.org/tomcat/tomcat-10/v10.1.39/bin/apache-tomcat-10.1.39.tar.gz \
    && tar xzf apache-tomcat-10.1.39.tar.gz \
    && ls -l /opt/tomcat/apache-tomcat-10.1.39/bin/  

# Create Tomcat user and group (for security)
RUN groupadd --system $TOMCAT_GROUP \
    && useradd --system --shell /bin/false --home $INSTALL_DIR --gid $TOMCAT_GROUP $TOMCAT_USER

# Set ownership and permissions for the Tomcat directory
RUN chown -R $TOMCAT_USER:$TOMCAT_GROUP $INSTALL_DIR \
    && chmod -R 770 $INSTALL_DIR

# Expose port 8080 to access Tomcat
EXPOSE 8080

# Switch to Tomcat user and start Tomcat
USER $TOMCAT_USER

#give execute permissions to the shell
RUN chmod +x /opt/tomcat/apache-tomcat-10.1.39/bin/catalina.sh

# Start Tomcat
ENTRYPOINT ["/opt/tomcat/apache-tomcat-10.1.39/bin/catalina.sh", "run"]
# I want to run with entrypoint because I am deploying a webserver 
# with a fixed command and entrypoint does not permit override
# not that efficient as version change requires manual change

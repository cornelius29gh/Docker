FROM ubuntu:20.04

# Set non-interactive mode for tzdata
ENV DEBIAN_FRONTEND=noninteractive
#WHY? -> BECAUSE Ubuntu asks for a geographic area and does not proceed until you manually select one

# Update system packages and Install Apache2 web server
RUN apt update && apt install -y apache2 tzdata 

#ENABLING BASIC APACHE SECURITY RECOMMENDATIONS..."

# Restrict permissions on Apache conf files
RUN chmod -R 700 /etc/apache2/*

# Hiding Server Version and Banner 
RUN sed -i '/ServerSignature/c\ServerSignature Off' /etc/apache2/conf-available/security.conf
RUN sed -i '/ServerTokens/c\ServerTokens Prod' /etc/apache2/conf-available/security.conf

# Expose port 80 (default for Apache)
EXPOSE 80

# Start Apache in the foreground
CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]
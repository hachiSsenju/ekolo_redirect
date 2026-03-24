# Use Ubuntu as base
FROM ubuntu:22.04

# Set environment variables to avoid interactive prompts
ENV DEBIAN_FRONTEND=noninteractive

# Install Apache2
RUN apt-get update && \
    apt-get install -y apache2 && \
    apt-get clean

# Remove default HTML
RUN rm -rf /var/www/html/*

# Copy our redirect index.html
COPY index.html /var/www/html/

# Expose HTTP port
EXPOSE 80

# Start Apache in foreground
CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]
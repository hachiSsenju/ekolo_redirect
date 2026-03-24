# Use official Apache image
FROM httpd:2.4

# Copy the index.html with instant redirect into Apache's default web root
COPY index.html /usr/local/apache2/htdocs/

# Optional: copy custom Apache config (for SSL or server-side redirect)
# COPY ./ekoloafrica.conf /usr/local/apache2/conf/extra/httpd-vhosts.conf

# Expose port 80 (HTTP)
EXPOSE 80
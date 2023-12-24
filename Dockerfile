FROM nginx:latest


# Remove sym links from nginx image
RUN rm /var/log/nginx/access.log
RUN rm /var/log/nginx/error.log

# Install logrotate manually
RUN apt-get update 
RUN apt-get -y install logrotate

# Remove default logrotate script
RUN rm /etc/cron.daily/logrotate

# Copy customer logrotate script
COPY logrotate /etc/cron.d

# Copy nginx log rotate config
COPY nginx /etc/logrotate.d/

# Start nginx and cron as a service
CMD service cron start && nginx -g 'daemon off;'
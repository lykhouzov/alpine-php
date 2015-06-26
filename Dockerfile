FROM alpine
MAINTAINER Aleksandr Lykhouzov <lykhouzov@gmail.com>

# Install PHP
RUN /sbin/apk update \
&& /sbin/apk add \
# INSTALL PHP
php-common php-mcrypt php-soap php-xmlreader \
php-curl php-intl php-zlib \
php-enchant php-zip php-dom \
php-mysqli php-pear php-pdo_mysql php-json \
php-pdo php-gd php-openssl php-iconv \
php-xml php-xsl php-fpm php-ctype \
# Configure php-fpm
#&& sed -i 's/listen = 127.0.0.1:9000/listen = \/var\/run\/php5-fpm.sock/g' /etc/php/php-fpm.conf \
#&& sed -i 's/;listen.group = nobody/listen.group = nobody/g' /etc/php/php-fpm.conf \
#&& sed -i 's/;listen.mode = 0660/listen.mode = 0777/g' /etc/php/php-fpm.conf \
&& sed -i 's/listen = 127.0.0.1:9000/listen = 0.0.0.0:9000/g' /etc/php/php-fpm.conf \
&& sed -i 's/;php_flag\[display_errors\] = off/php_flag\[display_errors\] = on/g' /etc/php/php-fpm.conf \
&& sed -i 's/;php_admin_value\[error_log\] = \/var\/log\/fpm-php.www.log/php_admin_value[error_log] = \/var\/log\/php-fpm.log/g' /etc/php/php-fpm.conf \
&& sed -i 's/;php_admin_flag\[log_errors\] = on/php_admin_flag\[log_errors\] = on/g' /etc/php/php-fpm.conf \
&& sed -i 's/;catch_workers_output = yes/catch_workers_output = yes/g' /etc/php/php-fpm.conf \
# CLEAN CACHE
#&& /sbin/apk cache clean \
# forward request and error logs to docker log collector
&& ln -sf /dev/stdout  /var/log/php-fpm.log

EXPOSE 9000

VOLUME ["/var/www/html","/var/run/php5-fpm.sock"]

CMD ["php-fpm","-F","-O","-R"]

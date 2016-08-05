FROM ubuntu:16.04
MAINTAINER Chris Horsnell <chris@melonwebdesign.co.uk>

RUN apt-get update

# fix issue with nano not working in docker container
# http://stackoverflow.com/questions/27826241/running-nano-in-docker-container
ENV TERM xterm

# steal from php official container
ADD https://raw.githubusercontent.com/docker-library/php/master/docker-php-source /usr/local/bin/
ADD https://raw.githubusercontent.com/docker-library/php/master/docker-php-ext-install /usr/local/bin/
ADD https://raw.githubusercontent.com/docker-library/php/master/docker-php-ext-enable /usr/local/bin/
ADD https://raw.githubusercontent.com/docker-library/php/master/docker-php-ext-configure /usr/local/bin/

RUN chmod 0777 /usr/local/bin/docker-php*

# to allow add-apt-repository
RUN apt-get install -y software-properties-common build-essential nano git wget vsftpd ssh fail2ban

# CURL

RUN apt-get install -y curl

# NODE

RUN curl -sL https://deb.nodesource.com/setup_4.x | bash -
RUN apt-get install -y nodejs

RUN npm install -g bower gulp

# APACHE

RUN apt-get install -y apache2

# MYSQL

# RUN apt-get install mysql-server mysql-client

# PHP

RUN add-apt-repository ppa:ondrej/php -y
RUN apt-get update
RUN apt-get install -y php5.6 --allow-unauthenticated
RUN a2enmod rewrite

#RUN docker-php-ext-install pdo pdo_mysql mcrypt gd imagemagick
RUN apt-get install -y php5.6-mysql php5.6-gd php5.6-imagick php5.6-mcrypt  --allow-unauthenticated

RUN apt-get install -y bash-completion

# COMPOSER

RUN curl --insecure -sS https://getcomposer.org/installer | php
RUN mv composer.phar /usr/bin/composer

WORKDIR /var/www/html/

EXPOSE 80

# BRING UP APACHE

ADD ./start.sh /start.sh
RUN chmod +x /start.sh

ENTRYPOINT ["/bin/bash","-c","/start.sh"]
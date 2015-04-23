FROM debian:wheezy
MAINTAINER Alexandr Krivospitsky <alex@krivospitsky.ru>

ENV DEBIAN_FRONTEND noninteractive

#RUN cat /proc/mounts > /etc/mtab

RUN apt-get update && apt-get -y upgrade && apt-get -y -f -q install apache2 libapache2-mod-php5 php5-mysql php5-curl msmtp-mta libwww-perl libhtml-treebuilder-xpath-perl libfile-slurp-perl wget php5-mcrypt && apt-get clean

RUN php5enmod mcrypt
RUN a2enmod rewrite
RUN a2enmod headers
RUN a2enmod cgi
RUN a2enmod cgid

#RUN a2dismod mpm_prefork
#RUN a2enmod mpm_worker

#RUN sed -i "s/UploadDir'] = ''/UploadDir'] = '\/var\/www\/uploads'/" /etc/phpmyadmin/config.inc.php

#RUN sed -i "s/upload_max_filesize = 2M/upload_max_filesize = 10M/" /etc/php5/apache2/php.ini
#RUN sed -i "s/post_max_size = 8M/post_max_size = 10M/" /etc/php5/apache2/php.ini

ADD php.ini /etc/php5/apache2/php.ini
ADD mpm_prefork.conf /etc/apache2/mods-available/mpm_prefork.conf
ADD default /etc/apache2/sites-available/default
ADD my.cnf /etc/mysql/my.cnf
ADD lamp_start.sh /lamp_start.sh
ADD msmtprc /etc/msmtprc


#RUN wget http://downloads3.ioncube.com/loader_downloads/ioncube_loaders_lin_x86-64.tar.gz -O - | tar zx -C /usr/local/

EXPOSE 80

CMD ["/lamp_start.sh"]

FROM debian:jessie
MAINTAINER Alexandr Krivospitsky <alex@krivospitsky.ru>

ENV DEBIAN_FRONTEND noninteractive

#RUN cat /proc/mounts > /etc/mtab

RUN apt-get update && \
	apt-get -y upgrade && \
	DEBIAN_FRONTEND=noninteractive  apt-get -y -f -q install apache2 libapache2-mod-php5 php5-mysql php5-curl msmtp-mta libwww-perl libhtml-treebuilder-xpath-perl libfile-slurp-perl libdbd-mysql-perl libclass-dbi-perl wget php5-mcrypt php5-gd && \
	apt-get clean

RUN php5enmod mcrypt &&  a2enmod rewrite && a2enmod headers && a2enmod cgi && a2enmod cgid

RUN apt-get -y install dnsutils

#RUN a2dismod mpm_prefork
#RUN a2enmod mpm_worker


ADD php.ini /etc/php5/apache2/php.ini
ADD mpm_prefork.conf /etc/apache2/mods-available/mpm_prefork.conf
ADD 000-default.conf /etc/apache2/sites-available/000-default.conf
ADD apache_start.sh /apache_start.sh
ADD msmtprc /etc/msmtprc


#RUN wget http://downloads3.ioncube.com/loader_downloads/ioncube_loaders_lin_x86-64.tar.gz -O - | tar zx -C /usr/local/

EXPOSE 80

CMD ["/apache_start.sh"]

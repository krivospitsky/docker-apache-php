FROM debian:wheezy
MAINTAINER Alexandr Krivospitsky <alex@krivospitsky.ru>

ENV DEBIAN_FRONTEND noninteractive

#RUN cat /proc/mounts > /etc/mtab

RUN apt-get update && \
	apt-get -y upgrade && \
	DEBIAN_FRONTEND=noninteractive  apt-get -y -f -q install apache2 libapache2-mod-php5 php5-mysql php5-curl msmtp-mta libwww-perl libhtml-treebuilder-xpath-perl libfile-slurp-perl wget php5-mcrypt && \
	apt-get clean

RUN php5enmod mcrypt &&  a2enmod rewrite && a2enmod headers && a2enmod cgi && a2enmod cgid

#RUN a2dismod mpm_prefork
#RUN a2enmod mpm_worker


ADD php.ini /etc/php5/apache2/php.ini
ADD mpm_prefork.conf /etc/apache2/mods-available/mpm_prefork.conf
ADD default /etc/apache2/sites-available/default
ADD lamp_start.sh /lamp_start.sh
ADD msmtprc /etc/msmtprc


#RUN wget http://downloads3.ioncube.com/loader_downloads/ioncube_loaders_lin_x86-64.tar.gz -O - | tar zx -C /usr/local/

EXPOSE 80

CMD ["source /etc/apache2/envvars && exec /usr/sbin/apache2"]

FROM ubuntu:latest

MAINTAINER Alex Garnett

# Install latest updates
RUN apt-get update
RUN apt-get upgrade -y

# Apache setup
ENV HTTPD_PREFIX /usr/local/apache2
ENV PATH $PATH:$HTTPD_PREFIX/bin
RUN mkdir -p "$HTTPD_PREFIX" \
	&& chown www-data:www-data "$HTTPD_PREFIX"
WORKDIR $HTTPD_PREFIX

# Install mysql client and server
RUN apt-get -y install mysql-client mysql-server curl apache2

# Enable remote access (default is localhost only, we change this
# otherwise our database would not be reachable from outside the container)
RUN sed -i -e"s/^bind-address\s*=\s*127.0.0.1/bind-address = 0.0.0.0/" /etc/mysql/my.cnf

# Set Standard settings
ENV right READ

# Install starting script
ADD ./get-and-clean-sql.sh /usr/local/bin/get-and-clean-sql.sh
ADD ./import-database.sh /usr/local/bin/import-database.sh
RUN chmod +x /usr/local/bin/import-database.sh

# change this; we don't want to expose 3306 once this is all working
EXPOSE 3306
EXPOSE 80

RUN /usr/sbin/mysqld &
RUN service apache2 start
FROM ubuntu:latest

MAINTAINER Alex Garnett

# Install latest updates
RUN apt-get update
RUN apt-get upgrade -y

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
RUN chmod +x /usr/local/bin/get-and-clean-sql.sh
RUN chmod +x /usr/local/bin/import-database.sh

EXPOSE 3306
EXPOSE 80

RUN /usr/sbin/mysqld
FROM ubuntu:latest

MAINTAINER Nane Kratzke

# Install latest updates
RUN apt-get update
RUN apt-get upgrade -y

# Install mysql client and server
RUN apt-get -y install mysql-client mysql-server curl

# Enable remote access (default is localhost only, we change this
# otherwise our database would not be reachable from outside the container)
RUN sed -i -e"s/^bind-address\s*=\s*127.0.0.1/bind-address = 0.0.0.0/" /etc/mysql/my.cnf

# Set Standard settings
ENV right READ

# Install starting script
ADD ./start-database.sh /usr/local/bin/start-database.sh

# Make a directory to put adminer wrappers
RUN mkdir /usr/local/share/adminers

EXPOSE 3306

CMD ["/usr/local/bin/start-database.sh"]

#!/bin/bash

# Sanitize database name in case none is provided from export
DBNAME="$(cat /dev/urandom | tr -cd 'a-f0-9' | head -c 32)"
sed -ri.bak 's/-- Database: (.*?)/CREATE DATABASE \1;\nUSE DATABASE \1;/g' /tmp/import.sql
if grep -q "CREATE DATABASE" /tmp/import.sql; then :; else sed -ri.bak 's/-- MySQL dump/CREATE DATABASE `$(echo $DBNAME)`;\nUSE DATABASE `$(echo $DBNAME)`;\n-- MySQL dump/g' /tmp/import.sql; fi

# Import the database that was cleaned in the previous script
mysql --default-character-set=utf8 < /tmp/import.sql
rm /tmp/import.sql
mysqladmin shutdown
echo "finished"

# Now the provided user credentials are added
/usr/sbin/mysqld &
sleep 5
echo "Creating user"
echo "CREATE USER '$user' IDENTIFIED BY '$password'" | mysql --default-character-set=utf8
echo "REVOKE ALL PRIVILEGES ON *.* FROM '$user'@'%'; FLUSH PRIVILEGES" | mysql --default-character-set=utf8
echo "GRANT SELECT ON $database TO '$user'@'%'; FLUSH PRIVILEGES" | mysql --default-character-set=utf8
echo "finished"

if [ "$right" = "WRITE" ]; then
echo "adding write access"
echo "GRANT ALL PRIVILEGES ON $database TO '$user'@'%' WITH GRANT OPTION; FLUSH PRIVILEGES" | mysql --default-character-set=utf8
fi

# And we restart the server to go operational
mysqladmin shutdown
echo "Restarting MySQL Server"
/usr/sbin/mysqld

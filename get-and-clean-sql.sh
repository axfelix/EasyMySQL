#!/bin/bash

echo "Creating user $user for databases loaded from $url"

# Sanitize database name in case none is provided from export
DBNAME="$(cat /dev/urandom | tr -cd 'a-f0-9' | head -c 32)"
echo "Adding data into MySQL"
file -bi /var/mysql/database.sql
/usr/sbin/mysqld &
sleep 5
curl $url -o import.sql
sed -ri.bak 's/-- Database: (.*?)/CREATE DATABASE \1;\nUSE DATABASE \1;/g' import.sql
if grep -q "CREATE DATABASE" import.sql; then :; else sed -ri.bak 's/-- MySQL dump/CREATE DATABASE `$(echo $DBNAME)`;\nUSE DATABASE `$(echo $DBNAME)`;\n-- MySQL dump/g' import.sql; fi

#!/bin/bash

# Sanitize database name in case none is provided from export
DBNAME="$(cat /dev/urandom | tr -cd 'a-f0-9' | head -c 32)"
sed -ri.bak 's/-- Database: (.*?)/CREATE DATABASE \1;\nUSE DATABASE \1;/g' /tmp/import.sql
if grep -q "CREATE DATABASE" /tmp/import.sql; then :; else sed -ri.bak 's/-- MySQL dump/CREATE DATABASE `$(echo $DBNAME)`;\nUSE DATABASE `$(echo $DBNAME)`;\n-- MySQL dump/g' /tmp/import.sql; fi

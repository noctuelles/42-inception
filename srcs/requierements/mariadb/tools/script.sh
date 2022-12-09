#!/bin/bash

echo "-- MYSQL Secure Installation --"

echo -n "Updating root password"
mysql -e "UPDATE mysql.user SET Password = PASSWORD('${MYSQL_ROOT_PASSWORD}') WHERE User = 'root'"
if [ $? -eq 0]; then
	echo "... Success!"
else
	echo "... Failed!"

echo -n "Removing anonymous users"
mysql -e "DELETE FROM mysql.user WHERE User='';"
if [ $? -eq 0]; then
	echo "... Success!"
else
	echo "... Failed!"

echo -n "Removing remote root"
mysql -e "DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');"
if [ $? -eq 0]; then
	echo "... Success!"
else
	echo "... Failed!"

echo -n "Removing test database"
mysql -e "DELETE FROM mysql.db WHERE Db='test' OR Db='test\\_%'"
if [ $? -eq 0]; then
	echo "... Success!"
else
	echo "... Failed!"

echo -n "Reloading privilege tables"
mysql -e "FLUSH PRIVILEGES"
if [ $? -eq 0]; then
	echo "... Success!"
else
	echo "... Failed!"

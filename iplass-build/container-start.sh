#!/bin/sh

systemctl start mysqld
mysql -u root -Dmysql -e "source /tmp/timezone.sql;"
rm -f /etc/my.cnf

cp /tmp/my.cnf /etc/

systemctl restart mysqld

systemctl start chrony
timedatectl set-timezone Asia/Tokyo

systemctl restart rsyslog

exit 0

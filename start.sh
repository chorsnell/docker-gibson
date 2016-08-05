#!/bin/bash

#/etc/init.d/apache2 start
#/etc/init.d/mysql start

service vsftpd restart

apachectl -DFOREGROUND
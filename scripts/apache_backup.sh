#!/bin/bash

DATE=$(date +\%F)
Backup_file="/backups/apache_backup_$DATE.tar.gz"
tar -czf $Backup_file /etc/httpd/ /var/www/html/
tar -czf $Backup_file > /backups/apache_backup_verify_$DATE.log
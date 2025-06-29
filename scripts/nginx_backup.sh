#!/bin/bash

DATE=$(date +\%F)
Backup_file="/backups/nginx_backup_$DATE.tar.gz"
tar -czf $Backup_file /etc/nginx/ usr/share/nginx/html/
tar -tzf $Backup_file > /backups/nginx_backup_verify_$DATE.log
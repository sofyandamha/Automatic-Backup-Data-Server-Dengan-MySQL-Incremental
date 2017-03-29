#!/bin/sh

# Config Variables:
User="root"
HOST="localhost"
PASS="kadal10S"

# Get last backup file names into variables
LAST_WWW_BACKUP=$(ls -A backup/daily/coba/*.sql.gz | tail -n 1)
LAST_SQL_BACKUP=$(ls -A backup/daily/coba/*.sql | tail -n 1)

# Restore files
sudo /bin/gunzip  $LAST_WWW_BACKUP
for filename in DB-Restore$(date +"%m-%d-%Y")
do
dbname=${filename}
done
 mysqladmin create $dbname -u $USER -p$PASS

# Restore database
/usr/bin/mysql -u root -pkadal10S $dbname  < $LAST_SQL_BACKUP

now=$(date +"%d-%m-%Y-%h")
mkdir backup/backup_$now &&
mv backup/daily/coba/* backup/backup_$now


# Clear drupal caches
#drush -r /home/example/www/ cc all

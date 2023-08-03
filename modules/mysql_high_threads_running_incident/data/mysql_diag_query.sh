

#!/bin/bash


# Connect to MySQL and run diagnostic query

echo "Checking for long-running or poorly optimized queries..."

mysql -u $MYSQL_USER -p$MYSQL_PASSWORD -h $MYSQL_HOST -P $MYSQL_PORT -D $MYSQL_DATABASE -e "SELECT * FROM INFORMATION_SCHEMA.PROCESSLIST WHERE TIME > 60 OR Command = 'Query' ORDER BY TIME DESC;"



echo "Done."
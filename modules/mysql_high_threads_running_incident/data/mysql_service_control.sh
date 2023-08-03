

#!/bin/bash



# Stop the MySQL service

sudo systemctl stop mysql



# Wait for the service to stop

while [ "$(systemctl is-active mysql)" != "inactive" ]; do

    sleep 1

done



# Start the MySQL service

sudo systemctl start mysql
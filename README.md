
### About Shoreline
The Shoreline platform provides real-time monitoring, alerting, and incident automation for cloud operations. Use Shoreline to detect, debug, and automate repairs across your entire fleet in seconds with just a few lines of code.

Shoreline Agents are efficient and non-intrusive processes running in the background of all your monitored hosts. Agents act as the secure link between Shoreline and your environment's Resources, providing real-time monitoring and metric collection across your fleet. Agents can execute actions on your behalf -- everything from simple Linux commands to full remediation playbooks -- running simultaneously across all the targeted Resources.

Since Agents are distributed throughout your fleet and monitor your Resources in real time, when an issue occurs Shoreline automatically alerts your team before your operators notice something is wrong. Plus, when you're ready for it, Shoreline can automatically resolve these issues using Alarms, Actions, Bots, and other Shoreline tools that you configure. These objects work in tandem to monitor your fleet and dispatch the appropriate response if something goes wrong -- you can even receive notifications via the fully-customizable Slack integration.

Shoreline Notebooks let you convert your static runbooks into interactive, annotated, sharable web-based documents. Through a combination of Markdown-based notes and Shoreline's expressive Op language, you have one-click access to real-time, per-second debug data and powerful, fleetwide repair commands.

### What are Shoreline Op Packs?
Shoreline Op Packs are open-source collections of Terraform configurations and supporting scripts that use the Shoreline Terraform Provider and the Shoreline Platform to create turnkey incident automations for common operational issues. Each Op Pack comes with smart defaults and works out of the box with minimal setup, while also providing you and your team with the flexibility to customize, automate, codify, and commit your own Op Pack configurations.

# MySQL high threads running incident.
---

This incident type refers to a situation where the MySQL database is experiencing a high level of threads running, which could indicate a performance issue. This may cause issues with the application that relies on the database, such as slow response times or even downtime. Resolving this incident typically involves investigating the root cause of the high thread count and optimizing the database configuration or query performance to reduce the load on the database.

### Parameters
```shell
# Environment Variables

export HOSTNAME="PLACEHOLDER"

export USERNAME="PLACEHOLDER"

export PASSWORD="PLACEHOLDER"

export MYSQL_DATA_DIRECTORY="PLACEHOLDER"

export MYSQL_ERROR_LOG="PLACEHOLDER"

export MYSQL_SLOW_QUERY_LOG="PLACEHOLDER"

```

## Debug

### Check MySQL processlist to see the running queries and threads
```shell
mysql -h ${HOSTNAME} -u ${USERNAME} -p${PASSWORD} -e "SHOW FULL PROCESSLIST"
```

### Check the MySQL connection limit
```shell
mysql -h ${HOSTNAME} -u ${USERNAME} -p${PASSWORD} -e "SHOW VARIABLES LIKE 'max_connections'"
```

### Check the number of threads currently running on the server
```shell
ps -ef | grep mysql | grep -v grep | wc -l
```

### Check the system load average
```shell
uptime
```

### Check the available memory and swap space
```shell
free -m
```

### Check the disk usage of MySQL data directory
```shell
du -sh ${MYSQL_DATA_DIRECTORY}
```

### Check the MySQL error log for any relevant errors or warnings
```shell
tail -n 100 ${MYSQL_ERROR_LOG}
```

### Check the slow query log for queries that might be contributing to high thread count
```shell
tail -n 100 ${MYSQL_SLOW_QUERY_LOG}
```

### Check the dmesg output for any kernel-level errors or warnings
```shell
dmesg | tail
```

### A long-running or poorly optimized query, causing threads to stay active for longer periods of time.
```shell


#!/bin/bash


# Connect to MySQL and run diagnostic query

echo "Checking for long-running or poorly optimized queries..."

mysql -u $MYSQL_USER -p$MYSQL_PASSWORD -h $MYSQL_HOST -P $MYSQL_PORT -D $MYSQL_DATABASE -e "SELECT * FROM INFORMATION_SCHEMA.PROCESSLIST WHERE TIME > 60 OR Command = 'Query' ORDER BY TIME DESC;"



echo "Done."


```

## Repair

### Identify the queries causing the high thread count and optimize them.
```shell
bash

#!/bin/bash

 INDEX_NAME="PLACEHOLDER"

 TABLE_NAME="PLACEHOLDER"

 COLUMN_NAME="PLACEHOLDER"

# Connect to the MySQL server using the ${USERNAME} and ${PASSWORD}

mysql -u ${USERNAME} -p${PASSWORD}



# Identify the queries causing the high thread count

SHOW PROCESSLIST;



# Analyze the slow performing queries

EXPLAIN ${SLOW_QUERY};



# Optimize the queries by adding missing indexes or rewriting the query

ALTER TABLE ${TABLE_NAME} ADD INDEX ${INDEX_NAME} (${COLUMN_NAME});


```

### Restart the MySQL server to clear all running threads.
```shell


#!/bin/bash



# Stop the MySQL service

sudo systemctl stop mysql



# Wait for the service to stop

while [ "$(systemctl is-active mysql)" != "inactive" ]; do

    sleep 1

done



# Start the MySQL service

sudo systemctl start mysql


```
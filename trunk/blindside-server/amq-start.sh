#!/bin/bash

# ActiveMQ startup script. Install ActiveMQ at /usr/local/activemq-4.1.1
# and use this script to start.

for JAVA in "$JAVA_HOME/bin/java" "/usr/bin/java" "/usr/local/bin/java"
do
  if [ -x $JAVA ]
  then
    break
  fi
done

if [ ! -x $JAVA ]
then
  echo "Unable to locate java. Please set JAVA_HOME environment variable."
  exit
fi

# start activemq
/usr/local/activemq-4.1.1/bin/activemq > /tmp/amq.log  2>&1 &

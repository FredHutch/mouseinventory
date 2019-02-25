#!/bin/bash

export JAVA_OPTS="$JAVA_OPTS -DBUSER=$DBUSER"
export JAVA_OPTS="$JAVA_OPTS -DDBPASSWORD=$DBPASSWORD" 
export JAVA_OPTS="$JAVA_OPTS -DBPORT=$DBPORT"
export JAVA_OPTS="$JAVA_OPTS -DBHOST=$DHOST"
export JAVA_OPTS="$JAVA_OPTS -DBUSER=$DBUSER"
export JAVA_OPTS="$JAVA_OPTS -DBURL=$DBURL"

echo JAVA_OPTS is
echo $JAVA_OPTS

cat /tmp/context.xml | sed -e "s/DBUSER/$DBUSER/" -e "s/DBPASSWORD/$DBPASSWORD/" -e "s/DBURL/jdbc:mysql:\/\/$DBHOST:$DBPORT\/mouse_inventory/" > $CATALINA_HOME/conf/context.xml

$CATALINA_HOME/bin/catalina.sh run





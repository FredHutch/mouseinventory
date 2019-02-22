# build me as fredhutch/mouseinventory
# like this (after sourcing setup.sh):
# docker build --build-arg DBUSER=$DBUSER --build-arg DBHOST=$DBHOST --build-arg DBPORT=$DBPORT --build-arg DBPASSWORD=$DBPASSWORD    -t fredhutch/mouseinventory .
# and run me like this:
# docker run --rm -e DBURL=$DBURL -e DBUSER=$DBUSER -e DBPASSWORD=$DBPASSWORD -e DBHOST=$DBHOST -e DBPORT=$DBPORT -p 8080:8080 fredhutch/mouseinventory
FROM ubuntu:14.04

RUN apt-get update -y 

RUN apt-get install -y maven2 openjdk-6-jdk make curl software-properties-common libmysqlclient-dev libxml2 libxml2-dev zlib1g-dev liblzma-dev build-essential patch

RUN apt-add-repository -y  ppa:brightbox/ruby-ng

RUN apt-get update -y

RUN apt-get install -y ruby2.3 ruby-switch ruby2.3-dev

RUN ruby-switch --set ruby2.3

RUN gem install standalone_migrations rake mysql2 activerecord-mysql2-adapter


RUN mkdir /mouseinventory

COPY . /mouseinventory/

WORKDIR /mouseinventory/

ARG DBHOST
ARG DBPASSWORD
ARG DBPORT
ARG DBUSER

RUN rake db:migrate DB=production

ENV JAVA_HOME=/usr/lib/jvm/java-6-openjdk-amd64

RUN mvn package

# end of first build

FROM tomcat:7.0.93-jre7

RUN rm -rf $CATALINA_HOME/webapps/*

COPY --from=0 /mouseinventory/target/mouseinventory.war $CATALINA_HOME/webapps/ROOT.war

COPY serverFiles/tomcat/tomcat-users.xml $CATALINA_HOME/conf/tomcat-users.xml

# COPY serverFiles/tomcat/context.xml $CATALINA_HOME/conf/context.xml

COPY serverFiles/tomcat/context.xml /tmp/



# RUN curl -LO https://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-java_8.0.15-1debian9_all.deb

# RUN dpkg -i mysql-connector-java_8.0.15-1debian9_all.deb

# RUN cp /usr/share/java/mysql-connector-java-8.0.15.jar $CATALINA_HOME/lib/

RUN curl -L https://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-java-5.1.47.zip > /tmp/mysqlconnector.zip

RUN unzip /tmp/mysqlconnector.zip -d /tmp/

RUN cp /tmp/mysql-connector-java-5.1.47/mysql-connector-java-5.1.47-bin.jar $CATALINA_HOME/lib/


COPY start.sh .

CMD ./start.sh

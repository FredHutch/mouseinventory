# build me as fredhutch/mouseinventory
FROM ubuntu:14.04

RUN apt-get update -y 

RUN apt-get install -y tomcat6 tomcat6-admin git maven2 openjdk-6-jdk make libmysqlclient-dev curl software-properties-common

RUN apt-add-repository -y  ppa:brightbox/ruby-ng

RUN apt-get update -y

RUN apt-get install -y ruby2.3 ruby-switch ruby2.3-dev

RUN ruby-switch --set ruby2.3

RUN gem install standalone_migrations rake mysql2 activerecord-mysql2-adapter

RUN curl -LO https://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-java_8.0.15-1ubuntu18.04_all.deb

RUN dpkg -i mysql-connector-java_8.0.15-1ubuntu18.04_all.deb

RUN mkdir /mouseinventory

COPY . /mouseinventory/

COPY serverFiles/tomcat/tomcat-users.xml /var/lib/tomcat6/conf/tomcat-users.xml

COPY serverFiles/tomcat/context.xml /var/lib/tomcat6/conf/context.xml


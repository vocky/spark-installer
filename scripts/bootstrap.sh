#!/bin/bash

# update
sudo apt-get -qq update
sudo apt-get -y -qq upgrade
sudo apt-get install unzip
sudo apt-get install -y python-pip python-dev fabric
sudo apt-get install libpng-dev libjpeg8-dev libfreetype6-dev
sudo apt-get install python-numpy python-scipy python-matplotlib ipython ipython-notebook python-pandas python-sympy python-nose
sudo pip install -U pandasql
# Install java PreReq
## JAVA
command -v javac>/dev/null 2>&1 || { echo >&2 "I require java but it's not \
        installed. Installing java"; sudo apt-get install -y -qq \
        openjdk-7-jdk;}
sudo ln -s /usr/lib/jvm/java-7-openjdk-amd64 /usr/lib/jvm/default-java
# if java_home is not set
if [ -z "$JAVA_HOME" ]; then
    echo "export JAVA_HOME=/usr/lib/jvm/java-7-openjdk-amd64" >> ~/.pam_environment
    source ~/.pam_environment
fi

# Create Directories

DOWNLOAD_DIR=/mnt/spark-installer/Downloads
if [ ! -d $DOWNLOAD_DIR ]; then
    mkdir $DOWNLOAD_DIR
fi

INSTALL_DIR=/mnt
HADOOP_DIR=$INSTALL_DIR/hadoop
SCALA_DIR=$INSTALL_DIR/scala
SPARK_DIR=$INSTALL_DIR/spark

echo "export INSTALL_DIR=$INSTALL_DIR " | tee -a ~/.pam_environment
echo "export DOWNLOAD_DIR=$DOWNLOAD_DIR " | tee -a ~/.pam_environment

echo "export HADOOP_PREFIX=$HADOOP_DIR" | tee -a ~/.pam_environment
echo "export HADOOP_HOME=$INSTALL_DIR/hadoop" | tee -a ~/.pam_environment
echo "export HADOOP_DATA_DIR=/mnt/hadoop_data" | tee -a ~/.pam_environment
echo "export YARN_HOME=$INSTALL_DIR/hadoop" | tee -a ~/.pam_environment

echo "export HADOOP_CONF_DIR=$INSTALL_DIR/hadoop/etc/hadoop" | tee -a ~/.pam_environment
echo "export YARN_CONF_DIR=$INSTALL_DIR/hadoop/etc/hadoop" | tee -a ~/.pam_environment
 
echo "export SCALA_HOME=$INSTALL_DIR/scala" | tee -a ~/.pam_environment
echo "export SPARK_HOME=$INSTALL_DIR/spark" | tee -a ~/.pam_environment
echo "export SPARK_CONF_DIR=$INSTALL_DIR/spark/conf" | tee -a ~/.pam_environment

echo "export ZEPPELIN_HOME=/mnt/zeppelin" | tee -a ~/.pam_environment
echo "export ZEPPELIN_CONF_DIR=$ZEPPELIN_HOME/conf" | tee -a ~/.pam_environment
echo "export ZEPPELIN_NOTEBOOK_DIR=$ZEPPELIN_HOME/notebook" | tee -a ~/.pam_environment

echo "export HIVE_HOME=/mnt/hive" | tee -a ~/.pam_environment
echo "export HIVE_CONF_DIR=$HIVE_HOME/conf" | tee -a ~/.pam_environment

echo "source ~/.pam_environment" | tee -a ~/.bashrc 

#!/bin/bash

## HADOOP

CONF_FILES_DIR=./config_files
source ~/.pam_environment
echo $PATH
hadoop -h 2>&1>/dev/null
if [ $? == 0 ]; then
    echo 'Hadoop was found'
else
    myPath=$DOWNLOAD_DIR/hadoop-2.6.4.tar.gz
    if [ ! -d "$myPath"]; then  
        #wget 
        wget http://mirrors.cnnic.cn/apache/hadoop/common/hadoop-2.6.4/hadoop-2.6.4.tar.gz -P $DOWNLOAD_DIR
    fi
    tar -xzf $DOWNLOAD_DIR/hadoop-2.6.4.tar.gz -C $DOWNLOAD_DIR
    sudo mv $DOWNLOAD_DIR/hadoop-2.6.4/  $INSTALL_DIR
    sudo mv $INSTALL_DIR/hadoop-2.6.4 $HADOOP_HOME
    sudo chown -R ubuntu:ubuntu $HADOOP_HOME

    #create directory for hadoop to store files
    sudo mkdir -p /mnt/hadoop_data
    sudo chown -R ubuntu:ubuntu /mnt/hadoop_data


    # copy configuration files for hadoop
    cp $CONF_FILES_DIR/core-site.xml $HADOOP_CONF_DIR/
    cp $CONF_FILES_DIR/mapred-site.xml $HADOOP_CONF_DIR/
    cp $CONF_FILES_DIR/hdfs-site.xml $HADOOP_CONF_DIR/
    cp $CONF_FILES_DIR/yarn-site.xml $HADOOP_CONF_DIR/
    cp $CONF_FILES_DIR/yarn-site.xml.slave $HADOOP_CONF_DIR/
    
    #chmod -R 755 $HADOOP_HOME
    echo "export PATH=$PATH:$HADOOP_PREFIX/bin:$HADOOP_PREFIX/sbin" | tee -a ~/.pam_environment
    echo "export JAVA_HOME=/usr/lib/jvm/java-7-openjdk-amd64" | tee -a \
    $HADOOP_CONF_DIR/yarn-env.sh

    echo "export JAVA_HOME=/usr/lib/jvm/java-7-openjdk-amd64" | tee -a \
    $HADOOP_CONF_DIR/hadoop-env.sh

    echo "export HADOOP_NAMENODE_USER=ubuntu" | tee -a \
    $HADOOP_CONF_DIR/hadoop-env.sh

    echo "export HADOOP_DATANODE_USER=ubuntu" | tee -a \
    $HADOOP_CONF_DIR/hadoop-env.sh

    echo "export HADOOP_SECONDARYNAMENODE_USER=ubuntu" | tee -a \
    $HADOOP_CONF_DIR/hadoop-env.sh

    echo "export HADOOP_JOBTRACKER_USER=ubuntu" | tee -a \
    $HADOOP_CONF_DIR/hadoop-env.sh
    
    echo "export HADOOP_TASKTRACKER_USER=ubuntu" | tee -a \
    $HADOOP_CONF_DIR/hadoop-env.sh


    echo "***** HADOOP DONE! *****"
    
    source ~/.pam_environment
fi

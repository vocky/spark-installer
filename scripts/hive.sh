#!/bin/bash

## hive

CONF_FILES_DIR=./config_files
source ~/.pam_environment
echo $PATH
hive -h 2>&1>/dev/null
if [ $? == 0 ]; then
    echo 'hive was found'
else
    myPath=$DOWNLOAD_DIR/apache-hive-2.1.0-bin.tar.gz
    if [ ! -d "$myPath"]; then  
        #wget 
        wget http://mirrors.advancedhosters.com/apache/hive/hive-2.1.0/apache-hive-2.1.0-bin.tar.gz -P $DOWNLOAD_DIR
    fi
    tar -xzf $DOWNLOAD_DIR/apache-hive-2.1.0-bin.tar.gz -C $DOWNLOAD_DIR
    sudo mv $DOWNLOAD_DIR/apache-hive-2.1.0-bin $INSTALL_DIR
    sudo mv $INSTALL_DIR/apache-hive-2.1.0-bin $HIVE_HOME
    sudo chown -R ubuntu:ubuntu $HIVE_HOME

    # copy configuration files for hive
    cp $CONF_FILES_DIR/hive-env.sh $HIVE_CONF_DIR
    #chmod -R 755 $HIVE_HOME
    echo "export PATH=$PATH:$HIVE_HOME/bin" | tee -a ~/.pam_environment

    echo "***** HIVE DONE! *****"
    
    source ~/.pam_environment
    hadoop fs -mkdir -p /user/ubuntu
    hadoop fs -mkdir -p /user/hive/warehouse
    schematool -initSchema -dbType derby
fi

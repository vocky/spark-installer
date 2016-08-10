#!/bin/bash

CONF_FILES_DIR=./config_files

export ZEPPELIN_HOME=/mnt/zeppelin
export ZEPPELIN_CONF_DIR=$ZEPPELIN_HOME/conf
export ZEPPELIN_NOTEBOOK_DIR=$ZEPPELIN_HOME/notebook

source ~/.pam_environment
myPath=$DOWNLOAD_DIR/zeppelin-0.6.0-bin-all.tgz
if [ ! -d "$myPath"]; then
    #wget 
    wget http://ftp.wayne.edu/apache/zeppelin/zeppelin-0.6.0/zeppelin-0.6.0-bin-all.tgz -P $DOWNLOAD_DIR
fi

tar -xzf $DOWNLOAD_DIR/zeppelin-0.6.0-bin-all.tgz -C $DOWNLOAD_DIR

sudo mv $DOWNLOAD_DIR/zeppelin-0.6.0-bin-all $ZEPPELIN_HOME

sudo chown -R ubuntu:ubuntu $ZEPPELIN_HOME

cp $CONF_FILES_DIR/zeppelin-env.sh $ZEPPELIN_CONF_DIR/
cp $CONF_FILES_DIR/zeppelin-site.xml $ZEPPELIN_CONF_DIR/

echo "*********** Zeppelin Done ************"

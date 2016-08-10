#!/bin/bash

CONF_FILES_DIR=./config_files
export SPARK_CONF_DIR=/mnt/spark/conf
export SPARK_HOME=/mnt/spark

source ~/.pam_environment
myPath=$DOWNLOAD_DIR/spark-1.6.2-bin-hadoop2.6.tgz
if [ ! -d "$myPath"]; then
    #wget 
    wget http://mirror.bit.edu.cn/apache/spark/spark-1.6.2/spark-1.6.2-bin-hadoop2.6.tgz -P $DOWNLOAD_DIR
fi
tar -xzf $DOWNLOAD_DIR/spark-1.6.2-bin-hadoop2.6.tgz -C $DOWNLOAD_DIR
sudo mv $DOWNLOAD_DIR/spark-1.6.2-bin-hadoop2.6 $SPARK_HOME

sudo chown -R ubuntu:ubuntu $SPARK_HOME

sudo mkdir -p /var/lib/spark/{work,rdd,pid}
sudo mkdir -p /var/log/spark

sudo chown -R ubuntu:ubuntu /var/lib/spark
sudo chown -R ubuntu:ubuntu /var/log/spark

cp $CONF_FILES_DIR/spark-env.sh $SPARK_CONF_DIR/
cp $CONF_FILES_DIR/spark-defaults.conf $SPARK_CONF_DIR/

cd $SPARK_CONF_DIR
cp log4j.properties.template log4j.properties

export PYTHONPATH=$SPARK_HOME/python/:$PYTHONPATH
export PYTHONPATH=$SPARK_HOME/python/lib/py4j-0.9-src.zip:$PYTHONPATH
echo 'export PYTHONPATH=$SPARK_HOME/python/:$PYTHONPATH' | tee -a ~/.pam_environment
echo 'export PYTHONPATH=$SPARK_HOME/python/lib/py4j-0.9-src.zip:$PYTHONPATH' | tee -a ~/.pam_environment
echo 'MASTER=spark://spark-01:7077' | tee -a ~/.pam_environment
echo "export PATH=$PATH:$SPARK_HOME/bin:$SPARK_HOME/sbin" | tee -a ~/.pam_environment
echo "*********** Spark Done ************"

source ~/.pam_environment


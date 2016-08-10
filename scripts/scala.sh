#!/bin/bash

pwd=$PWD
source ~/.pam_environment

## SCALA
scalac -help 2>&1>/dev/null
if [ $? == 0  ]; then
    echo 'Scala was found'
else
    # download the src for hadoop, scala and spark
    myPath=$DOWNLOAD_DIR/scala-2.10.6.tgz
    if [ ! -d "$myPath"]; then
        wget http://scala-lang.org/files/archive/scala-2.10.6.tgz -P $DOWNLOAD_DIR
    fi
    #Extract hadoop and Scala
    tar -zxf $DOWNLOAD_DIR/scala-2.10.6.tgz -C $DOWNLOAD_DIR
    sudo mv $DOWNLOAD_DIR/scala-2.10.6 $INSTALL_DIR
    sudo mv $INSTALL_DIR/scala-2.10.6 $SCALA_HOME
    sudo chown -R ubuntu:ubuntu $SCALA_HOME
    echo "***** Now Copying Scala *****"
    echo "export PATH=$PATH:$SCALA_HOME/bin" | tee -a ~/.pam_environment
fi

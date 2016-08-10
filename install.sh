#!/bin/bash

# bootstrap as ubuntu
    # install java
    # create directories
sudo bash ./scripts/bootstrap.sh

# install hadoop (2.6.4)
sudo bash ./scripts/hadoop.sh

# install scala (2.10.6)
sudo bash ./scripts/scala.sh

# install spark (1.6.2)
sudo bash ./scripts/spark.sh

# install zeppelin (0.6.0)
sudo bash ./scripts/zeppelin.sh

# install hive (2.1.0)
sudo bash ./scripts/hive.sh

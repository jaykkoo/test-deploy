#!/usr/bin/env bash

# clean codedeploy-agent files for a fresh install
sudo rm -rf /home/ubuntu/install

# install CodeDeploy agent
sudo apt update
sudo apt install ruby
sudo apt install wget

cd /home/ubuntu
wget https://aws-codedeploy-us-east-1.s3.amazonaws.com/latest/install
sudo chmod +x ./install 
sudo ./install auto

# delete app 2
sudo rm -rf /home/ubuntu/test-deploy/*

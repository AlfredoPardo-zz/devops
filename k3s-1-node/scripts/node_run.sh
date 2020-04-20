#!/bin/bash

K3S_URL=https://k3s-master:6443
TOKEN_FILE="/home/vagrant/token.txt"

if [ -f $TOKEN_FILE ]
then
	K3S_TOKEN=$(cat $TOKEN_FILE)
fi

if [ -z $K3S_TOKEN ]
then
    K3S_TOKEN=$1
    if [ -z $K3S_TOKEN ]
    then
        echo "Please provide the agent authentication token.-"
        exit 1
    fi
fi

if [ -z $K3S_TOKEN ]
then
    echo "No authentication token could be found.-"
    exit 1
else
    sudo k3s agent --docker --token $K3S_TOKEN --server $K3S_URL >& /home/vagrant/k3s_agent.log &
fi
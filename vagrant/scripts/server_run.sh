#!/bin/bash
k3s server --disable-agent --docker --write-kubeconfig ~/.kube/config --write-kubeconfig-mode 666 --tls-san $K3S_EXTERNAL_IP --kube-apiserver-arg service-node-port-range=1-65000 --kube-apiserver-arg advertise-address=$K3S_EXTERNAL_IP --kube-apiserver-arg external-hostname=$K3S_EXTERNAL_IP >& /home/vagrant/k3s_agent.log &

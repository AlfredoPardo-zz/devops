# Local Kubernetes Environment with VirtualBox using Vagrant and Ansible

## Setting up the environment

### Vagrant

1. Install vagrant-reload plugin

> **your-host$** vagrant plugin install vagrant-reload

2. Initialize the Virtual Machines

    **your-host$** vagrant up

### Manual Steps on Master Node When Setting Up

1. SSH to the master node

    > **your-host$** vagrant ssh k8s-master

  - Validate that all services are running
 
    > **k8s-master$** kubectl get pods --all-namespaces
    
  - Check if the dashboard is running
    > Navigate to: http://192.168.33.10:8001/api/v1/namespaces/kube-system/services/kubernetes-dashboard/proxy/#!/node?namespace=default 

  - Copy the kubeadm join command at the bottom of the node_config file
   
    > **k8s-master$** cat node_config
    
    i.e.
    > kubeadm join 192.168.33.10:6443 --token ***<given_token>*** \
        --discovery-token-ca-cert-hash sha256:***<sha-256_hash>***

### Manual Steps on Worker Node When Setting Up

1. SSH to the worker node

    > **your-host$** vagrant ssh k8s-node-1

  - Run the Join command **with sudo**

     > **k8s-node-1$** sudo kubeadm join 192.168.33.10:6443 --token ***<given_token>*** \
        --discovery-token-ca-cert-hash sha256:***<sha-256_hash>***

### Manual Steps on Master Node After The First Shut Down

1. You can either start Proxy manually or write a script to run at startup for that. The command to run is:

    > **k8s-master$** nohup kubectl proxy --address='0.0.0.0' --port=8001 --accept-hosts='.*' &


## Manage your cluster from the outside

1. Copy the configuration from the Master node:

> **k8s-master**$ cat /home/vagrant/.kube/config

2. Save it to a file (i.e. local-k3s-config.yaml), change the IP address from 127.0.0.1 to **192.168.33.10** and export the KUBECONFIG environment variable:

> **your-host**$ export KUBECONFIG=*<your_selected_folder>*/local-k3s-config.yaml

3. Test if kubectl works as expected:

> **your-host**$ kubectl get nodes

~~Setup your local Kubectl Environment~~
## Remove this
> $ kubectl config set-cluster k8s-test-cluster --server=http://192.168.33.10:8001
> $ kubectl config set-context k8s-test-cluster --cluster='k8s-test-cluster'
> $ kubectl config use-context k8s-test-cluster
~~

### Try to run a pod

> $ kubectl apply -f deployments/deployment.yaml

> $ kubectl delete deploy/nginx-deployment
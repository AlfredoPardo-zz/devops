# Local k3s Environment with VirtualBox using Vagrant and Ansible

## Setting Up the Environment

> **your-host**$ vagrant up

## Manual Steps

1. SSH to the k3s-master from your host:

> **your-host**$ vagrant ssh k3s-master

2. Start the k3s Master node:

> **k3s-master**$ ./server_run.sh

3. Copy the token to be used on the Worker nodes (**It may take 10 seconds to have it ready**):

> **k3s-master**$ cat /home/vagrant/.rancher/k3s/server/node-token

4. SSH to the k3s-node-1 from your host:

> **your-host**$ vagrant ssh k3s-node-1

5. Save the Master node token in a file (**Not recommended for Production environments**):

> **k3s-node-1**$ echo *your_copied_token* > token.txt

6. Start the k3s Worker node:

> **k3s-node-1**$ ./node_run.sh

7. Go back to k3s-master to validate the Worker node is ready:

> **k3s-master**$ kubectl get nodes

## Manage your cluster from the outside

1. Copy the configuration from the Master node:

> **k3s-master**$ cat /home/vagrant/.kube/config

2. Save it to a file (i.e. local-k3s-config.yaml), change the IP address from 127.0.0.1 to **192.168.33.10** and export the KUBECONFIG environment variable:

> **your-host**$ export KUBECONFIG=*<your_selected_folder>*/local-k3s-config.yaml

3. Test if kubectl works as expected:

> **your-host**$ kubectl get nodes

4. Create a Deployment (from the examples folder)

> **your-host**$ kubectl apply -f examples/nginx-deployment.yaml

5. Validate if the Pods are running (**it may take a couple of minutes for Running state**)

> **your-host**$ kubectl get pods

6. Delete the Deployment 
> **your-host**$ $ kubectl delete deploy/nginx-deployment

## Shutdown the environment

> **your-host**$ vagrant halt
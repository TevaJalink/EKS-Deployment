# EKS-Deployment
In the following document i will give an explanation about the infrastructure design and deployment process of the EKS cluster and the Nginx web page.

## Prerequisites
In order to deploy the solution 4 prerequisites are required:
1. AWS CLIv2 - required in order to run the local-exec commands for the ECR authentication.
2. Docker engine - used for docker command and image manipulation.
3. kubectl - the code deployment currently deploys version 1.29 of kubernetes so the kubectl should be compatible.
4. Terraform - terraform current latest version is 1.7.5 but every terraform versin higher then 1.3 will work.

## EKS-Infra module
The EKS-infra module provisions all the infrastructure needed to deploy a EKS cluster.

1. VPC - a virtual private cloud used to contain all the network related infrastructure.
2. Subnets - You most specify 2 public and 2 private subnets to use, the subnets are being provisioned with the relevant EKS tags that will allow for the deployemtn of private and public load balancers.
3. Internet Gateway - the internet gateway allows for the resources in the public subnets to be accesses from outside the cluster and for the resources to reach the internet.
4. nat gateway - allows resources in the private subnet to communicate with the internet.
5. Routes - the routing tables used to route traffic from inside the subnets outside.
6. ECR - elastic container registry is used to store the image used by the kubernetes_deployment resource block in the EKS-Nginx-Resources module.
7. EKS - Deployment of the actual EKS cluster and configures the local kubeconfig to access the cluster.
8. Node Group - the deployment of the managed node group used in the EKS cluster.

## EKS-Nginx-Resources module
The EKS-Nginx-Resources module provisions the modules inside the EKS cluster.

1. NameSpace - the first resource required is a namespace for the project.
2. Deployment - a EKS deployment tht pulls the nginx image from the ECR private repo.
3. Service - deployes a AWS classic load balancer to the publix subnet to publish the nginx deployment to the internet.
4. Metric Server - deployed by helm chart, the metric server provides the CPU and memory usage of pods and nodes in the cluster.
5. HPA - horizontl pod autoscaling, monitors the nginx deployment CPU usage and deploys or removes pods.
6. PDB - pod distribution budget is used the limit the amount of unavailable pods.
7. Cluster Autoscaler - used to scale the cluster nodes if needed.
8. Network Policy - used to limit the access to the nginx deployment pods.


## Execution Steps
Follow the following order to execute the solution.

1. Pull the repository using git commands.
2. Optional - create a remote state block.
3. Run terraform init to initialize terraform.
4. Run terraform apply to start provisioning process.

Can use the following code snip:
~~~
git pull https://github.com/TevaJalink/EKS-Deployment
Terrafrom init
Terraform apply -auto-approve
~~~

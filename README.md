# gpu-aws-batch

## overview
running gpu job on AWS Batch

## description
by using these scripts and commands, you can run a gpu test job on AWS Batch.
- building up base infrastructure and Docker build server for AWS Batch by CloudFormation
- CloudFormation will create...
  - VPC
  - Public Subnet
  - Security Group
  - CentOS7
  - SpotFleet Role
  - AWS Batch Service Role
  - AWS Batch Job Role
  - Docker Container repo (ECR)
  - S3 Bucket

- after the base infrastructure become ready, build AMI to enable GPU on ECS.
- build docker image and push it to AWS ECR.
- create job definition, compute environment and job queue for AWS Batch
- submit jobs to AWS Batch
- output file will be upload to S3 bucket which is created by CloudFormation

this docker image was verified with following version
centos = CentOS Linux release 7.6.1810
awscli = aws-cli/1.16.81 Python/2.7.5 Linux/3.10.0-862.3.2.el7.x86_64 botocore/1.12.71
docker-ce = Docker version 18.09.0, build 4d60db4
packer = 1.3.3


# Usage
1. login to aws console with admin
2. go to EC2
3. create a KeyPair
4. run CloudFormation for AWS Batch base infrastructure
5. login to bastion centos server
6. run centos setup script
7. build AMI for gpu ecs host
8. build Docker images with the Dockerfile
9. push the images to AWS ECR
10. edit json files based on created AWS resources
11. create job definition on AWS Batch
12. create computing environment on AWS Batch
13. create job queue on AWS Batch
14. submit jobs

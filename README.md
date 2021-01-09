# terraform-rke-vsphere
to use terraform setup a rke cluster with vsphere

## What
This repo is trying to setup two k8s clusters for RKE use.
One called "rke_dev" with 1 controller and 3 worker nodes
Another is called "rke_prod" with 3 controller and 56 worker nodes
There aint much real difference when comes to the config of controller and worker as the default settings.
We do have certain labels, roles with "master" and "worker" etc information to diff them.
Currently, packer template is used to setup corret OS to use, e.g centos

## Basic walk-thro
Config for the cluster is resident in $ROOT/projects/$cluster/*
- main.tf is the logic holder
- outputs.tf is what we expected to see when terraform runs
- provider.tf states the provider we use and the version of it
- rke.tf is the configs for rke cluster
- vsphere.tf is the configs for standard VM node

modules is the main logic for what is being called by main.tf
modules
- node for provision controllers and workers (which is just VM nodes with different capacities....)
- rke is for making master and workers server connecting in the rancher cluster after node has been properly setup

## Backend
you can choose to use artifactory, s3 or even local (not recommand for prod)
User name, credential aint in the scope of this git repo.


## Test
for local env
>cd project/<project>; rm -rf .terrform* ; terraform init -backend=false
>terraform validate

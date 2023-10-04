# Kubernetes application resiliency
All Kubernetes applications should be able to gracefully handle the deletion or restarting of a pod. However, this use case is frequently untested, and it's not until a pod restart happens after several months in production that a problem is found and the new pod will not start up successfully, leading to an outage. For example, a database pod might crash leaving its data store in an inconsistent state which the new pod cannot make sense of.

This repo provides a kubernetes cronjob. associated RBAC and container image that regularly rollout-restarts all deployments, statefulsets and daemonsets in selected namespaces. Namespaces are selected by applying the 'abesharphpe/resiliency=restart' label. The default restart period is daily at 2AM, but you can easily configure it for your needs by editing the cronjob spec in the YAML file.

## Getting started
Git clone this repo
Label all the namespaces in your cluster whose applications you want to be restarted: kubectl label ns <namespace name> abesharphpe/resiliency=restart
Apply the yaml file: kubectl apply -f *.yaml

## Advanced
Edit the Dockerfile to fine-tune the kubectl commands that select namespaces and restart the various application object types.
When done, docker build the image, then tag and push to your preferred registry. Update the image tag in the cronjob's tamplate to match.

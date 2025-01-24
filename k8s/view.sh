#!/bin/bash

#View Pods
kubectl get pods -n dev
kubectl get pods -n stage
kubectl get pods -n prod
# kubectl get pods -n kubescape


#View Service
kubectl get service -n dev
kubectl get service -n stage
kubectl get service -n prod
# kubectl get service -n kubescape
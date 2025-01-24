
#!/bin/bash

#eksctl create cluster -f eks.yml

kubectl create namespace dev

kubectl create namespace stage

kubectl create namespace prod

kubectl apply -f juice-dev.yml --namespace dev

kubectl apply -f juice-stage.yml --namespace stage

kubectl apply -f juice-prod.yml --namespace prod
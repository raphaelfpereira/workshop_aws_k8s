#!/bin/bash

function pre_install {
  sudo apt-get update -y
  sudo apt-get install unzip curl -y
}

function install_aws {
  if [ -z $(which aws) ]
    then
      sudo apt-get update
      curl "https://s3.amazonaws.com/aws-cli/awscli-bundle.zip" -o "awscli-bundle.zip"
      unzip awscli-bundle.zip
      sudo ./awscli-bundle/install -i /usr/local/aws -b /usr/local/bin/aws
      rm -rf awscli-bundle
      rm -rf awscli-bundle.zip
    else
      echo "aws is most likely installed"
  fi
}

function install_kops {
  if [ -z $(which kops) ]
    then
      curl -Lo kops https://github.com/kubernetes/kops/releases/download/1.11.0/kops-linux-amd64
      chmod +x ./kops
      sudo mv ./kops /usr/local/bin/
    else
      echo "kops is most likely installed"
  fi
}
 
function install_kubectl {
  if [ -z $(which kubectl) ]
    then
      sudo apt-get update && sudo apt-get install -y apt-transport-https
      curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
      echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee -a /etc/apt/sources.list.d/kubernetes.list
      sudo apt-get update
      sudo apt-get install -y kubectl
    else
      echo "Kubectl is most likely installed"
  fi 
}

function install_terraform {
  if [ -z $(which terraform) ]
    then
      wget https://releases.hashicorp.com/terraform/0.11.13/terraform_0.11.13_linux_amd64.zip
      unzip terraform_0.11.13_linux_amd64.zip
      sudo mv terraform /usr/local/bin/terraform
      rm -rf terraform_0.11.13_linux_amd64.zip
    else
      echo "Terraform is most likely installed"
  fi 
}

function install_docker {
  if [ -z $(which docker) ]
    then
      sudo apt-get remove docker docker-engine docker.io containerd runc -y
      sudo apt-get update
      sudo apt-get install \
          apt-transport-https \
          ca-certificates \
          curl \
          gnupg-agent \
          software-properties-common -y
      curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
      sudo apt-key fingerprint 0EBFCD88
      sudo add-apt-repository \
          "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
          $(lsb_release -cs) \
          stable"
      sudo apt-get update
      sudo apt-get install docker-ce docker-ce-cli containerd.io -y
    else
      echo "Docker is most likely installed"
  fi
}

pre_install
install_aws 
install_terraform
install_kops
install_kubectl
install_docker
# making-k8s-with-aliyun
## What is this repo
This repo is terraform sample that creates k8s cluster on your aliyun account.

## Requirements

Use [OpenAPI Explorer](https://api.alibabacloud.com/)

Or Install Software bellow
- [terraform](https://www.terraform.io/)
- [aliyun cli](https://jp.alibabacloud.com/help/doc-detail/90765.htm)
- [jq](https://stedolan.github.io/jq/)

## How to use
1. Clone this repo

```bash
git clone https://github.com/marufeuille/making-k8s-cluster-with-aliyun
cd making-k8s-cluster-with-aliyun
```

2. Configure your parameters

```bash
cp terraform.tfvars.sample terraform.tfvars
vim terraform.tfvars
```

your access key id, your secret access key id is needed.
please refer [this document](https://jp.alibabacloud.com/help/doc-detail/53045.htm).

and region id and az id that you want to deploy your k8s cluster is needed.
please refer [this document](https://www.alibabacloud.com/help/doc-detail/40654.htm)

3. Prepare PublicKey

First, create directory that public key is put.

```bash
mkdir keys
```

and copy your exits public key or create new key into output directory.

if you don't have key, create key below command.

```bash
ssh-keygen -t rsa
```

and copy public key keys dir

```bash
cp ~/.ssh/id_rsa.pub keys/
```

3. init terraform

```bash
terraform init
```

and wait a few minutes.

4. deploy your stack

```bash
terraform apply
```

Now, your k8s cluster is deployed on your account!!

5. copy k8s config to appropriate directory

by default, kubectl command explore config file in ~/.kube/config directory.

if you didn't use kubectl on this host, type commands below is easy to use k8s cluster.

```bash
mkdir -p ~/.kube
cp ~/output/config ~/.kube/
```

6. test your kubectl

type command below.

```bash
kubectl get node
```

and you find response message like below.

```
NAME                                    STATUS   ROLES    AGE   VERSION
ap-northeast-1.i-xxxxxxxxxxxxxxxxxxxx   Ready    master   1h    v1.11.5
ap-northeast-1.i-xxxxxxxxxxxxxxxxxxxx   Ready    master   1h    v1.11.5
ap-northeast-1.i-xxxxxxxxxxxxxxxxxxxx   Ready    <none>   1h    v1.11.5
ap-northeast-1.i-xxxxxxxxxxxxxxxxxxxx   Ready    master   1h    v1.11.5
```

that' all.

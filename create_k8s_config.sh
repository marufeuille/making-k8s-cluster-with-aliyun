CLUSTER_ID=$1
mkdir -p ./output
JSON=$(aliyun cs GET /k8s/${CLUSTER_ID}/user_config)
echo ${JSON} | jq -r .config > ./output/config
echo ${JSON}

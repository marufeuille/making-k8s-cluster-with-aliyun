CLUSTER_ID=$1
mkdir -p ./output
aliyun cs GET /k8s/${CLUSTER_ID}/user_config | jq -r .config > ./output/config
jq -n --arg message "OK" '{"message":$message}'

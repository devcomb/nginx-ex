#!/bin/sh
set -e
export OAUTH_AUTH_SERVER=$(curl https://${KUBERNETES_SERVICE_HOST}/.well-known/oauth-authorization-server -ks|python -c "import sys, json; print(json.load(sys.stdin)['issuer'])") 
export OS_CONSOLE_HOST="$(python -c "from urlparse import urlparse;print(urlparse('https://console.devcomb.com:8443').hostname)")"
export OS_CONSOLE_PORT="$(python -c "from urlparse import urlparse;print(urlparse('https://console.devcomb.com:8443').port)")"
export NAMESERVER=$(echo $(awk 'BEGIN{ORS=" "} $1=="nameserver" {print $2}' /etc/resolv.conf) )
envsubst '${APPWEB1_ADDR},${APPWEB2_ADDR},${APPWEB3_ADDR}'< ${NGINX_CONFIGURATION_PATH}/upstream.conf > ${NGINX_CONFIGURATION_PATH}/upstream.conf
envsubst '${AUTH_HOST},${REMOTE_WEBAPP_HOST},${GROUP_AUTH_HOST},${NAMESPACE},${SA_TOKEN},${OS_CONSOLE_HOST},${OS_CONSOLE_PORT},${GROUP_REQ}' < ${NGINX_CONFIGURATION_PATH}/subdomains.conf > ${NGINX_CONFIGURATION_PATH}/subdomains.conf
echo 1 > /tmp/health
echo "Finished convertENV.sh"

#!/bin/bash

if [ "$API_KEY" == "" ] || [ "$CS_HOST" == "" ]; then
    echo "Variables API_KEY or CS_HOST is missing"
    exit 1
else
    sed -i -e 's/  - INPUT/#  - INPUT/' \
        -e 's/#  - DOCKER-USER/   - DOCKER-USER/' \
        -e "s/127.0.0.1:8080/${CS_HOST}/" \
        -e 's#api_key: <API_KEY>#api_key: '${API_KEY}'#' \
        /etc/crowdsec/bouncers/crowdsec-firewall-bouncer.yaml
    /usr/sbin/crowdsec-firewall-bouncer -c /etc/crowdsec/bouncers/crowdsec-firewall-bouncer.yaml
fi


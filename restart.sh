#!/bin/sh

if [ "$JENKINS_USER" == "" ]; then
    export JENKINS_USER=admin
fi

curl -k -u $JENKINS_USER:$JENKINS_TOKEN $JENKINS_URL/restart -X POST --header "Jenkins-Crumb: $issuer"

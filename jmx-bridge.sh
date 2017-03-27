#!/bin/sh
alias bosh='BUNDLE_GEMFILE=/home/tempest-web/tempest/web/vendor/bosh/Gemfile bundle exec bosh'

if [ -d /var/tempest/workspaces/default/deployments ];then
    bosh deployment `ls -t /var/tempest/workspaces/default/deployments/p-metrics* | head -1`
fi

case $1 in
    start)
	echo "==== Start JMX Bridge ===="
	bosh -n start --force
	;;
    stop)
	echo "==== Stop JMX Bridge ===="
	bosh -n stop --force --hard
	;;

    *)
	echo "Usage: $0 {start|stop}" ;;
esac
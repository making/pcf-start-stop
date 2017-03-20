#!/bin/sh
alias bosh='BUNDLE_GEMFILE=/home/tempest-web/tempest/web/vendor/bosh/Gemfile bundle exec bosh'

STOP_SEQ="maximus $STOP_SEQ"
STOP_SEQ="opentsdb-firehose-nozzle $STOP_SEQ"

START_SEQ=""
for i in $STOP_SEQ;do
    START_SEQ="$i $START_SEQ"
done

if [ -d /var/tempest/workspaces/default/deployments ];then
    bosh deployment `ls /var/tempest/workspaces/default/deployments/p-metrics*`
fi

case $1 in
    start)
	echo "==== Start CF ===="
	for i in $START_SEQ;do
	    echo "start $i"
	    bosh -n start --force $i
	done
	;;
    stop)
	echo "==== Stop CF ===="
	for i in $STOP_SEQ;do
	    echo "stop $i"
	    bosh -n stop --force --hard $i
	done
	;;

    *)
	echo "Usage: $0 {start|stop}" ;;
esac

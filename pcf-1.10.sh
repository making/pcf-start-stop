#!/bin/sh
alias bosh='BUNDLE_GEMFILE=/home/tempest-web/tempest/web/vendor/bosh/Gemfile bundle exec bosh'

STOP_SEQ="mysql $STOP_SEQ"
STOP_SEQ="mysql_proxy $STOP_SEQ"
STOP_SEQ="mysql_monitor $STOP_SEQ"
STOP_SEQ="consul_server $STOP_SEQ"
STOP_SEQ="nats $STOP_SEQ"
STOP_SEQ="etcd_tls_server $STOP_SEQ"
STOP_SEQ="uaa $STOP_SEQ"
# STOP_SEQ="nfs_server $STOP_SEQ"
STOP_SEQ="cloud_controller $STOP_SEQ"
# STOP_SEQ="ha_proxy $STOP_SEQ"
STOP_SEQ="router $STOP_SEQ"
STOP_SEQ="clock_global $STOP_SEQ"
STOP_SEQ="cloud_controller_worker $STOP_SEQ"
STOP_SEQ="diego_database $STOP_SEQ"
STOP_SEQ="diego_brain $STOP_SEQ"
STOP_SEQ="diego_cell $STOP_SEQ"
STOP_SEQ="doppler $STOP_SEQ"
STOP_SEQ="loggregator_trafficcontroller $STOP_SEQ"

START_SEQ=""
for i in $STOP_SEQ;do
    START_SEQ="$i $START_SEQ"
done

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

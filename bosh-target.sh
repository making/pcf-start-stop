#!/bin/sh
set -e

if [ "x`which expect`" == "x" ];then
	sudo apt-get update -y
	sudo apt-get install -y expect
fi

export BUNDLE_GEMFILE=/home/tempest-web/tempest/web/vendor/bosh/Gemfile
expect -c "
set timeout 5
spawn bundle exec bosh --ca-cert /var/tempest/workspaces/default/root_ca_certificate target ${BOSH_DIRECTOR_IP}
expect \"Email:\"
send \"${BOSH_USER}\n\"
expect \"Password:\"
send \"${BOSH_PASSWORD}\n\"
interact
" > /dev/null

expect -c "
set timeout 5
spawn bundle exec bosh login
expect \"Email:\"
send \"${BOSH_USER}\n\"
expect \"Password:\"
send \"${BOSH_PASSWORD}\n\"
interact
" > /dev/null

bundle exec bosh status

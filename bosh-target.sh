#!/bin/sh
alias bosh='BUNDLE_GEMFILE=/home/tempest-web/tempest/web/vendor/bosh/Gemfile bundle exec bosh'

if [ "x`which expect`" == "x" ];then
	sudo apt-get install -y expect
fi

env

expect -c "
set timeout 5
spawn bosh --ca-cert /var/tempest/workspaces/default/root_ca_certificate target ${BOSH_DIRECTOR_IP}
expect \"Email:\"
send \"${BOSH_USER}\n\"
expect \"Password:\"
send \"${BOSH_PASSWORD}\n\"
exit 0
"
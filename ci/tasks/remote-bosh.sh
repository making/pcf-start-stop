#!/bin/sh
set -e
cat > ~/opsmgr_ssh <<EOF
${OPSMGR_SSH_KEY}
EOF
chmod 400 ~/opsmgr_ssh
SSH_OPTS="-oStrictHostKeyChecking=no -i ~/opsmgr_ssh"
SSH_TARGET=${OPSMGR_SSH_USER}@${OPSMGR_HOST}
ID=`date +%s`
rm -rf pcf-start-stop/.git
echo "export BOSH_USER=${BOSH_USER}" >> .bosh
echo "export BOSH_PASSWORD=${BOSH_PASSWORD}" >> .bosh
BOSH="BUNDLE_GEMFILE=/home/tempest-web/tempest/web/vendor/bosh/Gemfile bundle exec bosh"
ssh ${SSH_OPTS} ${SSH_TARGET} "mkdir /tmp/${ID}"
scp ${SSH_OPTS} -r pcf-start-stop ${SSH_TARGET}:/tmp/${ID}/ > /dev/null
scp ${SSH_OPTS} .bosh ${SSH_TARGET}:/tmp/${ID}/ > /dev/null
ssh ${SSH_OPTS} ${SSH_TARGET} "source /tmp/${ID}/.bosh && bash /tmp/${ID}/pcf-start-stop/bosh-target.sh"
ssh ${SSH_OPTS} ${SSH_TARGET} "${BOSH_CMD}"
ssh ${SSH_OPTS} ${SSH_TARGET} "rm -rf /tmp/${ID}"
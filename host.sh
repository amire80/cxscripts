#!/bin/bash

db="${language}wiki"
echo ""
echo "running for $db"
# Read configuration.
. /etc/profile.d/mediawiki.sh
MWMULTIDIR=$MEDIAWIKI_DEPLOYMENT_DIR/multiversion

host=`echo 'echo wfGetLB()->getServerName(0);' | /usr/local/bin/mwscript eval.php --wiki="$db"`

echo $host;


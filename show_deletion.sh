#!/bin/bash
date=$1
if [ -z $date ]; then
	date=`date --date=yesterday +%Y%m%d`
fi

language=$2
if [ -z $language ]; then
	language=en
fi

echo "Deletions on $date in $language"

query="SELECT ar_id, ar_title FROM \`change_tag\`, \`archive\` WHERE ar_timestamp like '$date%' AND ar_namespace = 0 AND ct_tag = 'contenttranslation' AND ar_rev_id = ct_rev_id ORDER BY NULL;"

db="${language}wiki"

# Read configuration.
. /etc/profile.d/mediawiki.sh
MWMULTIDIR=$MEDIAWIKI_DEPLOYMENT_DIR/multiversion

host=`echo 'echo wfGetLB()->getServerName(0);' | /usr/local/bin/mwscript eval.php --wiki="$db"`

# MySQL user credentials.
MU=wikiadmin
MP=`wikiadmin_pass`

# Execute mysql.
mysql -u $MU -p$MP -h $host -D $db -e "$query" | grep "[0-9]"


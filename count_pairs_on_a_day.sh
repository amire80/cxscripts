#!/bin/bash
source_lang=$1
target_lang=$2

if [ -z $source_lang ] || [ -z $target_lang  ]; then
	echo "You must specify source and target languages."
	exit
fi

date=$3
if [ -z $date ]; then
	date=`date --date=yesterday +%Y%m%d`
fi

echo "Translations from $source_lang to $target_lang on $date"

query_beginning="select count(*) from cx_translations where"
query_published_cond="(translation_status = 'published' or translation_target_url is not null)"
query_end="translation_source_language = '$source_lang' and translation_target_language = '$target_lang' and translation_start_timestamp like '$date%';"

published_query="$query_beginning $query_published_cond and $query_end"
all_query="$query_beginning $query_end"

# MySQL user credentials
MU=wikiadmin
MP=`echo 'echo \$wgDBadminpassword;' | /usr/local/bin/mwscript eval.php --wiki="enwiki"`

# Execute mysql
echo "Published:"
mysql -u $MU -p$MP -h db1029 -D wikishared -e "$published_query"

echo "All:"
mysql -u $MU -p$MP -h db1029 -D wikishared -e "$all_query"


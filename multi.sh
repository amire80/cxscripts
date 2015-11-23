#!/bin/bash

query=$1

# ALL
# for language in aa ab ace af ak als am ang an arc ar arz ast as av ay az bar bat_smg ba bcl be_x_old be bg bh bi bjn bm bn bo bpy br bs bug bxr ca cbk_zam cdo ceb ce cho chr ch chy ckb co crh cr csb cs cu cv cy da de diq dsb dv dz ee el eml en eo es et eu ext fa ff fiu_vro fi fj fo frp frr fr fur fy gag gan ga gd glk gl gn gom got gu gv hak ha haw he hif hi ho hr hsb ht hu hy hz ia id ie ig ii ik ilo io is it iu ja jbo jv kaa kab ka kbd kg ki kj kk kl km kn koi ko krc kr ksh ks ku kv kw ky lad la lbe lb lez lg lij li lmo ln lo lrc ltg lt lv mai map_bms mdf mg mhr mh min mi mk ml mn mrj mr ms mt mus mwl myv my mzn nah nap na nds_nl nds ne new ng nl nn nov no nrm nso nv ny oc om or os pag pam pap pa pcd pdc pfl pih pi pl pms pnb pnt ps pt qu rm rmy rn roa_rup roa_tara ro rue ru rw sah sa scn sco sc sd se sg sh simple si sk sl sm sn so sq srn sr ss stq st su sv sw szl ta tet te tg th ti tk tl tn to tpi tr ts tt tum tw tyv ty udm ug uk ur uz vec vep ve vi vls vo war wa wo wuu xal xh xmf yi yo za zea zh_classical zh_min_nan zh_yue zh zu

# BIG ONES
#for language in ar be be_x_old bg ca cs da de el en eo es et fa fi fr gl he hr hu hy id is it ja ka kg kk kn ko lt lv mk ml mn mr ms nl nn no oc or os pa pl pnb pt ro ru sah sh simple sk sl sq sr sv sw ta te tg th tl tr tt uk ur uz vi xh zh_yue zh zu

for language in en
do
	db="${language}wiki"
	echo ""
	echo "running for $db"
	# Read configuration.
	. /etc/profile.d/mediawiki.sh
	MWMULTIDIR=$MEDIAWIKI_DEPLOYMENT_DIR/multiversion

	host=`echo 'echo wfGetLB()->getServerName(0);' | /usr/local/bin/mwscript eval.php --wiki="$db"`

	# MySQL user credentials.
	MU=wikiadmin
	MP=`wikiadmin_pass`

	# Execute mysql.
	mysql -u $MU -p$MP -h $host -D $db -e "$query"
done


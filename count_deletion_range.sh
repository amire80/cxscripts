#!/bin/bash

firstDay=$1
lastDay=$2

for date in $(eval echo "{$firstDay..$lastDay}")
do
	./count_deletion.sh $date
done


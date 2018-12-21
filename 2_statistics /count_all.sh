#! /bin/bash
#
#count the number of all the entities in terms of entity type 
#


for f in `find  /var/lib/docker/volumes/brat-data/_data/netgovern/ -name '*.ann'`
	do cat $f >> all.txt
	done

while read line;
	do count=`grep -c "$line" all.txt`; 
	echo $line $count; 
	done < entities.type

rm -i all.txt

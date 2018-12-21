#! /bin/bash
#
# count the number of documents that contain the same type of entity
#


TARGETDI="/var/lib/docker/volumes/brat-data/_data/netgovern"
entities=( $(awk '{print $1}' ./entities.type) )
declare  number=()
for ((idx=0; idx<${#entities[@]}; ++idx))
	do
	#	echo "$idx" "${entities[idx]}"
		number[$idx]=0
	#	echo "${number[$idx]}"	
	done



for file in $(find "$TARGETDI" -name "*.ann" -type f -size +1c)
        do
		for ((idx=0; idx<${#entities[@]}; ++idx))
        do
        	grep -q "${entities[idx]}" $file  &&  number[idx]=$((number[idx]+1))
	#	echo "${number[$idx]}"	
	done
	done


for ((idx=0; idx<${#entities[@]}; ++idx))
	do		
		echo "${entities[$idx]} ${number[$idx]}"	
	done


#! /bin/bash
#
# collect the documents which are labled as PCI as well as their .ann files
#

#path
TARGETDI="/var/lib/docker/volumes/brat-data/_data/netgovern/PCI"
TARGETDI1="/var/lib/docker/volumes/brat-data/_data/netgovern/sosp"
TARGETDI2="/var/lib/docker/volumes/brat-data/_data/netgovern/new_sosp"


#the first folder
for file in $(find "$TARGETDI1" -name "*.ann" -type f -size +1c)
        do
        	if grep -q "DOC_PCI" $file  
		then
		cp $file "$TARGETDI"
		cp "${file%.*}.txt" "$TARGETDI"
		echo "$file"
		fi	
	done

#the second folder
for file in $(find "$TARGETDI2" -name "*.ann" -type f -size +1c)
        do
        	if grep -q "DOC_PCI" $file  
		then
		cp $file "$TARGETDI"
		cp "${file%.*}.txt" "$TARGETDI"
		echo "$file"
		fi	
	done



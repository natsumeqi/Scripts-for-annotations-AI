#! /bin/bash
#
# collect the documents which are labled as PHI as well as their .ann files, 
# in order to generate the json file for traning
#

#path
TARGETDI="/var/lib/docker/volumes/brat-data/_data/netgovern/phi_train_data"
SOURCE1="/var/lib/docker/volumes/brat-data/_data/netgovern/sosp"
SOURCE2="/var/lib/docker/volumes/brat-data/_data/netgovern/new_sosp"


#the first folder
for file in $(find "$SOURCE1" -name "*.ann" -type f -size +1c)
        do
        	if grep -q "DOC_PHI" $file  
		then
		cp $file "$TARGETDI/phi"
		cp "${file%.*}.txt" "$TARGETDI/phi"
		echo "$file"
		fi	
	done

#the second folder
for file in $(find "$SOURCE2" -name "*.ann" -type f -size +1c)
        do
        	if grep -q "DOC_PHI" $file  
		then
		cp $file "$TARGETDI/phi"
		cp "${file%.*}.txt" "$TARGETDI/phi"
		echo "$file"
		fi	
	done



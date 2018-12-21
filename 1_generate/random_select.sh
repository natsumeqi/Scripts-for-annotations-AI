#!/bin/bash
#
# randomly select documents that have been annotated
# make sure that create a new directory under the BART_PATH

BRAT_PATH="/var/lib/docker/volumes/brat-data/_data/netgovern"

for f in `find /var/lib/docker/volumes/brat-data/_data/netgovern  -name '*.ann'  -size +1c`
        do ls $f >> all_annotated.txt
        done

sed -e 's/.ann/.txt/' all_annotated.txt > all_annotatedtxt.txt



echo "Enter the number of documents:"
read num

echo "Enter the target directory"
read targetDir

shuf -n $num all_annotatedtxt.txt > selected_doc.txt
while read line
	do
	echo $line
	cp $line $BRAT_PATH/$targetDir
 	id=`basename -s .txt $line`
        echo $id.ann
	echo >$BRAT_PATH/$targetDir/$id.ann
	done < selected_doc.txt


chmod -R 777 $BRAT_PATH/$targetDir/*


rm  all_annotated.txt
rm  all_annotatedtxt.txt
rm -i seleted_doc.txt

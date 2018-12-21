#!/bin/sh
#
# delete duplicated files in the new directory where new documents are exported from Solr and stored
# as well as delete duplicated files which have been annotated in old dataset(SOSP)
# Before run this script, please check the PATH 
declare -A filecksums

#the max size of files in the new directory
maxSize=204800


#input the name of the new directory
while true
do
  echo "Enter the name fo the target directory:"
  read directory
  if [ -d /home/netmail/$directory ]; then
    break
  else
    echo "Invalid directory"
  fi
done

#PATH
SOSP_PATH="/var/lib/docker/volumes/brat-data/_data/netgovern/sosp"
NEW_PATH="/var/lib/docker/volumes/brat-data/_data/netgovern/new_sosp"
OUT_PATH="/home/netmail/$directory"


#the method to iteratively read the new directory
function read_directory(){
	for dir in ` ls $1 `
		do
		if [ -d $1"/"$dir ]
                then
		find $1"/"$dir -type f -name '*.ann'  -size +0  |awk -F "/" '{print $NF}'  >> P2_file.txt
		fi
		done
}



#delete duplicated files (the same contents with different filenames) in the new directory
FILES=$OUT_PATH/*.txt
for file in $FILES
	do
	# Files only (also no symlinks)
	[[ -f "$file" ]] && [[ ! -h "$file" ]] || continue

	# Generate the checksum
	cksum=$(cksum <"$file" | tr ' ' _)

	# Have we already got this one?
	if [[ -n "${filecksums[$cksum]}" ]] && [[ "${filecksums[$cksum]}" != "$file" ]]
	then
        echo "Found '$file' is a duplicate of '${filecksums[$cksum]}'" >&2
        rm -f "$file"
	rm "${file%.*}.ann"
	else
        filecksums[$cksum]="$file"
   	fi
done

#delete files that are larger than a specific size
#the varabile (maxSize) is on top 
for filename in $FILES; do
        actualSize=$(wc -c <"$filename")
        if [ $actualSize -ge $maxSize ]
        then
                echo "$filename size is over $maxSize bytes"
                rm $filename
                rm "${filename%.*}.ann"
        fi
done


#generate P1 text file that contains the names of new ann files
find $OUT_PATH -type f -name '*.ann' |awk -F "/" '{print $NF}'   > P1_file.txt

#generate P2 text file that contains the names of old ann files (from sosp and new_sosp)
read_directory $SOSP_PATH
read_directory $NEW_PATH

#compare two txt files, then delete the duplicated documents stored in comm_deleted.txt
sort P1_file.txt > sP1.txt
sort P2_file.txt > sP2.txt
comm -12 sP1.txt sP2.txt > comm_deleted.txt
while read line
	do 
	echo $line
	id=`basename -s .ann $line`
	echo $id.txt
	rm $OUT_PATH/$line
	rm $OUT_PATH/$id.txt
	done < comm_deleted.txt



rm P2_file.txt

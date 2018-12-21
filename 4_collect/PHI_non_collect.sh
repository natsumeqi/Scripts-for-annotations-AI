#! /bin/bash
#
# randomly collect the documents which are not labled as PHI, as well as .ann. files
# in order to generate to the JSON file for training
# Caution: first move the ssn folder from the sosp folder to somewhere else

#path
TARGETDI="/var/lib/docker/volumes/brat-data/_data/netgovern/phi_train_data"
SOURCE_FP="/var/lib/docker/volumes/brat-data/_data/netgovern/ssn"
SOURCE_TN="/var/lib/docker/volumes/brat-data/_data/netgovern/sosp"

#input
echo "Enter the number of documents(half of the number of PCI documents):"
read num

echo "Enter the target directory"
read target_dir


#collect from the ssn folder
for file in $(find "$SOURCE_FP" -name "*.ann" -type f -size +1c)
        do
        	if grep -q "DOC_PHI" $file  
		then
		echo 
		else
		ls $file >> non_PHI_FP_ann.txt
		fi	
	done

shuf -n $num  non_PHI_FP_ann.txt > non_PHI_FP_shuf.txt

while read line 
	do 
	echo $line
	cp $line "$TARGETDI/$target_dir"
	cp "${line%.*}.txt" "$TARGETDI/$target_dir"
	done < non_PHI_FP_shuf.txt

rm  non_PHI_FP_ann.txt


#collect from the other folders
for file in $(find "$SOURCE_TN" -name "*.ann" -type f -size +1c)
        do
        	if grep -q "DOC_PCI" $file  
		then
		echo
		else
		ls $file >> non_PHI_TN_ann.txt
		fi	
	done



shuf -n $num  non_PHI_TN_ann.txt > non_PHI_TN_shuf.txt


while read line 
	do 
	echo $line
	cp $line "$TARGETDI/$target_dir"
	cp "${line%.*}.txt" "$TARGETDI/$target_dir"
	done < non_PHI_TN_shuf.txt


rm  non_PHI_TN_ann.txt

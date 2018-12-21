#! /bin/bash
#
# randomly collect the documents which are not labled as PCI, as well as .ann. files
# Caution: first move the creditCard folder from the sosp folder to somewhere else

#path
TARGETDI="/var/lib/docker/volumes/brat-data/_data/netgovern/pci_train_data"
SOURCE_FP="/var/lib/docker/volumes/brat-data/_data/netgovern/creditCard"
SOURCE_TN="/var/lib/docker/volumes/brat-data/_data/netgovern/sosp"

#input
echo "Enter the number of documents(half of the number of PCI documents):"
read num

echo "Enter the target directory"
read target_dir


#collect from the creaditCard folder
for file in $(find "$SOURCE_FP" -name "*.ann" -type f -size +1c)
        do
        	if grep -q "DOC_PCI" $file  
		then
		echo 
		else
		ls $file >> non_PCI_FP_ann.txt
		fi	
	done

shuf -n $num  non_PCI_FP_ann.txt > non_PCI_FP_shuf.txt

while read line 
	do 
	echo $line
	cp $line "$TARGETDI/$target_dir"
	cp "${line%.*}.txt" "$TARGETDI/$target_dir"
	done < non_PCI_FP_shuf.txt

rm  non_PCI_FP_ann.txt


#collect from the other folders
for file in $(find "$SOURCE_TN" -name "*.ann" -type f -size +1c)
        do
        	if grep -q "DOC_PCI" $file  
		then
		echo
		else
		ls $file >> non_PCI_TN_ann.txt
		fi	
	done



shuf -n $num  non_PCI_TN_ann.txt > non_PCI_TN_shuf.txt


while read line 
	do 
	echo $line
	cp $line "$TARGETDI/$target_dir"
	cp "${line%.*}.txt" "$TARGETDI/$target_dir"
	done < non_PCI_TN_shuf.txt

rm  non_PCI_TN_ann.txt

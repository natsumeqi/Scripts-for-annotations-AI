#! /bin/bash
#
# check the correctness of type of documents, like PII, PCI, PHI
# for example, if a document has an annotation as SSN, it should be labled as PHI
# to find these cases, first enter "ssn", then enter "DOC_PHI"



echo "Enter the first entity(annotated):"
read anno

echo "Enter the second entity(not annotated)"
read not_anno

for file in `find /var/lib/docker/volumes/brat-data/_data/netgovern  -name "*.ann" -type f -size +1c`       
        do
               if  grep -q "$anno" $file  
		then
                   if  grep -q "$not_anno" $file 
		       then
				continue 
			else               
			        echo "$file"
                        fi
		else
			continue                
                fi                
        done
    


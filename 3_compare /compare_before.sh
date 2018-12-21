#! /bin/bash
#
# process the format in order to calculate Cohen's kappa coefficient
# modify the path before using
# the first directory is for the first annotator, containing documents
# the secod directory is for the second annotator, containing documents
# then execute compare_anno1.py


for  f in `find  /....../yanqi -name '*.ann'`
        do cat $f > all_yanqi_temp.txt
        awk '{print $2,$5}' all_yanqi_temp.txt  >> all_yanqi_content.txt
        done


for  f in `find  /....../victor -name '*.ann'`
        do cat $f > all_victor_temp.txt
        awk '{print $2,$5}' all_victor_temp.txt  >> all_victor_content.txt
        done


sort all_yanqi_content.txt >all_yanqi_content_sorted.txt
sort all_victor_content.txt >all_victor_content_sorted.txt
comm all_yanqi_content_sorted.txt all_victor_content_sorted.txt -1 -2 >common.txt
comm all_yanqi_content_sorted.txt all_victor_content_sorted.txt -2 -3 >special_yanqi.txt
comm all_yanqi_content_sorted.txt all_victor_content_sorted.txt -1 -3 >special_victor.txt


rm all_yanqi_temp.txt
rm all_victor_temp.txt
rm all_yanqi_content.txt
rm all_victor_content.txt
rm all_yanqi_content_sorted.txt
rm all_victor_content_sorted.txt

#!/usr/bin/python
#generate a csv file from a json file for training models
#check whether a document has the PCI lable
#check whether a document has patterns matched to creditcard number regex
import os,sys
import json
import re

try:
    inFile = sys.argv[1]
except:
    usage = "process.py file.json\n"
    sys.stderr.write(usage)
    sys.exit(0)

#regex
regex_number_old = [   "5[1-5][0-9]{2}[\\s][0-9]{4}[\\s][0-9]{4}[\\s][0-9]{4}",
                      "5[1-5][0-9]{2}[0-9]{4}[0-9]{4}[0-9]{4}",
                      "4[0-9]{3}([\\- ]?)[0-9]{4}([\\- ]?)[0-9]{4}([\\- ]?)[0-9]{4}",
                      "3[47][0-9][0-9]([\\- ]?)[0-9]{4}([\\- ]?)[0-9]{4}([\\- ]?)[0-9]{4}",
                      "3(0[0-5]|68[0-9])[0-9]{3}([\\- ]?)[0-9]{4}([\\- ]?)[0-9]{4}",
                      "6(011|5[0-9]{2})[0-9]{12}",
                      "(2131|1800|35[0-9]{3})[0-9]{11}"]
regex_number = ["\\b(?:5[1-5][0-9]{2}|222[1-9]|22[3-9][0-9]|2[3-6][0-9]{2}|27[01][0-9]|2720)[\\s-]*?[0-9]{4}[\\s-]*?[0-9]{4}[\\s-]*?[0-9]{4}(\\D|$)",		# Mastercard
				"\\b4[0-9]{3}[\\s-]*?[0-9]{4}[\\s-]*?[0-9]{4}[\\s-]*?[0-9]{4}(\\D|$)",																		# Visa
				"\\b3[47][0-9]{2}[\\s-]*?[0-9]{6}[\\s-]*?[0-9]{5}(\\D|$)", 																					# American Express
				"\\b3[47][0-9]{2}[\\s-]*?[0-9]{4}[\\s-]*?[0-9]{4}[\\s-]*?[0-9]{3}(\\D|$)",																	# American Express
				"\\b3(?:0[0-5]|[68][0-9])[0-9][\\s-]*?[0-9]{6}[\\s-]*?[0-9]{4,7}(\\D|$)", 																	# Diners Club
				"\\b3(?:0[0-5]|[68][0-9])[0-9][\\s-]*?[0-9]{4}[\\s-]*?[0-9]{4}[\\s-]*?[0-9]{2,5}(\\D|$)", 													# Diners Club
				"\\b6(011|5[0-9]{2})[\\s-]*?[0-9]{4}[\\s-]*?[0-9]{4}[\\s-]*?[0-9]{4,7}(\\D|$)",																# Discover
				"\\b(?:2131|1800|35[0-9]{2})[\\s-]*?[0-9]{4}[\\s-]*?[0-9]{4}[\\s-]*?[0-9]{3,4,6,7}(\\D|$)" 													# JCB
				"\\b62[0-9]{2}[\\s-]*?[0-9]{4}[\\s-]*?[0-9]{4}[\\s-]*?[0-9]{4,7}(\\D|$)",																	# UnionPay
				"\\b(?:6304|6706|6771|6709)[\\s-]*?[0-9]{4}[\\s-]*?[0-9]{4}[\\s-]*?[0-9]{4}[\\s-]*?[0-9]{2}(\\D|$)" 										# Laser
				]






f = open("pci.csv", "w")
f.write ("%s,%s,%s,%s\n" %("id","size","label","number"))



with open(inFile,"r") as r:
    trainDocs = json.load(r)
    for doc in trainDocs:
        docId = doc['id']
        size = len(doc['text'])
        label = doc['label']
        if label == "NON_PCI":
            label = "0"
        else:
            label = "PCI"
        for pattern in regex_number:
        	number_result = re.search(pattern,doc['text'])
        	if number_result:
        		number = number_result.group(0)
        		break
        	else:
        		number = "0"	
        f.write ("%s,%s,%s,%s\n" %(docId,size,label,number))
f.close()

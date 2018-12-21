#!/usr/bin/python
import os,sys,itertools,re
from fuzzywuzzy import fuzz

try:
	targetFolder = sys.argv[1]
except:
	usage = "targetFolder\n"
	sys.stderr.write(usage)
	sys.exit(0)


os.chdir(r'/home/netmail/yanqi/medicalRecord')

def list_flies(directory, extension):
	return (f for f in listdir(directory) if f.endwith('.' + extension))



files = os.listdir(list_files(targetFolder, "txt"))
for file1, file2 in itertools.combinations(files, 2):
	readFile = open(file1,'r')
        fileText1 = readFile.read().replace('\n','')
	text1 = re.sub(' +',' ',fileText1)
        readFile.close()
        readFile = open(file2,'r')
        fileText2 = readFile.read().replace('\n','')
	text2 = re.sub(' +',' ',fileText2)
	readFile.close()
        ratio = fuzz.ratio(text1, text2)
        print ratio
	if ratio > 45:
		print text1
		print("\n***************************************************\n")
	#	print text2
		print ("delete " + text2)

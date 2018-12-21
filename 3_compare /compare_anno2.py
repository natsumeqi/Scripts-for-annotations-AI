#!/usr/bin/python
#compare the annotations from two annotators by calculating Cohen's kappa coefficient
#a second method using dictionaries
#no pre-step needed
import os,sys
from sklearn.metrics import cohen_kappa_score


#entity type list
entities = ['DOC_PII', 'DOC_PCI', 'DOC_PHI', 'DOC_AUTOGEN', 'DOC_REVIEWED', 'Name', 'MaidenName', 'DateOfBirth', 'DateOfDeath', 'IP', 'MAC', 'URL', 'Email', 'Fax', 'PhoneNumber', 'Citizenship', 'Religion', 'Race', 'Weight', 'Height', 'PersonTitleOrOccupation', 'School', 'StreetOfResidence', 'CityOfResidence', 'StateOrProvinceOfResidence', 'CountryOfResidence', 'zipCodeOfResidence', 'StreetOfBirth', 'CityOfBirth', 'StateOrProvinceOfBirth', 'CountryOfBirth', 'zipCodeOfBirth', 'StreetOfDeath', 'CityOfDeath', 'StateOrProvinceOfDeath', 'CountryOfDeath', 'OtherStreetOfResidence', 'OtherCityOfResidence', 'OtherStateOrProvinceOfResidence', 'OtherCountryOfResidence', 'OtherZipCode', 'OtherUrl', 'OtherEmail', 'OtherPhoneNumber', 'OtherFax', 'MotherMaidenName', 'AlternateName', 'PassportNumber', 'DriverLicense', 'TaxPayerId', 'FinancialAccount', 'VehicleRegistration', 'MedicalRecordId', 'SSN', 'HealthPlanBeneficiary', 'PatientId', 'DeviceIdentifier', 'CreditCardNumber', 'ExpirationDate', 'CardVerificationValue']


#the first list
lst_yanqi = []
for i in range(len(entities)):
        lst_yanqi.append([])

#the second list
lst_victor = []
for i in range(len(entities)):
    lst_victor.append([])

#tow dictionaries
dict_yanqi={}
dict_victor={}


#the unique annotations from the first annotator
path1="/....../yanqi/"
for filename in os.listdir(path1):
    if filename.endswith(".ann"):
        with open(os.path.join(path1,filename)) as f:
		cnt=f.readlines()
		for line in cnt:
            		if len(line.split()) == 0:
                		continue
           		lineSplited=line.split("\t")
            		strEntityPos=lineSplited[1].split()
            		idTotal=filename[:-4]+strEntityPos[0]+"-"+strEntityPos[1]
            		annContent=lineSplited[2].strip("\n")
            		dict_yanqi[idTotal]=annContent



path2="/....../victor/"
for filename in os.listdir(path2):
    if filename.endswith(".ann"):
        with open(os.path.join(path2,filename)) as f:
                cnt=f.readlines()
                for line in cnt:
                        if len(line.split()) == 0 or line[0]!='T':
                                continue
                        lineSplited=line.split("\t")
                        strEntityPos=lineSplited[1].split()
                        idTotal=filename[:-4]+strEntityPos[0]+"-"+strEntityPos[1]
                        annContent=lineSplited[2].strip("\n")
                        dict_victor[idTotal]=annContent

#print len(dict_yanqi)
#print len(dict_victor)

#set processing
diff_1 = set(dict_yanqi.keys())-set(dict_victor.keys())
diff_2 = set(dict_victor.keys())-set(dict_yanqi.keys())
shared = set(dict_victor.keys()) & set(dict_yanqi.keys())
print(len(diff_1))
print(len(diff_2))
print(len(shared))


for k in diff_1:
	dict_victor[k]=""


for k in diff_2:
	dict_yanqi[k]=""


#print len(dict_yanqi)
#print len(dict_victor)


for k in dict_yanqi:
	idx = entities.index( str(k)[64:].split("-")[0])
	lst_yanqi[idx].append(dict_yanqi[k])
	lst_victor[idx].append(dict_victor[k])



for i in range(len(entities)):
#    	lst_yanqi[i].sort(reverse=True)
#	lst_victor[i].sort(reverse=True)
	print(entities[i]+"\t"+str(cohen_kappa_score(lst_yanqi[i], lst_victor[i])))



print lst_yanqi[0]
print lst_victor[0]












#!/usr/bin/python
#compare the annotations from two annotators by using Cohen's kappa coefficient
#pre-step is compare_before.sh


import os,sys
from sklearn.metrics import cohen_kappa_score 


#entity type list
entities = ['DOC_PII', 'DOC_PCI', 'DOC_PHI', 'DOC_AUTOGEN', 'DOC_REVIEWED', 'Name', 'MaidenName', 'DateOfBirth', 'DateOfDeath', 'IP', 'MAC', 'URL', 'Email', 'Fax', 'PhoneNumber', 'Citizenship', 'Religion', 'Race', 'Weight', 'Height', 'PersonTitleOrOccupation', 'School', 'StreetOfResidence', 'CityOfResidence', 'StateOrProvinceOfResidence', 'CountryOfResidence', 'zipCodeOfResidence', 'StreetOfBirth', 'CityOfBirth', 'StateOrProvinceOfBirth', 'CountryOfBirth', 'zipCodeOfBirth', 'StreetOfDeath', 'CityOfDeath', 'StateOrProvinceOfDeath', 'CountryOfDeath', 'OtherStreetOfResidence', 'OtherCityOfResidence', 'OtherStateOrProvinceOfResidence', 'OtherCountryOfResidence', 'OtherZipCode', 'OtherUrl', 'OtherEmail', 'OtherPhoneNumber', 'OtherFax', 'MotherMaidenName', 'AlternateName', 'PassportNumber', 'DriverLicense', 'TaxPayerId', 'FinancialAccount', 'VehicleRegistration', 'MedicalRecordId', 'SSN', 'HealthPlanBeneficiary', 'PatientId', 'DeviceIdentifier', 'CreditCardNumber', 'ExpirationDate', 'CardVerificationValue']

#the first list
lst_yanqi = []
print(len(entities))
for i in range(len(entities)):
	lst_yanqi.append([])

#the second list
lst_victor = []
for i in range(len(entities)):
    lst_victor.append([])

#the common annotations
f=open("/....../common.txt","r")
cnt=f.readlines()
for line in cnt:
	if len(line.split()) == 0:	        
		continue
	lineSplited=line.split()
	idx = entities.index(lineSplited[0])
	lst_yanqi[idx].append(lineSplited[1])
	lst_victor[idx].append(lineSplited[1])
f.close()

#the unique annotations from the first annotator
f=open("/....../special_yanqi.txt","r")
cnt=f.readlines()
for line in cnt:
	if len(line.split()) == 0:
        	continue
	lineSplited=line.split()
	idx = entities.index(lineSplited[0])
	lst_yanqi[idx].append(lineSplited[1])
	lst_victor[idx].append("")
f.close()

#the second annotations from the second annotator
f=open("/....../special_victor.txt","r")
cnt=f.readlines()
for line in cnt:
	if len(line.split()) == 0:
		continue
	lineSplited=line.split()
	idx = entities.index(lineSplited[0])	
	lst_victor[idx].append(lineSplited[1])
	lst_yanqi[idx].append("")
f.close()


#display the scores
for i in range(len(entities)):
    print(entities[i]+"\t"+str(cohen_kappa_score(lst_yanqi[i], lst_victor[i])))


#delete temp files
rm -i common.txt
rm -i special_victor.txt
rm -i special_yanqi.txt

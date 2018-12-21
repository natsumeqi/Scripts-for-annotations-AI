#!/usr/bin/python

import os,sys
import json

file = open("phiData_before_dumps.json","r")
data = file.read()
file.close()
data=json.loads(data),
print(type(data))


json=json.dumps(data)
# print(json)
with open("phiData_after_dumps.json","w") as f:
	f.write(json)
f.close()

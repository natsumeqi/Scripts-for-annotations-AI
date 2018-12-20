# Scripts-for-annotations-AI
Some scripts used for processing documents
  Please check the path variable listed on top in these scripts before using.

## 1_Generate
  delete_deuplicated.sh 
    delete duplicated files in the new directory where new documents are exported from Solr and stored; 
    delete duplicated files which have been annotated in old dataset(SOSP)
  random_select.sh 
    randomly select documents that have been annotated for cross-annotation
## 2_statistics
  count_all.sh
    count the number of all the entities in terms of entity type
  count.sh
    count the number of documents that contain the same type of entity
  check_doc_type.sh
     check the correctness of type of documents, like PII, PCI, PHI. For example, if a document has an annotation as SSN, it should be labled as PHI. To find these cases, first enter "ssn", then enter "DOC_PHI".
  entities.type
    a list of entity types used on BRAT
## 3_compare
 compare_before.sh
    process the format in order to calculate Cohen's kappa coefficient
 compare_anno1.py
    After running compare_before.sh
    compare the annotations from two annotators using lists
 compare_anno2.py
    compare the annotations from two annotators using dictionaries(set); no pre-step needed
## 4_collect
  PCI_collect.sh
    collect the documents which are labled as PCI as well as their .ann files
  PCI_non_collect.sh
    randomly collect the documents which are not labled as PCI, as well as .ann. files
  PHI_collect.sh
    collect the documents which are labled as PHI as well as their .ann files
  PHI_non_collect.sh
     randomly collect the documents which are not labled as PHI, as well as .ann. files
## 5_test
  some backup scripts
  deleteSimilar.py
  deleteSimilar2.py
    Using fuzzywuzzy library to detect documents which have similar contents
  find_ID.sh
    search a file by its name
  process_newregex.py
    generate a csv file from a json file for training models
    check whether a document has the PCI lable
    check whether a document has patterns matched to creditcard number regex

   

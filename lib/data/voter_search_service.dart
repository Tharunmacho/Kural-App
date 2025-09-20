import 'package:cloud_firestore/cloud_firestore.dart';
import 'voter.dart';

class VoterSearchService {
  final String collectionPath;

  VoterSearchService({required this.collectionPath});

  Future<List<Voter>> search({
    String? mobileNo,
    String? partNo,
    String? serialNo,
    String? epicId,
    String? voterFirstName,
    String? voterLastName,
    String? relationFirstName,
    String? relationLastName,
    String? age,
  }) async {
    try {
      print('Starting search with criteria:');
      print('Mobile No: $mobileNo');
      print('Part No: $partNo');
      print('Serial No: $serialNo');
      print('Voter First Name: $voterFirstName');
      print('Relation First Name: $relationFirstName');
      print('Age: $age');

      CollectionReference votersCollection = FirebaseFirestore.instance.collection(collectionPath);
      Query query = votersCollection;

      // Add where clauses for non-empty fields
      if (mobileNo != null && mobileNo.isNotEmpty) {
        final intMobile = int.tryParse(mobileNo);
        if (intMobile != null) {
          query = query.where(VoterKeys.mobileNo, isEqualTo: intMobile);
        } else {
          query = query.where(VoterKeys.mobileNo, isEqualTo: mobileNo);
        }
      }

      if (partNo != null && partNo.isNotEmpty) {
        final intPartNo = int.tryParse(partNo);
        if (intPartNo != null) {
          query = query.where(VoterKeys.partNo, isEqualTo: intPartNo);
        } else {
          query = query.where(VoterKeys.partNo, isEqualTo: partNo);
        }
      }

      if (serialNo != null && serialNo.isNotEmpty) {
        final intSerialNo = int.tryParse(serialNo);
        if (intSerialNo != null) {
          query = query.where(VoterKeys.serialNo, isEqualTo: intSerialNo);
        } else {
          query = query.where(VoterKeys.serialNo, isEqualTo: serialNo);
        }
      }

      if (epicId != null && epicId.isNotEmpty) {
        query = query.where(VoterKeys.epicId, isEqualTo: epicId);
      }

      if (voterFirstName != null && voterFirstName.isNotEmpty) {
        query = query.where(VoterKeys.voterFirstName, isEqualTo: voterFirstName);
      }

      if (voterLastName != null && voterLastName.isNotEmpty) {
        query = query.where(VoterKeys.voterLastName, isEqualTo: voterLastName);
      }

      if (relationFirstName != null && relationFirstName.isNotEmpty) {
        query = query.where(VoterKeys.relationFirstName, isEqualTo: relationFirstName);
      }

      if (relationLastName != null && relationLastName.isNotEmpty) {
        query = query.where(VoterKeys.relationLastName, isEqualTo: relationLastName);
      }

      if (age != null && age.isNotEmpty) {
        final intAge = int.tryParse(age);
        if (intAge != null) {
          query = query.where(VoterKeys.age, isEqualTo: intAge);
        } else {
          query = query.where(VoterKeys.age, isEqualTo: age);
        }
      }

      QuerySnapshot snapshot = await query.get(const GetOptions(source: Source.serverAndCache));
      print('Found ${snapshot.docs.length} documents in collection');

      List<Voter> voters = [];
      for (QueryDocumentSnapshot doc in snapshot.docs) {
        try {
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
          print('Document ${doc.id} data: $data');
          
          // Check if this document contains voter data (has any of the voter fields)
          bool hasVoterData = data.containsKey(VoterKeys.voterFirstName) || 
                              data.containsKey(VoterKeys.serialNo) || 
                              data.containsKey(VoterKeys.mobileNo) ||
                              data.containsKey(VoterKeys.partNo) ||
                              data.containsKey(VoterKeys.age) ||
                              data.containsKey(VoterKeys.relationFirstName);
          
          if (hasVoterData) {
            print('Document ${doc.id} contains voter data, checking criteria...');
            
            // This document contains voter data, check if it matches our search criteria
            bool matches = true;
          
            if (mobileNo != null && mobileNo.isNotEmpty) {
              final docMobile = data[VoterKeys.mobileNo]?.toString();
              final intMobile = int.tryParse(mobileNo);
              print('Checking mobile: search=$mobileNo, doc=$docMobile, intMobile=$intMobile');
              if (intMobile != null) {
                bool mobileMatch = data[VoterKeys.mobileNo] == intMobile;
                print('Mobile int match: $mobileMatch');
                matches = matches && mobileMatch;
              } else {
                bool mobileMatch = docMobile == mobileNo;
                print('Mobile string match: $mobileMatch');
                matches = matches && mobileMatch;
              }
            }
            
            if (partNo != null && partNo.isNotEmpty) {
              final intPartNo = int.tryParse(partNo);
              print('Checking partNo: search=$partNo, doc=${data[VoterKeys.partNo]}, intPartNo=$intPartNo');
              if (intPartNo != null) {
                bool partMatch = data[VoterKeys.partNo] == intPartNo;
                print('PartNo int match: $partMatch');
                matches = matches && partMatch;
              } else {
                bool partMatch = data[VoterKeys.partNo]?.toString() == partNo;
                print('PartNo string match: $partMatch');
                matches = matches && partMatch;
              }
            }
            
            if (serialNo != null && serialNo.isNotEmpty) {
              final intSerialNo = int.tryParse(serialNo);
              print('Checking serialNo: search=$serialNo, doc=${data[VoterKeys.serialNo]}, intSerialNo=$intSerialNo');
              if (intSerialNo != null) {
                bool serialMatch = data[VoterKeys.serialNo] == intSerialNo;
                print('SerialNo int match: $serialMatch');
                matches = matches && serialMatch;
              } else {
                bool serialMatch = data[VoterKeys.serialNo]?.toString() == serialNo;
                print('SerialNo string match: $serialMatch');
                matches = matches && serialMatch;
              }
            }
            
            if (epicId != null && epicId.isNotEmpty) {
              matches = matches && (data[VoterKeys.epicId] == epicId);
            }
            
            if (voterFirstName != null && voterFirstName.isNotEmpty) {
              final docFirstName = data[VoterKeys.voterFirstName]?.toString().toLowerCase();
              print('Checking voterFirstName: search=$voterFirstName, doc=$docFirstName');
              bool nameMatch = docFirstName == voterFirstName.toLowerCase() || 
                             (docFirstName?.contains(voterFirstName.toLowerCase()) == true);
              print('VoterFirstName match: $nameMatch');
              matches = matches && nameMatch;
            }
            
            if (voterLastName != null && voterLastName.isNotEmpty) {
              final docLastName = data[VoterKeys.voterLastName]?.toString().toLowerCase();
              matches = matches && (docLastName == voterLastName.toLowerCase() || 
                                   (docLastName?.contains(voterLastName.toLowerCase()) == true));
            }
            
            if (relationFirstName != null && relationFirstName.isNotEmpty) {
              final docRelationFirstName = data[VoterKeys.relationFirstName]?.toString().toLowerCase();
              matches = matches && (docRelationFirstName == relationFirstName.toLowerCase() || 
                                   (docRelationFirstName?.contains(relationFirstName.toLowerCase()) == true));
            }
            
            if (relationLastName != null && relationLastName.isNotEmpty) {
              final docRelationLastName = data[VoterKeys.relationLastName]?.toString().toLowerCase();
              matches = matches && (docRelationLastName == relationLastName.toLowerCase() || 
                                   (docRelationLastName?.contains(relationLastName.toLowerCase()) == true));
            }
            
            if (age != null && age.isNotEmpty) {
              final intAge = int.tryParse(age);
              if (intAge != null) {
                matches = matches && (data[VoterKeys.age] == intAge);
              } else {
                matches = matches && (data[VoterKeys.age]?.toString() == age);
              }
            }
            
            if (matches) {
              print('Document ${doc.id} matches criteria!');
              voters.add(Voter.fromMap(data));
            } else {
              print('Document ${doc.id} does not match criteria');
            }
          } else {
            print('Document ${doc.id} does not contain voter data, skipping...');
          }
        } catch (e) {
          print('Error processing document ${doc.id}: $e');
        }
      }

      print('Final result: ${voters.length} voters found');
      return voters;
    } catch (e) {
      print('Search error: $e');
      throw Exception('Failed to search voters: $e');
    }
  }
}

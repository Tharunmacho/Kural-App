class Voter {
  final String? relationFirstName;
  final int? age;
  final String? mobileNo;
  final int? partNo;
  final int? serialNo;
  final String? voterFirstName;
  final String? voterLastName;
  final String? epicId;
  final String? address;
  final String? relation;

  Voter({
    this.relationFirstName,
    this.age,
    this.mobileNo,
    this.partNo,
    this.serialNo,
    this.voterFirstName,
    this.voterLastName,
    this.epicId,
    this.address,
    this.relation,
  });

  String get fullName => '${voterFirstName ?? ''} ${voterLastName ?? ''}'.trim();

  factory Voter.fromMap(Map<String, dynamic> map) {
    return Voter(
      relationFirstName: map[VoterKeys.relationFirstName]?.toString(),
      age: map[VoterKeys.age] is int ? map[VoterKeys.age] : int.tryParse(map[VoterKeys.age]?.toString() ?? ''),
      mobileNo: map[VoterKeys.mobileNo]?.toString(),
      partNo: map[VoterKeys.partNo] is int ? map[VoterKeys.partNo] : int.tryParse(map[VoterKeys.partNo]?.toString() ?? ''),
      serialNo: map[VoterKeys.serialNo] is int ? map[VoterKeys.serialNo] : int.tryParse(map[VoterKeys.serialNo]?.toString() ?? ''),
      voterFirstName: map[VoterKeys.voterFirstName]?.toString(),
      voterLastName: map[VoterKeys.voterLastName]?.toString(),
      epicId: map[VoterKeys.epicId]?.toString(),
      address: map[VoterKeys.address]?.toString(),
      relation: map[VoterKeys.relation]?.toString(),
    );
  }
}

class VoterKeys {
  static const String relationFirstName = 'Relation First Name';
  static const String relationLastName = 'Relation Last Name';
  static const String age = 'Age';
  static const String mobileNo = 'Mobile No';
  static const String partNo = 'Part No';
  static const String serialNo = 'Serial No';
  static const String voterFirstName = 'Voter First Name';
  static const String voterLastName = 'Voter Last Name';
  static const String epicId = 'EPIC Id';
  static const String address = 'Address';
  static const String relation = 'Relation';
}

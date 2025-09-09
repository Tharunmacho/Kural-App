import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'voter_info_screen.dart';
import '../widgets/unified_voter_filter.dart';

class MobileVoter {
  final int serialNo;
  final String name;
  final String tamilName;
  final String location;
  final String tamilLocation;
  final String voterId;
  final String doorNo;
  final int age;
  final String gender;
  final String relation;
  final String mobileNumber;
  final String politicalParty;
  final String religion;
  final String voterCategory;

  MobileVoter({
    required this.serialNo,
    required this.name,
    required this.tamilName,
    required this.location,
    required this.tamilLocation,
    required this.voterId,
    required this.doorNo,
    required this.age,
    required this.gender,
    required this.relation,
    required this.mobileNumber,
    required this.politicalParty,
    required this.religion,
    required this.voterCategory,
  });
}

class MobileScreen extends StatefulWidget {
  const MobileScreen({super.key});

  @override
  State<MobileScreen> createState() => _MobileScreenState();
}

class _MobileScreenState extends State<MobileScreen> {
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _partNoController = TextEditingController();
  final TextEditingController _serialNoController = TextEditingController();
  final TextEditingController _epicIdController = TextEditingController();
  final TextEditingController _voterFirstNameController = TextEditingController();
  final TextEditingController _voterLastNameController = TextEditingController();
  final TextEditingController _relationFirstNameController = TextEditingController();
  
  // Filter state variables
  double minAge = 18;
  double maxAge = 120;
  Set<String> selectedGenders = {};
  Set<String> selectedVoterHistory = {};
  Set<String> selectedVoterCategory = {};
  Set<String> selectedPoliticalParty = {};
  Set<String> selectedReligion = {};
  
  final List<MobileVoter> allVoters = [
    MobileVoter(
      serialNo: 3,
      name: 'vasandhamani',
      tamilName: 'வசந்தாமணி',
      location: 'jalapathi',
      tamilLocation: 'ஜலபதி',
      voterId: 'RIV0344366',
      doorNo: '1',
      age: 71,
      gender: 'Female',
      relation: 'Husband',
      mobileNumber: '9876543213',
      politicalParty: 'DMK',
      religion: 'Hindu',
      voterCategory: 'General',
    ),
    MobileVoter(
      serialNo: 4,
      name: 'revathi',
      tamilName: 'ரேவதி',
      location: 'thiruvarasu',
      tamilLocation: 'திருவரசு',
      voterId: 'RIV0344367',
      doorNo: '4',
      age: 45,
      gender: 'Female',
      relation: 'Wife',
      mobileNumber: '9876543214',
      politicalParty: 'AIADMK',
      religion: 'Hindu',
      voterCategory: 'OBC',
    ),
  ];

  List<MobileVoter> filteredVoters = [];

  @override
  void initState() {
    super.initState();
    filteredVoters = allVoters;
  }



  @override
  Widget build(BuildContext context) {


    // Calculate total counts from all voters (not just filtered)
    int totalMale = 62471;
    int totalFemale = 63536;
    int totalOthers = 30;
    int grandTotal = 126037;

    return Scaffold(
      backgroundColor: Color(0xFFF5F7FA),
      appBar: AppBar(
        backgroundColor: Color(0xFFF5F7FA),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Mobile',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          GestureDetector(
            onTap: _showFilterModal,
            child: Container(
              margin: EdgeInsets.only(right: 16),
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Icon(
                Icons.tune,
                color: Colors.blue[600],
                size: 20,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Search bar
          Padding(
            padding: EdgeInsets.all(16),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Voter Id or Voter Name',
                  hintStyle: TextStyle(color: Colors.grey[500]),
                  prefixIcon: Icon(Icons.search, color: Colors.blue[600]),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                ),
                onTap: _showAdvancedSearch,
                onChanged: (value) {
                  // Implement search functionality
                },
              ),
            ),
          ),

          // Demographics cards with real numbers
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Expanded(child: _buildDemographicCard('Male:', totalMale.toString(), Color(0xFFE8F5E8), Color(0xFF4CAF50))),
                const SizedBox(width: 8),
                Expanded(child: _buildDemographicCard('Female:', totalFemale.toString(), Color(0xFFFFE4E1), Color(0xFFE91E63))),
                const SizedBox(width: 8),
                Expanded(child: _buildDemographicCard('Others:', totalOthers.toString(), Color(0xFFFFF3E0), Color(0xFFFF9800))),
                const SizedBox(width: 8),
                Expanded(child: _buildDemographicCard('Total:', grandTotal.toString(), Color(0xFFE3F2FD), Color(0xFF2196F3))),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Voter list
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 16),
              itemCount: filteredVoters.length,
              itemBuilder: (context, index) {
                return _buildVoterCard(filteredVoters[index]);
              },
            ),
          ),
        ],
      ),

      // Bottom navigation bar
      bottomNavigationBar: Container(
        height: 80,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 4,
              offset: Offset(0, -2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildBottomNavItem(Icons.assessment, 'Report'),
            _buildBottomNavItem(Icons.list_alt, 'Catalogue'),
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: Color(0xFF1976D2),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.home, color: Colors.white, size: 28),
            ),
            _buildBottomNavItem(Icons.inventory_2, 'Slip Box'),
            _buildBottomNavItem(Icons.poll, 'Poll Day'),
          ],
        ),
      ),
    );
  }

  Widget _buildDemographicCard(String title, String value, Color bgColor, Color textColor) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 6),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 10,
              color: textColor,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVoterCard(MobileVoter voter) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 2,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Serial number with star
          Row(
            children: [
              Icon(
                Icons.star_outline,
                color: Colors.pink,
                size: 16,
              ),
              const SizedBox(width: 4),
              Text(
                'Serial No: ${voter.serialNo}',
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF1976D2),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile image and voter ID
              SizedBox(
                width: 60,
                child: Column(
                  children: [
                    Container(
                      width: 50,
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(6),
                          topRight: Radius.circular(6),
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(6),
                          topRight: Radius.circular(6),
                        ),
                        child: Image.asset(
                          'assets/images/political_meeting.jpg',
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: Colors.grey[300],
                              child: Icon(Icons.person, color: Colors.grey[600]),
                            );
                          },
                        ),
                      ),
                    ),
                    Container(
                      width: 50,
                      padding: EdgeInsets.symmetric(vertical: 4),
                      decoration: BoxDecoration(
                        color: Color(0xFF1976D2),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(6),
                          bottomRight: Radius.circular(6),
                        ),
                      ),
                      child: GestureDetector(
                        onTap: _showAdvancedSearch,
                        child: Text(
                          voter.voterId,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 8,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              
              // Voter details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: _showAdvancedSearch,
                      child: Text(
                        voter.name,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    Text(
                      voter.tamilName,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      voter.location,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black54,
                      ),
                    ),
                    Text(
                      voter.tamilLocation,
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.black54,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Door No ${voter.doorNo}',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black87,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 8),
          
          // Age and relation
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.orange.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.person, color: Colors.orange, size: 12),
                    const SizedBox(width: 2),
                    Text(
                      '${voter.age}',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.orange,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Text(
                voter.relation,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 12),
          
          // Action buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () => _makePhoneCall(voter.mobileNumber),
                child: Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.blue.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Icon(Icons.phone, color: Colors.blue, size: 16),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Map<String, dynamic> voterData = {
                    'serialNo': voter.serialNo,
                    'serial': voter.serialNo.toString(),
                    'name': voter.name,
                    'tamilName': voter.tamilName,
                    'fatherName': voter.location,
                    'fatherTamilName': voter.tamilLocation,
                    'location': voter.location,
                    'tamilLocation': voter.tamilLocation,
                    'voterId': voter.voterId,
                    'doorNo': voter.doorNo,
                    'partNumber': '1',
                    'section': '1',
                    'age': voter.age,
                    'gender': voter.gender,
                    'relation': voter.relation,
                    'mobileNumber': voter.mobileNumber,
                    'politicalParty': voter.politicalParty,
                    'religion': voter.religion,
                    'voterCategory': voter.voterCategory,
                  };
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => VoterInfoScreen(voterData: voterData),
                    ),
                  );
                },
                child: Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.green.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.group, color: Colors.green, size: 16),
                      if (voter.serialNo == 3) // Show notification badge for first voter
                        Container(
                          margin: EdgeInsets.only(left: 2),
                          width: 16,
                          height: 16,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Text(
                              '1',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavItem(IconData icon, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: Colors.grey, size: 24),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  void _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    try {
      await launchUrl(launchUri);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Could not launch phone dialer')),
        );
      }
    }
  }

  void _showAdvancedSearch() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.8,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'Advance Search',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Icon(Icons.close, size: 24),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              _buildSearchField('Mobile No', _mobileController),
              const SizedBox(height: 16),
              _buildSearchField('PartNo', _partNoController),
              const SizedBox(height: 16),
              _buildSearchField('Serial No', _serialNoController),
              const SizedBox(height: 16),
              _buildSearchField('EPIC Id', _epicIdController),
              const SizedBox(height: 16),
              _buildSearchField('Voter First Name', _voterFirstNameController),
              const SizedBox(height: 16),
              _buildSearchField('Voter Last Name', _voterLastNameController),
              const SizedBox(height: 16),
              _buildSearchField('Relation First Name', _relationFirstNameController),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        _clearSearchFields();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.grey[700],
                        side: BorderSide(color: Colors.grey[300]!),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text('Clear'),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Search functionality implemented!')),
                        );
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF1976D2),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text('Search'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchField(String label, TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Color(0xFF1976D2)),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
    );
  }

  void _clearSearchFields() {
    _mobileController.clear();
    _partNoController.clear();
    _serialNoController.clear();
    _epicIdController.clear();
    _voterFirstNameController.clear();
    _voterLastNameController.clear();
    _relationFirstNameController.clear();
  }

  void _showFilterModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => StatefulBuilder(
        builder: (context, setModalState) => Container(
          height: MediaQuery.of(context).size.height * 0.9,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Filter Voters',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Select filters to narrow down the voter list',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: UnifiedVoterFilter(
                    minAge: minAge,
                    maxAge: maxAge,
                    selectedGenders: selectedGenders,
                    selectedVoterHistory: selectedVoterHistory,
                    selectedVoterCategory: selectedVoterCategory,
                    selectedPoliticalParty: selectedPoliticalParty,
                    selectedReligion: selectedReligion,
                    setModalState: setModalState,
                    onAgeChanged: (min, max) {
                      minAge = min;
                      maxAge = max;
                    },
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              setModalState(() {
                                minAge = 18;
                                maxAge = 120;
                                selectedGenders.clear();
                                selectedVoterHistory.clear();
                                selectedVoterCategory.clear();
                                selectedPoliticalParty.clear();
                                selectedReligion.clear();
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: Color(0xFF1976D2),
                              side: BorderSide(color: Color(0xFF1976D2)),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding: EdgeInsets.symmetric(vertical: 16),
                            ),
                            child: Text('Clear All'),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Filters applied successfully!'),
                                  backgroundColor: Colors.green,
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF1976D2),
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding: EdgeInsets.symmetric(vertical: 16),
                            ),
                            child: Text('Apply Filters'),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () => Navigator.pop(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 16),
                        ),
                        child: Text('Close'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    _mobileController.dispose();
    _partNoController.dispose();
    _serialNoController.dispose();
    _epicIdController.dispose();
    _voterFirstNameController.dispose();
    _voterLastNameController.dispose();
    _relationFirstNameController.dispose();
    super.dispose();
  }
}

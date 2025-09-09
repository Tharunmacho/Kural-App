import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'voter_info_screen.dart';
import '../widgets/unified_voter_filter.dart';

class GuardianScreen extends StatefulWidget {
  const GuardianScreen({super.key});

  @override
  State<GuardianScreen> createState() => _GuardianScreenState();
}

class _GuardianScreenState extends State<GuardianScreen> {
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

  // Sample guardian voters data
  final List<GuardianVoter> voters = [
    GuardianVoter(
      serialNo: 224,
      name: 'ponnammal',
      tamilName: 'பொன்னம்மாள்',
      relation: 'ramachandra',
      tamilRelation: 'ரமாசந்திரா',
      voterId: 'RIV2345114',
      doorNo: 'Door No 15/A 14',
      age: 89,
      gender: 'Other',
      mobileNumber: '9876543210',
      politicalParty: 'DMK',
      religion: 'Hindu',
      voterCategory: 'Active',
      location: 'Thondamuthur',
      tamilLocation: 'தொண்டமுத்தூர்',
    ),
    GuardianVoter(
      serialNo: 260,
      name: 'venkatakrishnan.k.s venkat',
      tamilName: 'வெங்கடகிருஷ்ணன்...',
      relation: 'mangala krishnan mangala',
      tamilRelation: 'மங்கள கிருஷ்ணன்',
      voterId: 'RIV2456789',
      doorNo: 'Door No 12/B 8',
      age: 67,
      gender: 'Male',
      mobileNumber: '9123456789',
      politicalParty: 'ADMK',
      religion: 'Hindu',
      voterCategory: 'Active',
      location: 'Thondamuthur',
      tamilLocation: 'தொண்டமுத்தூர்',
    ),
    GuardianVoter(
      serialNo: 125,
      name: 'lakshmi',
      tamilName: 'லக்ஷ்மி',
      relation: 'kumar',
      tamilRelation: 'குமார்',
      voterId: 'RIV3789456',
      doorNo: 'Door No 8/C 12',
      age: 45,
      gender: 'Female',
      mobileNumber: '9987654321',
      politicalParty: 'BJP',
      religion: 'Hindu',
      voterCategory: 'Active',
      location: 'Thondamuthur',
      tamilLocation: 'தொண்டமுத்தூர்',
    ),
    GuardianVoter(
      serialNo: 78,
      name: 'rajesh',
      tamilName: 'ராஜேஷ்',
      relation: 'priya',
      tamilRelation: 'பிரியா',
      voterId: 'RIV4567890',
      doorNo: 'Door No 3/A 7',
      age: 52,
      gender: 'Male',
      mobileNumber: '9654321876',
      politicalParty: 'Congress',
      religion: 'Christian',
      voterCategory: 'Inactive',
      location: 'Thondamuthur',
      tamilLocation: 'தொண்டமுத்தூர்',
    ),
  ];

  List<GuardianVoter> filteredVoters = [];

  @override
  void initState() {
    super.initState();
    filteredVoters = voters;
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F7FA),
      body: SafeArea(
        child: Column(
          children: [
            // Header section
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFFE3F2FD),
                    Color(0xFFBBDEFB),
                  ],
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Icon(
                          Icons.arrow_back,
                          size: 28,
                          color: Colors.black87,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          'Guardian',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: _showFilterModal,
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.grey[300]!),
                          ),
                          child: Icon(
                            Icons.tune,
                            color: Colors.blue[600],
                            size: 24,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  // Search bar
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(color: Colors.grey[300]!),
                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 20),
                          child: Icon(
                            Icons.search,
                            color: Color(0xFF1976D2),
                            size: 24,
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: _showAdvancedSearch,
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                              child: Text(
                                'Voter Id or Voter Name',
                                style: TextStyle(
                                  color: Colors.grey[400],
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            
            // Demographics section
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  Expanded(
                    child: _buildDemographicCard(
                      'Male',
                      '1648',
                      Color(0xFFE8F5E8),
                      Color(0xFF4CAF50),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildDemographicCard(
                      'Female',
                      '773',
                      Color(0xFFFFEBEE),
                      Color(0xFFE91E63),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildDemographicCard(
                      'Others',
                      '6',
                      Color(0xFFF3E5F5),
                      Color(0xFF9C27B0),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildDemographicCard(
                      'Total',
                      '2427',
                      Color(0xFFE3F2FD),
                      Color(0xFF2196F3),
                    ),
                  ),
                ],
              ),
            ),
            
            // Voters list
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                itemCount: filteredVoters.length,
                itemBuilder: (context, index) {
                  final voter = filteredVoters[index];
                  return Padding(
                    padding: EdgeInsets.only(bottom: 16),
                    child: _buildVoterCard(voter),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      
      // Bottom navigation
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 10,
              offset: Offset(0, -2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildBottomNavItem('Report', Icons.trending_up_outlined),
            _buildBottomNavItem('Catalogue', Icons.list_alt_outlined),
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Color(0xFF1976D2),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.home,
                color: Colors.white,
                size: 28,
              ),
            ),
            _buildBottomNavItem('Slip Box', Icons.inventory_outlined),
            _buildBottomNavItem('Poll Day', Icons.how_to_vote_outlined),
          ],
        ),
      ),
    );
  }

  Widget _buildDemographicCard(String title, String value, Color bgColor, Color textColor) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            '$title:',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: textColor,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVoterCard(GuardianVoter voter) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Serial number header with star
          Row(
            children: [
              Icon(
                Icons.star_border,
                color: Colors.pink,
                size: 16,
              ),
              const SizedBox(width: 6),
              Text(
                'Serial No: ${voter.serialNo}',
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF1976D2),
                  fontWeight: FontWeight.w600,
                ),
              ),
              Spacer(),
              // Voter ID badge positioned at top right
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: Color(0xFF1976D2),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  voter.voterId,
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 16),
          
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile image section
              Container(
                width: 60,
                height: 70,
                decoration: BoxDecoration(
                  color: Colors.blue[50],
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey[300]!),
                ),
                child: Stack(
                  children: [
                    Center(
                      child: Icon(
                        Icons.person,
                        size: 30,
                        color: Colors.blue,
                      ),
                    ),
                    Positioned(
                      bottom: 4,
                      right: 4,
                      child: Container(
                        padding: EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.camera_alt,
                          color: Colors.white,
                          size: 10,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              
              const SizedBox(width: 16),
              
              // Voter details section
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      voter.name,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    Text(
                      voter.tamilName,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.black54,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      voter.relation,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                    ),
                    Text(
                      voter.tamilRelation,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black54,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Door No ${voter.doorNo}',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 16),
          
          // Bottom section with age and action buttons
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                decoration: BoxDecoration(
                  color: Colors.pink[50],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.person,
                      size: 14,
                      color: Colors.pink[600],
                    ),
                    const SizedBox(width: 3),
                    Text(
                      '${voter.age}',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.pink[600],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Text(
                voter.gender,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.black54,
                ),
              ),
              Spacer(),
              // Action icons positioned at bottom right
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    onTap: () => _makePhoneCall(voter.mobileNumber),
                    child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.phone, color: Colors.white, size: 16),
                    ),
                  ),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: () {
                      // Navigate to voter info screen when family icon is clicked
                      Map<String, dynamic> voterData = {
                        'serialNo': voter.serialNo,
                        'serial': voter.serialNo.toString(),
                        'name': voter.name,
                        'tamilName': voter.tamilName,
                        'fatherName': voter.relation,
                        'fatherTamilName': voter.tamilRelation,
                        'location': voter.relation,
                        'tamilLocation': voter.tamilRelation,
                        'voterId': voter.voterId,
                        'doorNo': voter.doorNo,
                        'partNumber': '1',
                        'section': '1',
                        'age': voter.age,
                        'gender': voter.gender,
                        'relation': voter.relation,
                        'mobileNumber': voter.mobileNumber,
                        'politicalParty': 'Unknown',
                        'religion': 'Unknown',
                        'voterCategory': 'Active',
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
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      child: Stack(
                        children: [
                          Icon(
                            Icons.family_restroom,
                            size: 16,
                            color: Colors.white,
                          ),
                          Positioned(
                            top: -4,
                            right: -4,
                            child: Container(
                              width: 12,
                              height: 12,
                              decoration: BoxDecoration(
                                color: Colors.red[800],
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Text(
                                  '1',
                                  style: TextStyle(
                                    fontSize: 8,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
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
        ],
      ),
    );
  }

  Widget _buildBottomNavItem(String title, IconData icon) {
    return GestureDetector(
      onTap: () {
        // Handle navigation
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 24,
            color: Colors.black54,
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: TextStyle(
              fontSize: 10,
              color: Colors.black54,
            ),
          ),
        ],
      ),
    );
  }



  // Advanced search modal
  void _showAdvancedSearch() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.85,
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
                    'Advanced Search',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Search voters using multiple criteria',
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
                child: Column(
                  children: [
                    _buildSearchField('Mobile Number', Icons.phone, _mobileController),
                    const SizedBox(height: 16),
                    _buildSearchField('Part Number', Icons.location_on, _partNoController),
                    const SizedBox(height: 16),
                    _buildSearchField('Serial Number', Icons.numbers, _serialNoController),
                    const SizedBox(height: 16),
                    _buildSearchField('EPIC ID', Icons.credit_card, _epicIdController),
                    const SizedBox(height: 16),
                    _buildSearchField('Voter First Name', Icons.person, _voterFirstNameController),
                    const SizedBox(height: 16),
                    _buildSearchField('Voter Last Name', Icons.person_outline, _voterLastNameController),
                    const SizedBox(height: 16),
                    _buildSearchField('Relation First Name', Icons.family_restroom, _relationFirstNameController),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(20),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        _clearSearchFields();
                        Navigator.pop(context);
                      },
                      style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        side: BorderSide(color: Colors.grey[400]!),
                      ),
                      child: Text(
                        'CLEAR',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        _performAdvancedSearch();
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF1976D2),
                        padding: EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: Text(
                        'SEARCH',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchField(String label, IconData icon, TextEditingController controller) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, color: Color(0xFF1976D2)),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
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
    setState(() {
      filteredVoters = voters;
    });
  }

  void _performAdvancedSearch() {
    setState(() {
      filteredVoters = voters.where((voter) {
        bool matches = true;
        
        if (_mobileController.text.isNotEmpty) {
          matches = matches && voter.mobileNumber.contains(_mobileController.text);
        }
        if (_partNoController.text.isNotEmpty) {
          matches = matches && voter.location.toLowerCase().contains(_partNoController.text.toLowerCase());
        }
        if (_serialNoController.text.isNotEmpty) {
          matches = matches && voter.serialNo.toString().contains(_serialNoController.text);
        }
        if (_epicIdController.text.isNotEmpty) {
          matches = matches && voter.voterId.toLowerCase().contains(_epicIdController.text.toLowerCase());
        }
        if (_voterFirstNameController.text.isNotEmpty) {
          matches = matches && voter.name.toLowerCase().contains(_voterFirstNameController.text.toLowerCase());
        }
        if (_voterLastNameController.text.isNotEmpty) {
          matches = matches && voter.name.toLowerCase().contains(_voterLastNameController.text.toLowerCase());
        }
        if (_relationFirstNameController.text.isNotEmpty) {
          matches = matches && voter.relation.toLowerCase().contains(_relationFirstNameController.text.toLowerCase());
        }
        
        return matches;
      }).toList();
    });
  }

  // Filter modal functionality
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
                child: Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          _clearAllFilters();
                          setModalState(() {});
                          Navigator.pop(context);
                        },
                        style: OutlinedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 16),
                          side: BorderSide(color: Colors.grey[400]!),
                        ),
                        child: Text(
                          'CLEAR ALL',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF1976D2),
                          padding: EdgeInsets.symmetric(vertical: 16),
                        ),
                        child: Text(
                          'APPLY FILTERS',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
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







  void _clearAllFilters() {
    setState(() {
      minAge = 18;
      maxAge = 120;
      selectedGenders.clear();
      selectedVoterHistory.clear();
      selectedVoterCategory.clear();
      selectedPoliticalParty.clear();
      selectedReligion.clear();
      filteredVoters = voters;
    });
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
}

class GuardianVoter {
  final int serialNo;
  final String name;
  final String tamilName;
  final String relation;
  final String tamilRelation;
  final String voterId;
  final String doorNo;
  final int age;
  final String gender;
  final String mobileNumber;
  final String politicalParty;
  final String religion;
  final String voterCategory;
  final String location;
  final String tamilLocation;

  GuardianVoter({
    required this.serialNo,
    required this.name,
    required this.tamilName,
    required this.relation,
    required this.tamilRelation,
    required this.voterId,
    required this.doorNo,
    required this.age,
    required this.gender,
    required this.mobileNumber,
    required this.politicalParty,
    required this.religion,
    required this.voterCategory,
    required this.location,
    required this.tamilLocation,
  });
}

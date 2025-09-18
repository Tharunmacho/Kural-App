import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../l10n/app_localizations.dart';
import 'voter_info_screen.dart';

class OverseasVoter {
  final int serialNo;
  final String name;
  final String tamilName;
  final String location;
  final String tamilLocation;
  final String voterId;
  final String doorNo;
  final int age;
  final String relation;
  final String gender;
  final String mobileNumber;
  final String politicalParty;
  final String religion;
  final String voterCategory;

  OverseasVoter({
    required this.serialNo,
    required this.name,
    required this.tamilName,
    required this.location,
    required this.tamilLocation,
    required this.voterId,
    required this.doorNo,
    required this.age,
    required this.relation,
    required this.gender,
    required this.mobileNumber,
    required this.politicalParty,
    required this.religion,
    required this.voterCategory,
  });
}

class OverseasScreen extends StatefulWidget {
  const OverseasScreen({super.key});

  @override
  State<OverseasScreen> createState() => _OverseasScreenState();
}

class _OverseasScreenState extends State<OverseasScreen> {
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
  
  final List<OverseasVoter> allVoters = [
    OverseasVoter(
      serialNo: 944,
      name: 'balachandran',
      tamilName: 'பாலசந்திரன்',
      location: 'krishna iyer',
      tamilLocation: 'கிருஷ்ண ஐயர்',
      voterId: 'RIV3200268',
      doorNo: '15/A159',
      age: 68,
      relation: 'Father',
      gender: 'Male',
      mobileNumber: '+91 9876543210',
      politicalParty: 'DMK',
      religion: 'Hindu',
      voterCategory: 'General',
    ),
    OverseasVoter(
      serialNo: 945,
      name: 'valamabal balachandran',
      tamilName: 'வளமாம்பாள் பாலசந்திரன்',
      location: 'balachandran',
      tamilLocation: 'பாலசந்திரன்',
      voterId: 'RIV3200269',
      doorNo: '15/A159',
      age: 65,
      relation: 'Mother',
      gender: 'Female',
      mobileNumber: '+91 8765432109',
      politicalParty: 'DMK',
      religion: 'Hindu',
      voterCategory: 'General',
    ),
  ];

  List<OverseasVoter> filteredVoters = [];

  @override
  void initState() {
    super.initState();
    filteredVoters = allVoters;
  }

  void _filterVoters() {
    setState(() {
      filteredVoters = allVoters.where((voter) => _applyAllFilters(voter)).toList();
    });
  }

  bool _applyAllFilters(OverseasVoter voter) {
    // Age filter
    if (voter.age < minAge || voter.age > maxAge) return false;
    
    // Gender filter
    if (selectedGenders.isNotEmpty && !selectedGenders.contains(voter.gender)) return false;
    
    // Political party filter
    if (selectedPoliticalParty.isNotEmpty && !selectedPoliticalParty.contains(voter.politicalParty)) return false;
    
    // Religion filter
    if (selectedReligion.isNotEmpty && !selectedReligion.contains(voter.religion)) return false;
    
    // Voter category filter
    if (selectedVoterCategory.isNotEmpty && !selectedVoterCategory.contains(voter.voterCategory)) return false;
    
    return true;
  }

  @override
  Widget build(BuildContext context) {
    int maleCount = filteredVoters.where((v) => v.gender == 'Male').length;
    int femaleCount = filteredVoters.where((v) => v.gender == 'Female').length;
    int othersCount = filteredVoters.where((v) => v.gender == 'Others').length;
    int totalCount = filteredVoters.length;

    return Scaffold(
      backgroundColor: Color(0xFFF5F7FA),
      body: SafeArea(
        child: Column(
          children: [
            // Header section
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
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
                          AppLocalizations.of(context)?.overseas ?? 'Overseas',
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
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(25),
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
                ],
              ),
            ),

            // Demographics section
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  _buildDemographicCard('Male:', maleCount.toString(), Colors.green[200]!, Colors.green[800]!),
                  const SizedBox(width: 8),
                  _buildDemographicCard('Female:', femaleCount.toString(), Colors.pink[200]!, Colors.pink[800]!),
                  const SizedBox(width: 8),
                  _buildDemographicCard('Others:', othersCount.toString(), Colors.grey[300]!, Colors.grey[800]!),
                  const SizedBox(width: 8),
                  _buildDemographicCard('Total:', totalCount.toString(), Colors.blue[200]!, Colors.blue[800]!),
                ],
              ),
            ),

            // Voter list
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                itemCount: filteredVoters.length,
                itemBuilder: (context, index) {
                  final voter = filteredVoters[index];
                  return _buildVoterCard(voter);
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
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 12,
                color: textColor,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              value,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVoterCard(OverseasVoter voter) {
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
                color: Colors.pink[400],
                size: 16,
              ),
              const SizedBox(width: 6),
              Text(
                'Serial No: ${voter.serialNo}',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF1976D2),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile image with voter ID
              Container(
                width: 60,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.blue[100],
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(6),
                            topRight: Radius.circular(6),
                          ),
                        ),
                        child: Center(
                          child: Icon(
                            Icons.image,
                            color: Colors.blue,
                            size: 24,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: double.infinity,
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
                        fontSize: 12,
                        color: Colors.black54,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Door No ${voter.doorNo}',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 12),
          
          // Age and relation
          Row(
            children: [
              Icon(
                Icons.person,
                color: Color(0xFF1976D2),
                size: 16,
              ),
              const SizedBox(width: 6),
              Text(
                '${voter.age}',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF1976D2),
                ),
              ),
              const SizedBox(width: 12),
              Text(
                voter.relation,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 12),
          
          // Action buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildCompactActionButton(Icons.call, () {
                _makePhoneCall(voter.mobileNumber);
              }),
              _buildCompactActionButton(Icons.cake, () {
                // Handle celebration
              }),
              GestureDetector(
                onTap: () {
                  Map<String, dynamic> voterData = {
                    'serialNo': voter.serialNo,
                    'section': 999,
                    'partNumber': 1,
                    'name': voter.name,
                    'tamilName': voter.tamilName,
                    'voterId': voter.voterId,
                    'epicId': voter.voterId,
                    'fatherName': voter.relation,
                    'fatherTamilName': voter.relation,
                    'doorNo': voter.doorNo,
                    'age': voter.age,
                    'relation': voter.relation,
                    'part': 1,
                    'serial': voter.serialNo,
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
                    color: Color(0xFF1976D2),
                    shape: BoxShape.circle,
                  ),
                  child: Stack(
                    children: [
                      Icon(
                        Icons.group,
                        color: Colors.white,
                        size: 18,
                      ),
                      Positioned(
                        top: -2,
                        right: -2,
                        child: Container(
                          padding: EdgeInsets.all(1),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            '1',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 8,
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

  Widget _buildCompactActionButton(IconData icon, VoidCallback onTap) {
    // Use green color for call button, orange for others
    Color buttonColor = icon == Icons.call ? Colors.green : Colors.orange;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: buttonColor,
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          color: Colors.white,
          size: 18,
        ),
      ),
    );
  }

  Widget _buildBottomNavItem(String title, IconData icon) {
    return Column(
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
        height: MediaQuery.of(context).size.height * 0.9,
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Advance Search',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(Icons.close, size: 28),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      _buildSearchField(AppLocalizations.of(context)?.mobileNo ?? 'Mobile No', _mobileController),
                      const SizedBox(height: 20),
                      _buildSearchField(AppLocalizations.of(context)?.partNo ?? 'PartNo', _partNoController),
                      const SizedBox(height: 20),
                      _buildSearchField(AppLocalizations.of(context)?.serialNo ?? 'Serial No', _serialNoController),
                      const SizedBox(height: 20),
                      _buildSearchField('EPIC Id', _epicIdController),
                      const SizedBox(height: 20),
                      _buildSearchField('Voter First Name', _voterFirstNameController),
                      const SizedBox(height: 20),
                      _buildSearchField('Voter Last Name', _voterLastNameController),
                      const SizedBox(height: 20),
                      _buildSearchField('Relation First Name', _relationFirstNameController),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        _clearSearchFields();
                      },
                      style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        'Clear',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        // Apply search logic here
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF1976D2),
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        'Search',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
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

  Widget _buildSearchField(String hint, TextEditingController controller) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: Colors.grey[500]),
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Age filter
                      _buildAgeFilter(setModalState),
                      const SizedBox(height: 30),
                      
                      // Gender filter
                      _buildGenderFilter(setModalState),
                      const SizedBox(height: 30),
                      
                      // Political Party filter
                      _buildPoliticalPartyFilter(setModalState),
                      const SizedBox(height: 30),
                      
                      // Religion filter
                      _buildReligionFilter(setModalState),
                      const SizedBox(height: 30),
                      
                      // Voter Category filter
                      _buildVoterCategoryFilter(setModalState),
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
                          setModalState(() {
                            _clearAllFilters();
                          });
                        },
                        style: OutlinedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          'Clear All',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          _filterVoters();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF1976D2),
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          'Apply Filters',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
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

  Widget _buildAgeFilter(StateSetter setModalState) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Age',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Text('Age 18'),
              Spacer(),
              Text('Age 120'),
            ],
          ),
          RangeSlider(
            values: RangeValues(minAge, maxAge),
            min: 0,
            max: 120,
            divisions: 120,
            labels: RangeLabels(
              minAge.round().toString(),
              maxAge.round().toString(),
            ),
            onChanged: (RangeValues values) {
              setModalState(() {
                minAge = values.start;
                maxAge = values.end;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildGenderFilter(StateSetter setModalState) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Gender',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              _buildFilterChip('Male', Icons.person, Colors.blue, setModalState, selectedGenders),
              const SizedBox(width: 16),
              _buildFilterChip('Female', Icons.person, Colors.pink, setModalState, selectedGenders),
              const SizedBox(width: 16),
              _buildFilterChip('Others', Icons.transgender, Colors.orange, setModalState, selectedGenders),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPoliticalPartyFilter(StateSetter setModalState) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Political Party',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              _buildFilterChip('DMK', Icons.flag, Colors.red, setModalState, selectedPoliticalParty),
              _buildFilterChip('AIADMK', Icons.flag, Colors.green, setModalState, selectedPoliticalParty),
              _buildFilterChip('BJP', Icons.flag, Colors.orange, setModalState, selectedPoliticalParty),
              _buildFilterChip('Congress', Icons.flag, Colors.blue, setModalState, selectedPoliticalParty),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildReligionFilter(StateSetter setModalState) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Religion',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              _buildFilterChip('Hindu', Icons.temple_hindu, Colors.orange, setModalState, selectedReligion),
              _buildFilterChip('Muslim', Icons.mosque, Colors.green, setModalState, selectedReligion),
              _buildFilterChip('Christian', Icons.church, Colors.purple, setModalState, selectedReligion),
              _buildFilterChip('Others', Icons.diversity_3, Colors.grey, setModalState, selectedReligion),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildVoterCategoryFilter(StateSetter setModalState) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Voter Category',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              _buildFilterChip('General', Icons.person, Colors.blue, setModalState, selectedVoterCategory),
              _buildFilterChip('OBC', Icons.group, Colors.green, setModalState, selectedVoterCategory),
              _buildFilterChip('SC', Icons.accessibility, Colors.orange, setModalState, selectedVoterCategory),
              _buildFilterChip('ST', Icons.nature_people, Colors.brown, setModalState, selectedVoterCategory),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, IconData icon, Color color, StateSetter setModalState, Set<String> selectedSet) {
    bool isSelected = selectedSet.contains(label);
    return GestureDetector(
      onTap: () {
        setModalState(() {
          if (isSelected) {
            selectedSet.remove(label);
          } else {
            selectedSet.add(label);
          }
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? color.withValues(alpha: 0.2) : Colors.grey[100],
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? color : Colors.grey[300]!,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: color, size: 16),
            const SizedBox(width: 4),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? color : Colors.black87,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _clearAllFilters() {
    minAge = 18;
    maxAge = 120;
    selectedGenders.clear();
    selectedVoterHistory.clear();
    selectedVoterCategory.clear();
    selectedPoliticalParty.clear();
    selectedReligion.clear();
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

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'voter_info_screen.dart';

class StarVoter {
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

  StarVoter({
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

class StarScreen extends StatefulWidget {
  const StarScreen({super.key});

  @override
  State<StarScreen> createState() => _StarScreenState();
}

class _StarScreenState extends State<StarScreen> {
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
  
  final List<StarVoter> allVoters = [
    StarVoter(
      serialNo: 1,
      name: 'pappathi varatharajan',
      tamilName: 'பாப்பாத்தி வரதராஜன்',
      location: 'kalappakavudar',
      tamilLocation: 'காளப்பகவுடர்',
      voterId: 'RIV2140366',
      doorNo: '1',
      age: 79,
      gender: 'Male',
      relation: 'Husband',
      mobileNumber: '9876543210',
      politicalParty: 'DMK',
      religion: 'Hindu',
      voterCategory: 'General',
    ),
    StarVoter(
      serialNo: 5,
      name: 'srinivasavan',
      tamilName: 'ஸ்ரீனிவாசன்',
      location: 'sri maniam',
      tamilLocation: 'ஸ்ரீ மணியம்',
      voterId: 'RIV2140370',
      doorNo: '5',
      age: 45,
      gender: 'Male',
      relation: 'Son',
      mobileNumber: '9876543214',
      politicalParty: 'AIADMK',
      religion: 'Hindu',
      voterCategory: 'OBC',
    ),
  ];

  List<StarVoter> filteredVoters = [];

  @override
  void initState() {
    super.initState();
    filteredVoters = allVoters;
  }



  @override
  Widget build(BuildContext context) {


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
          'Star',
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

          // Demographics cards
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Expanded(child: _buildDemographicCard('Male:', '1250', Color(0xFFE8F5E8), Color(0xFF4CAF50))),
                const SizedBox(width: 8),
                Expanded(child: _buildDemographicCard('Female:', '1320', Color(0xFFFFE4E1), Color(0xFFE91E63))),
                const SizedBox(width: 8),
                Expanded(child: _buildDemographicCard('Others:', '5', Color(0xFFFFF3E0), Color(0xFFFF9800))),
                const SizedBox(width: 8),
                Expanded(child: _buildDemographicCard('Total:', '2575', Color(0xFFE3F2FD), Color(0xFF2196F3))),
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

  Widget _buildVoterCard(StarVoter voter) {
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
                Icons.star,
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
                    'fatherName': voter.location, // Using location as father name
                    'fatherTamilName': voter.tamilLocation, // Using tamil location as father tamil name
                    'location': voter.location,
                    'tamilLocation': voter.tamilLocation,
                    'voterId': voter.voterId,
                    'doorNo': voter.doorNo,
                    'partNumber': '1', // Default part number
                    'section': '1', // Default section
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
                      if (voter.serialNo == 1) // Show notification badge for first voter
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
                        // Clear all fields
                        _mobileController.clear();
                        _partNoController.clear();
                        _serialNoController.clear();
                        _epicIdController.clear();
                        _voterFirstNameController.clear();
                        _voterLastNameController.clear();
                        _relationFirstNameController.clear();
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
                        // Implement search logic here
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Age filter
                      _buildAgeFilter(setModalState),
                      const SizedBox(height: 30),
                      
                      // Gender filter
                      _buildGenderFilter(setModalState),
                      const SizedBox(height: 30),
                      
                      // Voter History filter
                      _buildVoterHistoryFilter(setModalState),
                      const SizedBox(height: 30),
                      
                      // Voter Category filter
                      _buildVoterCategoryFilter(setModalState),
                      const SizedBox(height: 30),
                      
                      // Political Party filter
                      _buildPoliticalPartyFilter(setModalState),
                      const SizedBox(height: 30),
                      
                      // Religion filter
                      _buildReligionFilter(setModalState),
                      const SizedBox(height: 30),
                    ],
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

  Widget _buildAgeFilter(StateSetter setModalState) {
    return Column(
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
    );
  }

  Widget _buildGenderFilter(StateSetter setModalState) {
    return Column(
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
    );
  }

  Widget _buildVoterHistoryFilter(StateSetter setModalState) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Voter History',
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
            _buildHistoryChip('2024', 'PC', Color(0xFF1976D2), setModalState),
            _buildHistoryChip('2022', 'ULB', Color(0xFFD32F2F), setModalState),
            _buildHistoryChip('2021', 'AC', Color(0xFF388E3C), setModalState),
            _buildNotVotedChip(setModalState),
          ],
        ),
      ],
    );
  }

  Widget _buildVoterCategoryFilter(StateSetter setModalState) {
    return Column(
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
            _buildCategoryIcon(Icons.check_circle, Colors.green, 'Active', setModalState),
            _buildCategoryIcon(Icons.cancel, Colors.red, 'Inactive', setModalState),
            _buildCategoryIcon(Icons.help, Colors.grey, 'Unknown', setModalState),
            _buildCategoryIcon(Icons.trending_up, Colors.blue, 'New', setModalState),
            _buildCategoryIcon(Icons.delete, Colors.black, 'Deleted', setModalState),
            _buildCategoryIcon(Icons.arrow_forward, Colors.blue, 'Shifted', setModalState),
            _buildCategoryIcon(Icons.accessibility, Colors.grey, 'Disabled', setModalState),
            _buildCategoryIcon(Icons.family_restroom, Colors.brown, 'Family', setModalState),
            _buildCategoryIcon(Icons.calendar_today, Colors.blue, 'Birthday', setModalState),
            _buildCategoryIcon(Icons.schedule, Colors.grey, 'Pending', setModalState),
            _buildCategoryIcon(Icons.store, Colors.red, 'Business', setModalState),
            _buildCategoryIcon(Icons.people, Colors.pink, 'Community', setModalState),
            _buildCategoryIcon(Icons.school, Colors.green, 'Student', setModalState),
            _buildCategoryIcon(Icons.work, Colors.orange, 'Professional', setModalState),
          ],
        ),
      ],
    );
  }

  Widget _buildPoliticalPartyFilter(StateSetter setModalState) {
    return Column(
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
            _buildPartyIcon('🌿', 'Green Party', setModalState),
            _buildPartyIcon('🪷', 'BJP', setModalState),
            _buildPartyIcon('🛡️', 'Shield Party', setModalState),
            _buildPartyIcon('🏺', 'Pot Party', setModalState),
            _buildPartyIcon('🥨', 'Basket Party', setModalState),
            _buildPartyIcon('⚫', 'Black Party', setModalState),
            _buildPartyIcon('🌞', 'Sun Party', setModalState),
            _buildPartyIcon('🇮🇳', 'National Party', setModalState),
            _buildPartyIcon('🔵', 'Blue Party', setModalState),
            _buildPartyIcon('🔴', 'Red Party', setModalState),
            _buildPartyIcon('☭', 'Communist Party', setModalState),
            _buildPartyIcon('🎯', 'Target Party', setModalState),
            _buildPartyIcon('🎤', 'Voice Party', setModalState),
          ],
        ),
      ],
    );
  }

  Widget _buildReligionFilter(StateSetter setModalState) {
    return Column(
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
            _buildReligionIcon('🕉️', 'Hindu', setModalState),
            _buildReligionIcon('☪️', 'Islam', setModalState),
            _buildReligionIcon('✝️', 'Christian', setModalState),
            _buildReligionIcon('🤲', 'Buddhist', setModalState),
            _buildReligionIcon('☬', 'Sikh', setModalState),
            _buildReligionIcon('🔯', 'Jain', setModalState),
          ],
        ),
      ],
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

  Widget _buildHistoryChip(String year, String type, Color color, StateSetter setModalState) {
    String key = '$year $type'.trim();
    bool isSelected = selectedVoterHistory.contains(key);
    return GestureDetector(
      onTap: () {
        setModalState(() {
          if (isSelected) {
            selectedVoterHistory.remove(key);
          } else {
            selectedVoterHistory.add(key);
          }
        });
      },
      child: Container(
        width: 70,
        height: 70,
        decoration: BoxDecoration(
          color: isSelected ? color.withValues(alpha: 0.2) : Colors.grey[100],
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? color : Colors.grey[300]!,
            width: 2,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                year,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
            const SizedBox(height: 4),
            if (type.isNotEmpty)
              Container(
                padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  type,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotVotedChip(StateSetter setModalState) {
    String key = 'Not Voted';
    bool isSelected = selectedVoterHistory.contains(key);
    return GestureDetector(
      onTap: () {
        setModalState(() {
          if (isSelected) {
            selectedVoterHistory.remove(key);
          } else {
            selectedVoterHistory.add(key);
          }
        });
      },
      child: Container(
        width: 70,
        height: 70,
        decoration: BoxDecoration(
          color: isSelected ? Colors.grey.withValues(alpha: 0.3) : Colors.grey[100],
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? Colors.grey[600]! : Colors.grey[300]!,
            width: 2,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.close,
                color: Colors.white,
                size: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryIcon(IconData icon, Color color, String label, StateSetter setModalState) {
    bool isSelected = selectedVoterCategory.contains(label);
    return GestureDetector(
      onTap: () {
        setModalState(() {
          if (isSelected) {
            selectedVoterCategory.remove(label);
          } else {
            selectedVoterCategory.add(label);
          }
        });
      },
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: isSelected ? color.withValues(alpha: 0.2) : Colors.grey[100],
          shape: BoxShape.circle,
          border: Border.all(
            color: isSelected ? color : Colors.grey[300]!,
          ),
        ),
        child: Icon(
          icon,
          color: color,
          size: 24,
        ),
      ),
    );
  }

  Widget _buildPartyIcon(String emoji, String label, StateSetter setModalState) {
    bool isSelected = selectedPoliticalParty.contains(label);
    return GestureDetector(
      onTap: () {
        setModalState(() {
          if (isSelected) {
            selectedPoliticalParty.remove(label);
          } else {
            selectedPoliticalParty.add(label);
          }
        });
      },
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue.withValues(alpha: 0.2) : Colors.grey[100],
          shape: BoxShape.circle,
          border: Border.all(
            color: isSelected ? Colors.blue : Colors.grey[300]!,
          ),
        ),
        child: Center(
          child: Text(
            emoji,
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }

  Widget _buildReligionIcon(String emoji, String label, StateSetter setModalState) {
    bool isSelected = selectedReligion.contains(label);
    return GestureDetector(
      onTap: () {
        setModalState(() {
          if (isSelected) {
            selectedReligion.remove(label);
          } else {
            selectedReligion.add(label);
          }
        });
      },
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: isSelected ? Colors.orange.withValues(alpha: 0.2) : Colors.grey[100],
          shape: BoxShape.circle,
          border: Border.all(
            color: isSelected ? Colors.orange : Colors.grey[300]!,
          ),
        ),
        child: Center(
          child: Text(
            emoji,
            style: TextStyle(fontSize: 20),
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

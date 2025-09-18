import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../l10n/app_localizations.dart';
import 'voter_info_screen.dart';

class BirthdayVoter {
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
  final DateTime birthDate;

  BirthdayVoter({
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
    required this.birthDate,
  });
}

class BirthdayScreen extends StatefulWidget {
  const BirthdayScreen({super.key});

  @override
  State<BirthdayScreen> createState() => _BirthdayScreenState();
}

class _BirthdayScreenState extends State<BirthdayScreen> {
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _partNoController = TextEditingController();
  final TextEditingController _serialNoController = TextEditingController();
  final TextEditingController _epicIdController = TextEditingController();
  final TextEditingController _voterFirstNameController = TextEditingController();
  final TextEditingController _voterLastNameController = TextEditingController();
  final TextEditingController _relationFirstNameController = TextEditingController();
  
  DateTime selectedDate = DateTime.now();
  String selectedDateFilter = 'Today'; // 'Today', 'Tomorrow', 'Both'
  DateTime? customSelectedDate;
  String selectedMonth = 'All';
  bool showUpcomingBirthdays = false;
  int upcomingDays = 7; // Show birthdays in next 7 days
  String selectedAgeGroup = 'All'; // 'All', '18-30', '31-50', '51+'
  
  // Filter state variables
  double minAge = 18;
  double maxAge = 120;
  Set<String> selectedGenders = {};
  Set<String> selectedVoterHistory = {};
  Set<String> selectedVoterCategory = {};
  Set<String> selectedPoliticalParty = {};
  Set<String> selectedReligion = {};

  final List<BirthdayVoter> allVoters = [
    BirthdayVoter(
      serialNo: 424,
      name: 'manikandan',
      tamilName: 'மணிகண்டன்',
      location: 'padmanathan',
      tamilLocation: 'பத்மநாதன்',
      voterId: 'RIV1048222',
      doorNo: '95-15',
      age: 29,
      relation: 'Father',
      gender: 'Male',
      mobileNumber: '+91 9876543210',
      politicalParty: 'DMK',
      religion: 'Hindu',
      voterCategory: 'General',
      birthDate: DateTime.now(), // Today's birthday
    ),
    BirthdayVoter(
      serialNo: 364,
      name: 'shantha',
      tamilName: 'சாந்தா',
      location: 'krishnan street',
      tamilLocation: 'கிருஷ்ணன் தெரு',
      voterId: 'RIV2347865',
      doorNo: '12-A',
      age: 45,
      relation: 'Mother',
      gender: 'Female',
      mobileNumber: '+91 8765432109',
      politicalParty: 'AIADMK',
      religion: 'Hindu',
      voterCategory: 'General',
      birthDate: DateTime.now().add(Duration(days: 1)), // Tomorrow's birthday
    ),
    BirthdayVoter(
      serialNo: 156,
      name: 'rajesh kumar',
      tamilName: 'ராஜேஷ் குமார்',
      location: 'gandhi nagar',
      tamilLocation: 'காந்தி நகர்',
      voterId: 'RIV9876543',
      doorNo: '78-B',
      age: 35,
      relation: 'Father',
      gender: 'Male',
      mobileNumber: '+91 7654321098',
      politicalParty: 'BJP',
      religion: 'Hindu',
      voterCategory: 'OBC',
      birthDate: DateTime.now(), // Today's birthday
    ),
  ];

  List<BirthdayVoter> filteredVoters = [];

  @override
  void initState() {
    super.initState();
    filteredVoters = allVoters;
    _applyDateFilter();
  }

  void _applyDateFilter() {
    setState(() {
      DateTime today = DateTime.now();
      DateTime tomorrow = today.add(Duration(days: 1));
      
      filteredVoters = allVoters.where((voter) {
        bool matchesDate = false;
        
        if (selectedDateFilter == 'Today') {
          matchesDate = _isSameDay(voter.birthDate, today);
        } else if (selectedDateFilter == 'Tomorrow') {
          matchesDate = _isSameDay(voter.birthDate, tomorrow);
        } else if (selectedDateFilter == 'Both') {
          matchesDate = _isSameDay(voter.birthDate, today) || 
                       _isSameDay(voter.birthDate, tomorrow);
        }
        
        return matchesDate && _applyAllFilters(voter);
      }).toList();
    });
  }

  bool _isSameDay(DateTime date1, DateTime date2) {
    return date1.day == date2.day && date1.month == date2.month;
  }

  bool _applyAllFilters(BirthdayVoter voter) {
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
                          AppLocalizations.of(context)?.birthday ?? 'Birthday',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: _showDatePicker,
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Color(0xFF1976D2),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(
                            Icons.calendar_today,
                            color: Colors.white,
                            size: 24,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
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

  Widget _buildVoterCard(BirthdayVoter voter) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
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
              GestureDetector(
                onTap: _showAdvancedSearch,
                child: Text(
                  'Serial No: ${voter.serialNo}',
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF1976D2),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Spacer(),
              // Voter ID badge
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
                voter.relation,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.black54,
                ),
              ),
              Spacer(),
              // Action icons at bottom right
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
                      // Handle birthday celebration
                    },
                    child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.orange,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.cake, color: Colors.white, size: 16),
                    ),
                  ),
                  const SizedBox(width: 8),
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
                        color: Color(0xFF1976D2),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.family_restroom, color: Colors.white, size: 16),
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

  void _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: customSelectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now().add(Duration(days: 365)),
      helpText: 'Select Birthday Date',
      cancelText: 'Cancel',
      confirmText: 'Select',
    ).then((pickedDate) {
      if (pickedDate != null) {
        setState(() {
          customSelectedDate = pickedDate;
          selectedDateFilter = 'Custom';
          // Filter voters for selected date
          _applySimpleDateFilter();
        });
      }
    });
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
                          _applyDateFilter();
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
              Container(
                width: double.infinity,
                margin: EdgeInsets.fromLTRB(20, 0, 20, 20),
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    'Close',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
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
                      _buildSearchField(AppLocalizations.of(context)?.epicId ?? 'EPIC Id', _epicIdController),
                      const SizedBox(height: 20),
                      _buildSearchField(AppLocalizations.of(context)?.voterFirstName ?? 'Voter First Name', _voterFirstNameController),
                      const SizedBox(height: 20),
                      _buildSearchField(AppLocalizations.of(context)?.voterLastName ?? 'Voter Last Name', _voterLastNameController),
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
                        AppLocalizations.of(context)?.clear ?? 'Clear',
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

  void _applySimpleDateFilter() {
    setState(() {
      if (customSelectedDate != null) {
        filteredVoters = allVoters.where((voter) {
          return voter.birthDate.month == customSelectedDate!.month &&
                 voter.birthDate.day == customSelectedDate!.day;
        }).toList();
      } else {
        filteredVoters = allVoters;
      }
    });
  }









  // Helper methods for calendar functionality









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




import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'transgender_voter_info_screen.dart';
import 'voter_info_screen.dart';
import '../widgets/unified_voter_filter.dart';

class TransgenderScreen extends StatefulWidget {
  const TransgenderScreen({super.key});

  @override
  State<TransgenderScreen> createState() => _TransgenderScreenState();
}

class _TransgenderScreenState extends State<TransgenderScreen> {
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _partNoController = TextEditingController();
  final TextEditingController _serialNoController = TextEditingController();
  final TextEditingController _epicIdController = TextEditingController();
  final TextEditingController _voterFirstNameController = TextEditingController();
  final TextEditingController _voterLastNameController = TextEditingController();
  final TextEditingController _relationFirstNameController = TextEditingController();
  final TextEditingController _relationLastNameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  
  // Filter state variables
  double minAge = 18;
  double maxAge = 120;
  Set<String> selectedGenders = {};
  Set<String> selectedVoterHistory = {};
  Set<String> selectedVoterCategory = {};
  Set<String> selectedPoliticalParty = {};
  Set<String> selectedReligion = {};

  final List<TransgenderVoter> voters = [
    TransgenderVoter(
      serialNo: 590,
      name: 'rajeswari',
      tamilName: 'ராஜேஸ்வரி',
      location: 'ramalingam',
      tamilLocation: 'ராமலிங்கம்',
      voterId: 'RIV2196350',
      doorNo: '2/1',
      age: 45,
      relation: 'Husband',
    ),
    TransgenderVoter(
      serialNo: 966,
      name: 'shivani',
      tamilName: 'ஷிவானி',
      location: 'thondamuthur',
      tamilLocation: 'தொண்டமுத்தூர்',
      voterId: 'RIV3456789',
      doorNo: '5/2',
      age: 32,
      relation: 'Wife',
    ),
  ];

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
    _relationLastNameController.dispose();
    _ageController.dispose();
    super.dispose();
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
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.3),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.black87,
                        size: 24,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        'Transgender',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
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
                        color: Colors.grey[600],
                        size: 24,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 20),
            
            // Search section
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16),
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
            
            const SizedBox(height: 30),
            
            // Statistics cards section
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Expanded(
                    child: _buildStatCard('Male:', '0', Colors.green[100]!, Colors.green),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildStatCard('Female:', '0', Colors.pink[100]!, Colors.pink),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildStatCard('Others:', '145', Colors.grey[200]!, Colors.grey[600]!),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildStatCard('Total:', '145', Colors.blue[100]!, Colors.blue),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 30),
            
            // Voters list
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 16),
                itemCount: voters.length,
                itemBuilder: (context, index) {
                  final voter = voters[index];
                  return Padding(
                    padding: EdgeInsets.only(bottom: 16),
                    child: _buildVoterCard(voter),
                  );
                },
              ),
            ),
            
            // Bottom navigation
            Container(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildBottomNavItem('Report', Icons.trending_up_outlined, false),
                  _buildBottomNavItem('Catalogue', Icons.list_alt_outlined, false),
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
                  _buildBottomNavItem('Slip Box', Icons.inventory_outlined, false),
                  _buildBottomNavItem('Poll Day', Icons.how_to_vote_outlined, false),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String label, String count, Color backgroundColor, Color? textColor) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: textColor?.withValues(alpha: 0.3) ?? Colors.grey[300]!,
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: Colors.black87,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            count,
            style: TextStyle(
              fontSize: 24,
              color: textColor ?? Colors.black87,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVoterCard(TransgenderVoter voter) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TransgenderVoterInfoScreen(voter: voter),
          ),
        );
      },
      child: Container(
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
            // Serial number header
            Row(
              children: [
                Icon(
                  Icons.star_border,
                  color: Colors.pink,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  'Serial No: ${voter.serialNo}',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFF1976D2),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 16),
            
            Row(
              children: [
                // Profile image section
                Container(
                  width: 80,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey[300]!),
                  ),
                  child: Stack(
                    children: [
                      Center(
                        child: Icon(
                          Icons.person,
                          size: 40,
                          color: Colors.blue,
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 4),
                          decoration: BoxDecoration(
                            color: Color(0xFF1976D2),
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(8),
                              bottomRight: Radius.circular(8),
                            ),
                          ),
                          child: Text(
                            voter.voterId,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 25,
                        right: -5,
                        child: Container(
                          padding: EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.check,
                            color: Colors.white,
                            size: 12,
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
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      Text(
                        voter.tamilName,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black54,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        voter.location,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                        ),
                      ),
                      Text(
                        voter.tamilLocation,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black54,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Door No ${voter.doorNo}',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 16),
            
            // Bottom section with age and relation
            Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.orange[100],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.person,
                        size: 16,
                        color: Colors.orange[700],
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${voter.age}',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.orange[700],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
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
                Spacer(),
                // Action icons
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => _makePhoneCall('9965161134'), // Default phone number
                      child: Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.blue.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Icon(Icons.phone, color: Colors.blue, size: 16),
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
                          'gender': 'Other', // Transgender
                          'relation': voter.relation,
                          'mobileNumber': '9965161134', // Default mobile
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
                          color: Colors.green.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Icon(Icons.family_restroom, color: Colors.green, size: 16),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNavItem(String title, IconData icon, bool isSelected) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          size: 24,
          color: isSelected ? Color(0xFF1976D2) : Colors.black54,
        ),
        const SizedBox(height: 4),
        Text(
          title,
          style: TextStyle(
            fontSize: 10,
            color: isSelected ? Color(0xFF1976D2) : Colors.black54,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }

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
            // Header
            Container(
              padding: EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Advance Search',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Icon(
                      Icons.close,
                      size: 24,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
            
            // Scrollable form fields
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
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
                    const SizedBox(height: 16),
                    _buildSearchField('Relation Last Name', _relationLastNameController),
                    const SizedBox(height: 16),
                    _buildSearchField('Age', _ageController),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
            
            // Bottom buttons
            Container(
              padding: EdgeInsets.all(20),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Search functionality implemented!'),
                            backgroundColor: Color(0xFF1976D2),
                          ),
                        );
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
                  const SizedBox(width: 16),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        _clearSearchFields();
                        Navigator.pop(context);
                      },
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.black54,
                        padding: EdgeInsets.symmetric(vertical: 16),
                        side: BorderSide(color: Colors.grey[300]!),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        'Cancel',
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
    _relationLastNameController.clear();
    _ageController.clear();
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

class TransgenderVoter {
  final int serialNo;
  final String name;
  final String tamilName;
  final String location;
  final String tamilLocation;
  final String voterId;
  final String doorNo;
  final int age;
  final String relation;

  TransgenderVoter({
    required this.serialNo,
    required this.name,
    required this.tamilName,
    required this.location,
    required this.tamilLocation,
    required this.voterId,
    required this.doorNo,
    required this.age,
    required this.relation,
  });
}

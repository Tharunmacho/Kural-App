import 'package:flutter/material.dart';
import 'voter_info_screen.dart';

class VoterListScreen extends StatefulWidget {
  final int partNumber;

  const VoterListScreen({super.key, required this.partNumber});

  @override
  State<VoterListScreen> createState() => _VoterListScreenState();
}

class _VoterListScreenState extends State<VoterListScreen> {
  final TextEditingController _searchController = TextEditingController();
  
  // Advanced search controllers (same as voter_info_screen)
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _partNoController = TextEditingController();
  final TextEditingController _serialNoController = TextEditingController();
  final TextEditingController _epicIdController = TextEditingController();
  final TextEditingController _voterFirstNameController = TextEditingController();
  final TextEditingController _voterLastNameController = TextEditingController();
  final TextEditingController _relationFirstNameController = TextEditingController();
  final TextEditingController _relationLastNameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  
  // Additional functionality state
  bool isSelectionMode = false;
  Set<int> selectedVoters = {};
  String currentSortBy = 'serialNo';
  bool sortAscending = true;
  DateTime? selectedFromDate;
  DateTime? selectedToDate;
  String selectedGenderFilter = 'All';
  RangeValues ageRange = RangeValues(18, 80);
  List<String> searchHistory = [];
  String currentViewMode = 'card'; // card, list, grid
  
  // Sample voter data
  List<Map<String, dynamic>> voters = [
    {
      'serialNo': 1,
      'name': 'Rajesh Kumar',
      'tamilName': 'ராஜேஷ் குமார்',
      'relation': 'Father',
      'voterId': 'TN1234567890',
      'doorNo': '12A',
      'age': 45,
      'familyCount': 4,
      'gender': 'Male',
      'voterName': 'Rajesh Kumar',
      'fatherName': 'Murugan',
      'address': '12A, Gandhi Street, Chennai',
      'phoneNumber': '9876543210'
    },
    {
      'serialNo': 2,
      'name': 'Priya Devi',
      'tamilName': 'பிரியா தேவி',
      'relation': 'Wife',
      'voterId': 'TN1234567891',
      'doorNo': '12A',
      'age': 42,
      'familyCount': 4,
      'gender': 'Female',
      'voterName': 'Priya Devi',
      'fatherName': 'Rajesh Kumar',
      'address': '12A, Gandhi Street, Chennai',
      'phoneNumber': '9876543211'
    },
    {
      'serialNo': 3,
      'name': 'Arjun Kumar',
      'tamilName': 'அர்ஜுன் குமார்',
      'relation': 'Son',
      'voterId': 'TN1234567892',
      'doorNo': '12A',
      'age': 22,
      'familyCount': 4,
      'gender': 'Male',
      'voterName': 'Arjun Kumar',
      'fatherName': 'Rajesh Kumar',
      'address': '12A, Gandhi Street, Chennai',
      'phoneNumber': '9876543212'
    },
    {
      'serialNo': 4,
      'name': 'Meera Kumar',
      'tamilName': 'மீரா குமார்',
      'relation': 'Daughter',
      'voterId': 'TN1234567893',
      'doorNo': '12A',
      'age': 19,
      'familyCount': 4,
      'gender': 'Female',
      'voterName': 'Meera Kumar',
      'fatherName': 'Rajesh Kumar',
      'address': '12A, Gandhi Street, Chennai',
      'phoneNumber': '9876543213'
    },
    {
      'serialNo': 5,
      'name': 'Suresh Babu',
      'tamilName': 'சுரேஷ் பாபு',
      'relation': 'Father',
      'voterId': 'TN1234567894',
      'doorNo': '15B',
      'age': 52,
      'familyCount': 3,
      'gender': 'Male',
      'voterName': 'Suresh Babu',
      'fatherName': 'Krishnan',
      'address': '15B, Anna Nagar, Chennai',
      'phoneNumber': '9876543214'
    },
  ];

  // Getters for statistics
  int get maleCount => voters.where((v) => v['gender'] == 'Male').length;
  int get femaleCount => voters.where((v) => v['gender'] == 'Female').length;
  int get otherCount => voters.where((v) => v['gender'] != 'Male' && v['gender'] != 'Female').length;
  int get totalCount => voters.length;

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
                        'Part Number ${widget.partNumber}',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Text(
                      '${voters.length} Voters',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Enhanced search bar with multiple functionality buttons
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.grey[300]!),
                          ),
                          child: TextField(
                            controller: _searchController,
                            onChanged: (value) {
                              if (value.isNotEmpty && !searchHistory.contains(value)) {
                                setState(() {
                                  searchHistory.add(value);
                                  if (searchHistory.length > 5) {
                                    searchHistory.removeAt(0);
                                  }
                                });
                              }
                            },
                            decoration: InputDecoration(
                              hintText: 'Voter Id or Voter Name',
                              hintStyle: TextStyle(color: Colors.grey[500]),
                              prefixIcon: Icon(Icons.search, color: Colors.grey[600]),
                              suffixIcon: _searchController.text.isNotEmpty
                                  ? IconButton(
                                      icon: Icon(Icons.clear, color: Colors.grey[600]),
                                      onPressed: () {
                                        setState(() {
                                          _searchController.clear();
                                        });
                                      },
                                    )
                                  : null,
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      _buildActionButton(Icons.tune, 'Filter', _showAdvancedSearch),
                      const SizedBox(width: 6),
                      _buildActionButton(Icons.sort, 'Sort', _showSortOptions),
                      const SizedBox(width: 6),
                      _buildActionButton(Icons.date_range, 'Date', _showDatePicker),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      _buildActionButton(Icons.select_all, 'Select', _toggleSelectionMode),
                      const SizedBox(width: 6),
                      _buildActionButton(Icons.file_download, 'Export', _showExportOptions),
                      const SizedBox(width: 6),
                      _buildActionButton(Icons.analytics, 'Stats', _showAnalytics),
                      const SizedBox(width: 6),
                      _buildActionButton(Icons.view_module, 'View', _showViewOptions),
                      Spacer(),
                      if (isSelectionMode) ...[
                        Text(
                          '${selectedVoters.length} selected',
                          style: TextStyle(
                            color: Color(0xFF1976D2),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(width: 8),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedVoters.clear();
                              isSelectionMode = false;
                            });
                          },
                          child: Icon(Icons.close, color: Colors.grey[600]),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Gender statistics
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16),
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildStatCard('Male:', maleCount.toString(), Color(0xFF2196F3)),
                  _buildStatCard('Female:', femaleCount.toString(), Color(0xFFE91E63)),
                  _buildStatCard('Others:', otherCount.toString(), Color(0xFFFF9800)),
                  _buildStatCard('Total:', totalCount.toString(), Color(0xFF2196F3)),
                ],
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Voters list
            Expanded(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 16),
                child: ListView.builder(
                  itemCount: voters.length,
                  itemBuilder: (context, index) {
                    final voter = voters[index];
                    return _buildVoterCard(voter);
                  },
                ),
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Bottom navigation
            Container(
              padding: const EdgeInsets.symmetric(vertical: 16),
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
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(IconData icon, String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey[300]!),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: Colors.grey[600], size: 16),
            const SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(
                fontSize: 10,
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVoterCard(Map<String, dynamic> voter) {
    bool isSelected = selectedVoters.contains(voter['serialNo']);
    
    return GestureDetector(
      onTap: () {
        if (isSelectionMode) {
          setState(() {
            if (isSelected) {
              selectedVoters.remove(voter['serialNo']);
            } else {
              selectedVoters.add(voter['serialNo']);
            }
          });
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => VoterInfoScreen(voterData: voter),
            ),
          );
        }
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: isSelected 
              ? Border.all(color: Color(0xFF1976D2), width: 2)
              : null,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 8,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Serial number with star
                  Row(
                    children: [
                      Icon(
                        Icons.star_outline,
                        color: Color(0xFFE91E63),
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Serial No: ${voter['serialNo']}',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF1976D2),
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // Main content row
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Photo placeholder
                      Container(
                        width: 80,
                        height: 100,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.grey[300]!),
                        ),
                        child: Icon(
                          Icons.person,
                          size: 40,
                          color: Colors.grey[500],
                        ),
                      ),
                      
                      const SizedBox(width: 16),
                      
                      // Voter details
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Name
                            Text(
                              voter['name'],
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                            Text(
                              voter['tamilName'],
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black87,
                              ),
                            ),
                            
                            const SizedBox(height: 8),
                            
                            // Relation
                            Text(
                              'Relation: ${voter['relation']}',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[700],
                              ),
                            ),
                            
                            const SizedBox(height: 4),
                            
                            // Voter ID
                            Text(
                              'Voter ID: ${voter['voterId']}',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF1976D2),
                              ),
                            ),
                            
                            const SizedBox(height: 4),
                            
                            // Door number and Age
                            Row(
                              children: [
                                Text(
                                  'Door No: ${voter['doorNo']}',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey[700],
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Text(
                                  'Age: ${voter['age']}',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey[700],
                                  ),
                                ),
                              ],
                            ),
                            
                            const SizedBox(height: 8),
                            
                            // Family count with icon
                            if (voter['familyCount'] > 0)
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: Color(0xFF1976D2).withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.family_restroom,
                                      color: Color(0xFF1976D2),
                                      size: 16,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      '${voter['familyCount']} Members',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Color(0xFF1976D2),
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Selection checkbox
            if (isSelectionMode)
              Positioned(
                top: 8,
                right: 8,
                child: Container(
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: isSelected ? Color(0xFF1976D2) : Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isSelected ? Color(0xFF1976D2) : Colors.grey[400]!,
                    ),
                  ),
                  child: Icon(
                    Icons.check,
                    color: isSelected ? Colors.white : Colors.transparent,
                    size: 16,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String label, String value, Color color) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
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

  Widget _buildSearchField(String label, TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Color(0xFF1976D2)),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
    );
  }

  // New functionality methods
  void _toggleSelectionMode() {
    setState(() {
      isSelectionMode = !isSelectionMode;
      if (!isSelectionMode) {
        selectedVoters.clear();
      }
    });
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
              const SizedBox(height: 16),
              _buildSearchField('Relation Last Name', _relationLastNameController),
              const SizedBox(height: 16),
              _buildSearchField('Age', _ageController),
              const SizedBox(height: 24),
              
              // Gender filter
              Text('Gender Filter', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                children: ['All', 'Male', 'Female', 'Other'].map((gender) {
                  return FilterChip(
                    label: Text(gender),
                    selected: selectedGenderFilter == gender,
                    onSelected: (selected) {
                      setState(() {
                        selectedGenderFilter = gender;
                      });
                    },
                  );
                }).toList(),
              ),
              
              const SizedBox(height: 24),
              
              // Age range filter
              Text('Age Range', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
              const SizedBox(height: 8),
              RangeSlider(
                values: ageRange,
                min: 18,
                max: 100,
                divisions: 82,
                labels: RangeLabels(
                  ageRange.start.round().toString(),
                  ageRange.end.round().toString(),
                ),
                onChanged: (RangeValues values) {
                  setState(() {
                    ageRange = values;
                  });
                },
              ),
              
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          // Reset all search fields
                          _mobileController.clear();
                          _partNoController.clear();
                          _serialNoController.clear();
                          _epicIdController.clear();
                          _voterFirstNameController.clear();
                          _voterLastNameController.clear();
                          _relationFirstNameController.clear();
                          _relationLastNameController.clear();
                          _ageController.clear();
                          // Reset filters
                          selectedGenderFilter = 'All';
                          ageRange = RangeValues(18, 80);
                          selectedFromDate = null;
                          selectedToDate = null;
                        });
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[300],
                        foregroundColor: Colors.black87,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text('Reset'),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Advanced search filters applied successfully!')),
                        );
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

  void _showSortOptions() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Sort Options',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            ListTile(
              leading: Icon(Icons.sort_by_alpha),
              title: Text('Sort by Name'),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Sorted by Name')),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.numbers),
              title: Text('Sort by Serial Number'),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Sorted by Serial Number')),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.calendar_today),
              title: Text('Sort by Age'),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Sorted by Age')),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showDatePicker() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Select Date',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            
            Text('DOB', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            const SizedBox(height: 12),
            
            // Date selection buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildDateButton('Today', true),
                _buildDateButton('Tomorrow', false),
                _buildDateButton('Both', false),
              ],
            ),
            
            const SizedBox(height: 20),
            
            // Calendar grid
            GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 7,
                childAspectRatio: 1.0,
              ),
              itemCount: 28,
              itemBuilder: (context, index) {
                int day = index + 1;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedFromDate = DateTime.now().copyWith(day: day);
                    });
                  },
                  child: Container(
                    margin: EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: selectedFromDate?.day == day 
                          ? Color(0xFF1976D2) 
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text(
                        day.toString(),
                        style: TextStyle(
                          color: selectedFromDate?.day == day 
                              ? Colors.white 
                              : Colors.black87,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
            
            const SizedBox(height: 20),
            
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Date filter applied!')),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF1976D2),
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 12),
                ),
                child: Text('Apply'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDateButton(String text, bool isSelected) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? Color(0xFF1976D2) : Colors.grey[200],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: isSelected ? Colors.white : Colors.black87,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  void _showExportOptions() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Export Options',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ListTile(
              leading: Icon(Icons.picture_as_pdf, color: Colors.red),
              title: Text('Export as PDF'),
              subtitle: Text('${selectedVoters.isNotEmpty ? selectedVoters.length : totalCount} voters'),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('PDF export started...')),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.table_chart, color: Colors.green),
              title: Text('Export as Excel'),
              subtitle: Text('${selectedVoters.isNotEmpty ? selectedVoters.length : totalCount} voters'),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Excel export started...')),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.share, color: Colors.blue),
              title: Text('Share List'),
              subtitle: Text('Share voter information'),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Sharing options opened...')),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showAnalytics() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.7,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              'Voter Analytics',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            
            // Age distribution
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Age Distribution',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(child: _buildAgeGroup('18-30', '25%', Colors.blue)),
                      Expanded(child: _buildAgeGroup('31-50', '45%', Colors.green)),
                      Expanded(child: _buildAgeGroup('51+', '30%', Colors.orange)),
                    ],
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Participation rate
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Icon(Icons.how_to_vote, color: Color(0xFF1976D2)),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Participation Rate',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      Text('85.2%', style: TextStyle(fontSize: 24, color: Colors.green)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAgeGroup(String label, String percentage, Color color) {
    return Column(
      children: [
        Container(
          height: 40,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Text(
              percentage,
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(label, style: TextStyle(fontSize: 12)),
      ],
    );
  }

  void _showViewOptions() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'View Options',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ListTile(
              leading: Icon(Icons.view_agenda),
              title: Text('Card View'),
              trailing: currentViewMode == 'card' ? Icon(Icons.check, color: Color(0xFF1976D2)) : null,
              onTap: () {
                setState(() {
                  currentViewMode = 'card';
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.view_list),
              title: Text('List View'),
              trailing: currentViewMode == 'list' ? Icon(Icons.check, color: Color(0xFF1976D2)) : null,
              onTap: () {
                setState(() {
                  currentViewMode = 'list';
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.view_module),
              title: Text('Grid View'),
              trailing: currentViewMode == 'grid' ? Icon(Icons.check, color: Color(0xFF1976D2)) : null,
              onTap: () {
                setState(() {
                  currentViewMode = 'grid';
                });
                Navigator.pop(context);
              },
            ),
          ],
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
    _relationLastNameController.dispose();
    _ageController.dispose();
    super.dispose();
  }
}

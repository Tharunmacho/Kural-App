import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'voter_info_screen.dart';

class PartDetailsScreen extends StatefulWidget {
  final int partNumber;
  
  const PartDetailsScreen({super.key, required this.partNumber});

  @override
  State<PartDetailsScreen> createState() => _PartDetailsScreenState();
}

class _PartDetailsScreenState extends State<PartDetailsScreen> {
  final TextEditingController _searchController = TextEditingController();
  
  // Filter state variables (comprehensive)
  double minAge = 18;
  double maxAge = 120;
  Set<String> selectedGenders = {};
  Set<String> selectedVoterHistory = {};
  Set<String> selectedVoterCategory = {};
  Set<String> selectedPoliticalParty = {};
  Set<String> selectedReligion = {};

  @override
  void dispose() {
    _searchController.dispose();
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
                    width: 40,
                  ), // Spacer to center the title
                ],
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Search section
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey[300]!),
              ),
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.all(12),
                    child: Icon(
                      Icons.search,
                      color: Colors.grey[600],
                      size: 24,
                    ),
                  ),
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: 'Voter Id or Voter Name',
                        hintStyle: TextStyle(
                          color: Colors.grey[400],
                          fontSize: 16,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(12),
                    child: Icon(
                      Icons.swap_vert,
                      color: Colors.grey[600],
                      size: 24,
                    ),
                  ),
                  GestureDetector(
                    onTap: _showFilterModal,
                    child: Container(
                      padding: EdgeInsets.all(12),
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
            
            const SizedBox(height: 16),
            
            // Statistics section
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Expanded(
                    child: _buildStatCard('Male:', '673', Color(0xFF4CAF50)),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _buildStatCard('Female:', '782', Colors.pink),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _buildStatCard('Other:', '0', Colors.grey),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _buildStatCard('Total:', '1455', Colors.lightBlue),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 20),
            
            // Voter cards section
            Expanded(
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 16),
                children: [
                  _buildVoterCard(
                    serialNo: 1,
                    name: 'prabhakar',
                    tamilName: 'பிரபாகர்',
                    fatherName: 'srinivasan',
                    fatherTamilName: 'சீனிவாசன்',
                    voterId: 'RIV0893552',
                    doorNo: 'Door No 1',
                    age: 72,
                    relation: 'Father',
                    familyCount: 1,
                  ),
                  const SizedBox(height: 16),
                  _buildVoterCard(
                    serialNo: 2,
                    name: 'ramalingam',
                    tamilName: 'ராமலிங்கம்',
                    fatherName: 'prabakaran',
                    fatherTamilName: 'பிரபாகரன்',
                    voterId: 'RIV0893553',
                    doorNo: 'Door No 2',
                    age: 45,
                    relation: 'Self',
                    familyCount: 0,
                  ),
                ],
              ),
            ),
            
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

  Widget _buildStatCard(String label, String value, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Column(
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: Colors.black87,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVoterCard({
    required int serialNo,
    required String name,
    required String tamilName,
    required String fatherName,
    required String fatherTamilName,
    required String voterId,
    required String doorNo,
    required int age,
    required String relation,
    required int familyCount,
  }) {
    return GestureDetector(
      onTap: () {
        // Navigate to Voter Info screen with voter data
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => VoterInfoScreen(
              voterData: {
                'serialNo': serialNo,
                'name': name,
                'tamilName': tamilName,
                'fatherName': fatherName,
                'fatherTamilName': fatherTamilName,
                'voterId': voterId,
                'doorNo': doorNo,
                'age': age,
                'relation': relation,
                'familyCount': familyCount,
                'partNumber': widget.partNumber,
                'section': 1, // Default section
              },
            ),
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
            // Header with serial number and star
            Row(
              children: [
                Icon(
                  Icons.star_outline,
                  color: Colors.pink,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  'Serial No: $serialNo',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFF1976D2),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 16),
            
            // Voter details row
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Profile image
                Container(
                  width: 80,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey[300]!),
                  ),
                  child: Column(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.blue[100],
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(8),
                              topRight: Radius.circular(8),
                            ),
                          ),
                          child: Center(
                            child: Icon(
                              Icons.image,
                              color: Colors.blue,
                              size: 32,
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
                            bottomLeft: Radius.circular(8),
                            bottomRight: Radius.circular(8),
                          ),
                        ),
                        child: Text(
                          voterId,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(width: 16),
                
                // Voter information
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      Text(
                        tamilName,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black54,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        fatherName,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black87,
                        ),
                      ),
                      Text(
                        fatherTamilName,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black54,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        doorNo,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black87,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 12),
            
            // Age and relation row
            Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.blue[100],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.person,
                        color: Colors.blue,
                        size: 16,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '$age',
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  relation,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black87,
                  ),
                ),
                Spacer(),
                // Phone call button
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
                // Family count with badge
                if (familyCount > 0)
                  Stack(
                    children: [
                      Icon(
                        Icons.family_restroom,
                        color: Colors.blue,
                        size: 24,
                      ),
                      Positioned(
                        right: 0,
                        top: 0,
                        child: Container(
                          padding: EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                          constraints: BoxConstraints(
                            minWidth: 16,
                            minHeight: 16,
                          ),
                          child: Text(
                            familyCount.toString(),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  )
                else
                  Icon(
                    Icons.cake,
                    color: Colors.blue,
                    size: 24,
                  ),
              ],
            ),
          ],
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
            _buildGenderChip('Male', Icons.person, Colors.blue, setModalState),
            const SizedBox(width: 16),
            _buildGenderChip('Female', Icons.person, Colors.pink, setModalState),
            const SizedBox(width: 16),
            _buildGenderChip('Other', Icons.transgender, Colors.orange, setModalState),
          ],
        ),
      ],
    );
  }

  Widget _buildGenderChip(String label, IconData icon, Color color, StateSetter setModalState) {
    bool isSelected = selectedGenders.contains(label);
    return GestureDetector(
      onTap: () {
        setModalState(() {
          if (isSelected) {
            selectedGenders.remove(label);
          } else {
            selectedGenders.add(label);
          }
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
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
            Icon(
              icon,
              color: isSelected ? color : Colors.grey[600],
              size: 18,
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? color : Colors.grey[600],
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
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
            _buildHistoryChip('2024', 'PC', Color(0xFF1565C0), setModalState),
            _buildHistoryChip('2022', 'ULB', Color(0xFFD32F2F), setModalState),
            _buildHistoryChip('2021', 'AC', Color(0xFF388E3C), setModalState),
            _buildNotVotedChip(setModalState),
          ],
        ),
      ],
    );
  }

  Widget _buildHistoryChip(String year, String type, Color color, StateSetter setModalState) {
    String key = '$year-$type';
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
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? color.withValues(alpha: 0.2) : color,
          borderRadius: BorderRadius.circular(6),
          border: isSelected ? Border.all(color: color, width: 2) : null,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              year,
              style: TextStyle(
                color: isSelected ? color : Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              type,
              style: TextStyle(
                color: isSelected ? color : Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotVotedChip(StateSetter setModalState) {
    String key = 'not-voted';
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
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: isSelected ? Colors.grey.withValues(alpha: 0.2) : Colors.grey[100],
          shape: BoxShape.circle,
          border: Border.all(
            color: isSelected ? Colors.grey : Colors.grey[300]!,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Stack(
          children: [
            Center(
              child: Icon(
                Icons.circle,
                color: Colors.grey[400],
                size: 30,
              ),
            ),
            // Diagonal line to create crossed-out effect
            Positioned.fill(
              child: CustomPaint(
                painter: CrossOutPainter(
                  color: isSelected ? Colors.grey : Colors.grey[600]!,
                ),
              ),
            ),
          ],
        ),
      ),
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
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Icon(
          icon,
          color: isSelected ? color : Colors.grey[600],
          size: 24,
        ),
      ),
    );
  }

  // Age Filter
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

  // Political Party Filter
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
            _buildPartyIcon('admk', '🌿', Colors.green, setModalState),
            _buildPartyIcon('bjp', '🪷', Colors.orange, setModalState),
            _buildPartyIcon('dmk', '🔥', Colors.red, setModalState),
            _buildPartyIcon('congress', '✋', Colors.blue, setModalState),
            _buildPartyIcon('aam', '🧹', Colors.cyan, setModalState),
            _buildPartyIcon('independent', '⊝', Colors.black, setModalState),
            _buildPartyIcon('pmk', '☀️', Colors.amber, setModalState),
            _buildPartyIcon('mdmk', '✋', Colors.green, setModalState),
            _buildPartyIcon('cpi', '⚙️', Colors.blue, setModalState),
            _buildPartyIcon('aidmk', '❤️', Colors.red, setModalState),
            _buildPartyIcon('cpim', '⚒️', Colors.red, setModalState),
            _buildPartyIcon('cpm', '⚒️', Colors.red, setModalState),
            _buildPartyIcon('dmdk', '🎭', Colors.purple, setModalState),
            _buildPartyIcon('mic', '🎤', Colors.grey, setModalState),
          ],
        ),
      ],
    );
  }

  Widget _buildPartyIcon(String party, String emoji, Color color, StateSetter setModalState) {
    bool isSelected = selectedPoliticalParty.contains(party);
    return GestureDetector(
      onTap: () {
        setModalState(() {
          if (isSelected) {
            selectedPoliticalParty.remove(party);
          } else {
            selectedPoliticalParty.add(party);
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
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Center(
          child: Text(
            emoji,
            style: TextStyle(fontSize: 24),
          ),
        ),
      ),
    );
  }

  // Religion Filter
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
            _buildReligionIcon('hindu', '🕉️', Colors.orange, setModalState),
            _buildReligionIcon('islam', '☪️', Colors.green, setModalState),
            _buildReligionIcon('christian', '✝️', Colors.purple, setModalState),
            _buildReligionIcon('buddhist', '☸️', Colors.yellow, setModalState),
            _buildReligionIcon('sikh', '🪯', Colors.blue, setModalState),
            _buildReligionIcon('jain', '⚡', Colors.amber, setModalState),
          ],
        ),
      ],
    );
  }

  Widget _buildReligionIcon(String religion, String symbol, Color color, StateSetter setModalState) {
    bool isSelected = selectedReligion.contains(religion);
    return GestureDetector(
      onTap: () {
        setModalState(() {
          if (isSelected) {
            selectedReligion.remove(religion);
          } else {
            selectedReligion.add(religion);
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
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Center(
          child: Text(
            symbol,
            style: TextStyle(fontSize: 24),
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

// Custom painter for creating crossed-out effect
class CrossOutPainter extends CustomPainter {
  final Color color;
  
  CrossOutPainter({required this.color});
  
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;
    
    // Draw diagonal line from top-left to bottom-right
    canvas.drawLine(
      Offset(size.width * 0.2, size.height * 0.2),
      Offset(size.width * 0.8, size.height * 0.8),
      paint,
    );
  }
  
  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

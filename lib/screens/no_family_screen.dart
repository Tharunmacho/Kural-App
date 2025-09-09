import 'package:flutter/material.dart';
import 'family_manager_screen.dart';

class NoFamilyScreen extends StatefulWidget {
  const NoFamilyScreen({super.key});

  @override
  State<NoFamilyScreen> createState() => _NoFamilyScreenState();
}

class _NoFamilyScreenState extends State<NoFamilyScreen> {
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
                        'No Family',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => FamilyManagerScreen(),
                            ),
                          );
                        },
                        child: Icon(
                          Icons.family_restroom,
                          color: Color(0xFF1976D2),
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 12),
                      GestureDetector(
                        onTap: _showFilterModal,
                        child: Icon(
                          Icons.tune,
                          color: Colors.black87,
                          size: 24,
                        ),
                      ),
                    ],
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
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey[300]!),
              ),
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.all(12),
                    child: Icon(
                      Icons.search,
                      color: Color(0xFF1976D2),
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
                ],
              ),
            ),
            
            const SizedBox(height: 20),
            
            // Statistics section
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Expanded(
                    child: _buildStatCard(
                      'Part Voter:',
                      '931',
                      Color(0xFF4CAF50),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildStatCard(
                      'Family Voters:',
                      '4',
                      Colors.pink,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildStatCard(
                      'Total family:',
                      '2',
                      Color(0xFF1976D2),
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 60),
            
            // No Voters Found section
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'No Voters Found',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey[500],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
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
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.3)),
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
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              color: color,
              fontWeight: FontWeight.bold,
            ),
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

  // Guardian-style filter modal (simplified like image 3)
  void _showFilterModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => StatefulBuilder(
        builder: (context, setModalState) => Container(
          height: MediaQuery.of(context).size.height * 0.8,
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
            _buildGenderChip('Male', Icons.person, Colors.blue, setModalState),
            const SizedBox(width: 16),
            _buildGenderChip('Female', Icons.person, Colors.pink, setModalState),
            const SizedBox(width: 16),
            _buildGenderChip('Others', Icons.transgender, Colors.orange, setModalState),
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
  // Voter Category Filter
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
            _buildCategoryIcon('verified', Icons.check_circle, Colors.green, setModalState),
            _buildCategoryIcon('cancelled', Icons.cancel, Colors.red, setModalState),
            _buildCategoryIcon('unknown', Icons.help, Colors.orange, setModalState),
            _buildCategoryIcon('shifted', Icons.arrow_upward, Colors.blue, setModalState),
            _buildCategoryIcon('dead', Icons.dangerous, Colors.black, setModalState),
            _buildCategoryIcon('duplicate', Icons.content_copy, Colors.purple, setModalState),
            _buildCategoryIcon('disabled', Icons.accessible, Colors.grey, setModalState),
            _buildCategoryIcon('family', Icons.family_restroom, Colors.brown, setModalState),
            _buildCategoryIcon('id-card', Icons.badge, Colors.cyan, setModalState),
            _buildCategoryIcon('professional', Icons.work, Colors.indigo, setModalState),
            _buildCategoryIcon('booth', Icons.location_on, Colors.red, setModalState),
            _buildCategoryIcon('profile', Icons.account_circle, Colors.pink, setModalState),
            _buildCategoryIcon('verified-alt', Icons.verified, Colors.green, setModalState),
            _buildCategoryIcon('group', Icons.group, Colors.green, setModalState),
          ],
        ),
      ],
    );
  }

  Widget _buildCategoryIcon(String category, IconData icon, Color color, StateSetter setModalState) {
    bool isSelected = selectedVoterCategory.contains(category);
    return GestureDetector(
      onTap: () {
        setModalState(() {
          if (isSelected) {
            selectedVoterCategory.remove(category);
          } else {
            selectedVoterCategory.add(category);
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

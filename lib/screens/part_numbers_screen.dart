import 'package:flutter/material.dart';
import 'voter_list_screen.dart';

class PartNumbersScreen extends StatefulWidget {
  const PartNumbersScreen({super.key});

  @override
  State<PartNumbersScreen> createState() => _PartNumbersScreenState();
}

class _PartNumbersScreenState extends State<PartNumbersScreen> {
  bool isListView = false; // false = grid view, true = list view
  final TextEditingController _searchController = TextEditingController();
  Set<int> expandedCards = {}; // Track which cards are expanded

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
                        'Part Numbers',
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
                          setState(() {
                            isListView = true; // Switch to list view
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: isListView ? Color(0xFF1976D2).withValues(alpha: 0.2) : Colors.transparent,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Icon(
                            Icons.menu,
                            color: isListView ? Color(0xFF1976D2) : Colors.black87,
                            size: 24,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isListView = false; // Switch to grid view
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: !isListView ? Color(0xFF1976D2).withValues(alpha: 0.2) : Colors.transparent,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Icon(
                            Icons.apps,
                            color: !isListView ? Color(0xFF1976D2) : Colors.black87,
                            size: 24,
                          ),
                        ),
                      ),

                    ],
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 20),
            
            // Search bar (only for list view)
            if (isListView) ...[
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey[300]!),
                ),
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Search by part number',
                    hintStyle: TextStyle(color: Colors.grey[500]),
                    prefixIcon: Icon(Icons.search, color: Colors.grey[600]),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
            
            // Content section - either grid or list
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: isListView ? _buildListView() : _buildGridView(),
              ),
            ),
            
            const SizedBox(height: 20),
            
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

  Widget _buildGridView() {
    return Column(
      children: [
        // Search bar for grid view
        if (!isListView) ...[
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey[300]!),
            ),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search by part number',
                hintStyle: TextStyle(color: Colors.grey[500]),
                prefixIcon: Icon(Icons.search, color: Colors.grey[600]),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
            ),
          ),
          const SizedBox(height: 16),
        ],
        Expanded(
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 1.0,
            ),
            itemCount: 139, // Numbers 1-139
            itemBuilder: (context, index) {
              int number = index + 1;
              return _buildNumberCard(context, number);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildListView() {
    // Sample data based on your images (images 2-4 combined)
    final List<Map<String, dynamic>> partData = [
      {
        'number': 1,
        'title': 'Panchayat Union Ele. School,Thaliyur',
        'tamilTitle': 'ஊராட்சி ஒன்றிய ஆரம்ப பள்ளி,தாளியூர்',
      },
      {
        'number': 2,
        'title': 'Panchayat Union Ele. School,Thaliyur',
        'tamilTitle': 'ஊராட்சி ஒன்றிய ஆரம்ப பள்ளி,தாளியூர்',
      },
      {
        'number': 3,
        'title': 'Panchayat Union Ele. School,Deenampalayam',
        'tamilTitle': 'ஊராட்சி ஒன்றிய ஆரம்ப பள்ளி,தீனம்பாளையம்',
      },
      {
        'number': 4,
        'title': 'Panchayat Union Ele. School,Deenampalayam',
        'tamilTitle': 'ஊராட்சி ஒன்றிய ஆரம்ப பள்ளி,தீனம்பாளையம்',
      },
      {
        'number': 5,
        'title': 'Premier School Vikash Mat Hr Sec School,Deenampalayam',
        'tamilTitle': 'பிரீமியர் விகாஸ் விகாஸ் மெட்ரிக் மேல்நிலைப்பள்ளி,உ லியம்பாளையம்',
      },
      {
        'number': 6,
        'title': 'Panchayat Union Middle School,Kalikkanaikkenpalayam',
        'tamilTitle': 'ஊராட்சி ஒன்றிய நடுநிலைப்பள்ளி,கலிக்கநாய கன்பாளையம்',
      },
      {
        'number': 7,
        'title': 'Panchayat Union Middle School,Kalikkanaikkenpalayam',
        'tamilTitle': 'ஊராட்சி ஒன்றிய நடுநிலைப்பள்ளி,கலிக்கநாய கன்பாளையம்',
      },
      {
        'number': 8,
        'title': 'Panchayat Union Middle School,Kalikkanaikkenpalayam',
        'tamilTitle': 'ஊராட்சி ஒன்றிய நடுநிலைப்பள்ளி,கலிக்கநாய கன்பாளையம்',
      },
      {
        'number': 9,
        'title': 'Panchayat Union Middle School,Kalikkanaikkenpalayam',
        'tamilTitle': 'ஊராட்சி ஒன்றிய நடுநிலைப்பள்ளி,கலிக்கநாய கன்பாளையம்',
      },
      {
        'number': 10,
        'title': 'Panchayat Union Ele.School,Kulathupalayam',
        'tamilTitle': 'ஊராட்சி ஒன்றிய ஆரம்ப பள்ளி,குளத்துப்பாளையம்',
      },
      {
        'number': 11,
        'title': 'Panchayat Union Ele.School,Kulathupalayam',
        'tamilTitle': 'ஊராட்சி ஒன்றிய ஆரம்பப்பள் ளி,குளத்துப்பாளையம்',
      },
      {
        'number': 12,
        'title': 'Panchayat Union Ele.School,Kulathupalayam',
        'tamilTitle': 'ஊராட்சி ஒன்றிய ஆரம்பப்பள் ளி,குளத்துப்பாளையம்',
      },
    ];

    return ListView.builder(
      itemCount: partData.length,
      itemBuilder: (context, index) {
        final part = partData[index];
        return _buildPartListCard(part);
      },
    );
  }

  Widget _buildPartListCard(Map<String, dynamic> partData) {
    final int partNumber = partData['number'];
    final bool isExpanded = expandedCards.contains(partNumber);
    
    return Container(
      margin: EdgeInsets.only(bottom: 16),
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
        children: [
          // Main card content
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => VoterListScreen(partNumber: partNumber),
                ),
              );
            },
            child: Row(
              children: [
                // Left blue section with number
                Container(
                  width: 80,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Color(0xFFE3F2FD),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      bottomLeft: isExpanded ? Radius.zero : Radius.circular(12),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        partNumber.toString(),
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1976D2),
                        ),
                      ),
                      const SizedBox(height: 8),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            if (isExpanded) {
                              expandedCards.remove(partNumber);
                            } else {
                              expandedCards.add(partNumber);
                            }
                          });
                        },
                        child: Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.grey[300]!),
                          ),
                          child: Icon(
                            isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                            color: Colors.grey[600],
                            size: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                
                // Right content section
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          partData['title'],
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1976D2),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          partData['tamilTitle'],
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black87,
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // Expandable section with voter categories
          AnimatedContainer(
            duration: Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            height: isExpanded ? null : 0,
            child: isExpanded
                ? Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Color(0xFF1976D2),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(12),
                        bottomRight: Radius.circular(12),
                      ),
                    ),
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildVoterCategoryRow('0 - புதிய வாக்காளர்', Colors.white),
                        _buildVoterCategoryRow('1 - டிடிஎஸ் திப்பியா விதி வா எண்', Colors.white),
                        _buildVoterCategoryRow('2 - காந்திகாலனி வா.எண். 1', Colors.white),
                        _buildVoterCategoryRow('999 - வெளிநாட்டு வாக்காளர்', Colors.white),
                      ],
                    ),
                  )
                : SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
  
  Widget _buildVoterCategoryRow(String text, Color textColor) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2),
      child: Text(
        text,
        style: TextStyle(
          color: textColor,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildNumberCard(BuildContext context, int number) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => VoterListScreen(partNumber: number),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Color(0xFF1976D2),
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 8,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Center(
          child: Text(
            number.toString(),
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1976D2),
            ),
          ),
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

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}

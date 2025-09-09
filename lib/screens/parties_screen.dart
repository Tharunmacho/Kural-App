import 'package:flutter/material.dart';

class PartiesScreen extends StatefulWidget {
  const PartiesScreen({super.key});

  @override
  State<PartiesScreen> createState() => _PartiesScreenState();
}

class _PartiesScreenState extends State<PartiesScreen> {
  final TextEditingController _searchController = TextEditingController();
  
  // All political parties data
  final List<Map<String, dynamic>> _allParties = [
    // Page 1 parties
    {
      'tamilName': 'அ.தி.மு.க',
      'englishName': 'ADMK',
      'icon': Icons.eco, // Green leaves icon
      'color': Colors.green,
    },
    {
      'tamilName': 'பா.ஜ.க',
      'englishName': 'BJP',
      'icon': Icons.local_florist, // Lotus icon
      'color': Colors.orange,
    },
    {
      'tamilName': 'பா.ம.க',
      'englishName': 'PMK',
      'icon': Icons.agriculture, // Mango icon representation
      'color': Colors.orange[700],
    },
    {
      'tamilName': 'அ.ம.மு.க',
      'englishName': 'AMMK',
      'icon': Icons.kitchen, // Pressure cooker representation
      'color': Colors.grey[600],
    },
    {
      'tamilName': 'தே.மு.தி.க',
      'englishName': 'DMDK',
      'icon': Icons.water_drop, // Coconut representation
      'color': Colors.brown,
    },
    {
      'tamilName': 'நடுநிலை',
      'englishName': 'No Party (Swing Voters)',
      'icon': Icons.remove_circle_outline, // Minus circle
      'color': Colors.black,
    },
    {
      'tamilName': 'தி.மு.க',
      'englishName': 'DMK',
      'icon': Icons.wb_sunny, // Rising sun icon
      'color': Colors.red,
    },
    {
      'tamilName': 'காங்கிரஸ்',
      'englishName': 'INC',
      'icon': Icons.pan_tool, // Hand icon
      'color': Colors.blue,
    },
    // Page 2 parties (continuing from previous)
    {
      'tamilName': 'வி.சிக',
      'englishName': 'VCK',
      'icon': Icons.circle, // Circle icon
      'color': Colors.blue,
    },
    {
      'tamilName': 'ம.தி.மு.க',
      'englishName': 'MDMK',
      'icon': Icons.favorite, // Heart-like shape for spinning top
      'color': Colors.red[900],
    },
    {
      'tamilName': 'CPI-M',
      'englishName': 'CPI-M',
      'icon': Icons.agriculture, // Hammer and sickle representation
      'color': Colors.red,
    },
    {
      'tamilName': 'CPI',
      'englishName': 'CPI',
      'icon': Icons.agriculture, // Hammer and sickle representation
      'color': Colors.red,
    },
    {
      'tamilName': 'த.வெ.க',
      'englishName': 'TVK',
      'icon': Icons.circle, // Circle representation
      'color': Colors.red[800],
    },
    {
      'tamilName': 'நாம் தமிழர்',
      'englishName': 'NTK',
      'icon': Icons.mic, // Microphone icon
      'color': Colors.grey[700],
    },
  ];

  List<Map<String, dynamic>> _filteredParties = [];

  @override
  void initState() {
    super.initState();
    _filteredParties = _allParties;
    _searchController.addListener(_filterParties);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterParties() {
    setState(() {
      if (_searchController.text.isEmpty) {
        _filteredParties = _allParties;
      } else {
        _filteredParties = _allParties
            .where((party) => 
                party['tamilName']
                    .toLowerCase()
                    .contains(_searchController.text.toLowerCase()) ||
                party['englishName']
                    .toLowerCase()
                    .contains(_searchController.text.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: Column(
        children: [
          // Header with light blue background
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(top: 40, bottom: 20, left: 20, right: 20),
            decoration: BoxDecoration(
              color: Color(0xFFE3F2FD), // Light blue background
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Row(
              children: [
                // Back button
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Icon(
                    Icons.arrow_back,
                    size: 24,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(width: 16),
                // Title
                Expanded(
                  child: Text(
                    'Parties',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),
                const SizedBox(width: 40), // Balance the back button
              ],
            ),
          ),
          
          // Search bar
          Padding(
            padding: const EdgeInsets.all(20),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 8,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search Political Party',
                  hintStyle: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 16,
                  ),
                  suffixIcon: Icon(
                    Icons.search,
                    color: Colors.grey[400],
                    size: 20,
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                ),
              ),
            ),
          ),
          
          // Parties list
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 20),
              itemCount: _filteredParties.length,
              itemBuilder: (context, index) {
                return _buildPartyItem(_filteredParties[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPartyItem(Map<String, dynamic> party) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Row(
          children: [
            // Party icon/logo
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: party['color']?.withValues(alpha: 0.1) ?? Colors.grey[100],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Icon(
                  party['icon'],
                  color: party['color'] ?? Colors.grey[600],
                  size: 28,
                ),
              ),
            ),
            
            const SizedBox(width: 16),
            
            // Party names
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Tamil name
                  Text(
                    party['tamilName'],
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  // English name
                  Text(
                    party['englishName'],
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            
            // Edit button
            GestureDetector(
              onTap: () {
                // Handle edit action
                // Edit ${party['englishName']}
              },
              child: Container(
                padding: EdgeInsets.all(8),
                child: Icon(
                  Icons.edit,
                  color: Colors.grey[600],
                  size: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

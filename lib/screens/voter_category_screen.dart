import 'package:flutter/material.dart';

class VoterCategoryScreen extends StatefulWidget {
  const VoterCategoryScreen({super.key});

  @override
  State<VoterCategoryScreen> createState() => _VoterCategoryScreenState();
}

class _VoterCategoryScreenState extends State<VoterCategoryScreen> {
  final TextEditingController _searchController = TextEditingController();
  
  // All voter categories data
  final List<Map<String, dynamic>> _allCategories = [
    // Page 1 categories
    {
      'title': 'Available',
      'icon': Icons.check,
      'color': Colors.green,
      'backgroundColor': Colors.green,
    },
    {
      'title': 'Unavailable',
      'icon': Icons.close,
      'color': Colors.red,
      'backgroundColor': Colors.red,
    },
    {
      'title': 'Unidentified',
      'icon': Icons.help,
      'color': Colors.black,
      'backgroundColor': Colors.black,
    },
    {
      'title': 'Shifted',
      'icon': Icons.arrow_upward,
      'color': Colors.blue[800],
      'backgroundColor': Colors.blue[800],
    },
    {
      'title': 'Death',
      'text': 'RIP',
      'color': Colors.black,
      'backgroundColor': Colors.black,
    },
    {
      'title': 'Outstation',
      'icon': Icons.keyboard_double_arrow_right,
      'color': Colors.blue[800],
      'backgroundColor': Colors.blue[800],
    },
    {
      'title': 'Differently Abled',
      'icon': Icons.accessible,
      'color': Colors.grey[600],
      'backgroundColor': Colors.grey[600],
    },
    // Page 2 categories
    {
      'title': 'Party Member',
      'icon': Icons.group,
      'color': Colors.white,
      'backgroundColor': Colors.red[900],
    },
    {
      'title': 'BLA-2',
      'icon': Icons.how_to_vote,
      'color': Colors.white,
      'backgroundColor': Colors.blue[700],
    },
    {
      'title': 'பொறுப்பாளர்\n(In-Charge)',
      'icon': Icons.person,
      'color': Colors.black,
      'backgroundColor': Colors.grey[300],
    },
    {
      'title': 'Postal Vote',
      'icon': Icons.mail,
      'color': Colors.white,
      'backgroundColor': Colors.red,
    },
    {
      'title': 'Duplicate',
      'icon': Icons.people,
      'color': Colors.white,
      'backgroundColor': Colors.pink[200],
    },
    {
      'title': 'Booth Agent',
      'icon': Icons.store,
      'color': Colors.white,
      'backgroundColor': Colors.green,
    },
    {
      'title': 'Booth Agent & BLA-2',
      'icon': Icons.group_work,
      'color': Colors.white,
      'backgroundColor': Colors.green,
    },
  ];

  List<Map<String, dynamic>> _filteredCategories = [];

  @override
  void initState() {
    super.initState();
    _filteredCategories = _allCategories;
    _searchController.addListener(_filterCategories);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterCategories() {
    setState(() {
      if (_searchController.text.isEmpty) {
        _filteredCategories = _allCategories;
      } else {
        _filteredCategories = _allCategories
            .where((category) => category['title']
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
                    'Voter Category',
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
                  hintText: 'Search Voter Category',
                  hintStyle: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 16,
                  ),
                  prefixIcon: Icon(
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
          
          // Categories list
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 20),
              itemCount: _filteredCategories.length,
              itemBuilder: (context, index) {
                return _buildCategoryItem(_filteredCategories[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryItem(Map<String, dynamic> category) {
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
            // Category icon/circle
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: category['backgroundColor'],
                shape: BoxShape.circle,
              ),
              child: Center(
                child: category['text'] != null
                    ? Text(
                        category['text'],
                        style: TextStyle(
                          color: category['color'],
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    : Icon(
                        category['icon'],
                        color: category['color'],
                        size: 24,
                      ),
              ),
            ),
            
            const SizedBox(width: 16),
            
            // Category title
            Expanded(
              child: Text(
                category['title'],
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
            ),
            
            // Edit button
            GestureDetector(
              onTap: () {
                // Handle edit action
                // Edit ${category['title']}
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

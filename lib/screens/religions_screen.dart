import 'package:flutter/material.dart';

class ReligionsScreen extends StatefulWidget {
  const ReligionsScreen({super.key});

  @override
  State<ReligionsScreen> createState() => _ReligionsScreenState();
}

class _ReligionsScreenState extends State<ReligionsScreen> {
  final TextEditingController _searchController = TextEditingController();
  
  // All religions data with their symbols and colors
  final List<Map<String, dynamic>> _allReligions = [
    {
      'name': 'Hindu',
      'symbol': '🕉️',
      'color': Colors.orange,
      'backgroundColor': Colors.orange.withValues(alpha: 0.3),
    },
    {
      'name': 'Muslim',
      'symbol': '☪️',
      'color': Colors.green,
      'backgroundColor': Colors.green.withValues(alpha: 0.1),
    },
    {
      'name': 'Christian',
      'symbol': '✝️',
      'color': Colors.purple,
      'backgroundColor': Colors.purple.withValues(alpha: 0.1),
    },
    {
      'name': 'Jainism',
      'symbol': '🤚',
      'color': Colors.amber[700],
      'backgroundColor': Colors.amber.withValues(alpha: 0.1),
    },
    {
      'name': 'Sikhism',
      'symbol': '☬',
      'color': Colors.blue[800],
      'backgroundColor': Colors.blue.withValues(alpha: 0.1),
    },
    {
      'name': 'Buddhism',
      'symbol': '☸️',
      'color': Colors.orange[700],
      'backgroundColor': Colors.orange.withValues(alpha: 0.1),
    },
  ];

  List<Map<String, dynamic>> _filteredReligions = [];

  @override
  void initState() {
    super.initState();
    _filteredReligions = _allReligions;
    _searchController.addListener(_filterReligions);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterReligions() {
    setState(() {
      if (_searchController.text.isEmpty) {
        _filteredReligions = _allReligions;
      } else {
        _filteredReligions = _allReligions
            .where((religion) => religion['name']
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
                    'Religions',
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
                  hintText: 'Search Religion',
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
          
          // Religions list
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 20),
              itemCount: _filteredReligions.length,
              itemBuilder: (context, index) {
                return _buildReligionItem(_filteredReligions[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReligionItem(Map<String, dynamic> religion) {
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
            // Religion symbol/icon
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: religion['backgroundColor'],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Text(
                  religion['symbol'],
                  style: TextStyle(
                    fontSize: 24,
                  ),
                ),
              ),
            ),
            
            const SizedBox(width: 16),
            
            // Religion name
            Expanded(
              child: Text(
                religion['name'],
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
            ),
            
            // Edit button
            GestureDetector(
              onTap: () {
                // Handle edit action
                // Edit ${religion['name']}
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

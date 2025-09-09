import 'package:flutter/material.dart';

class SchemesScreen extends StatefulWidget {
  const SchemesScreen({super.key});

  @override
  State<SchemesScreen> createState() => _SchemesScreenState();
}

class _SchemesScreenState extends State<SchemesScreen> {
  final TextEditingController _searchController = TextEditingController();
  
  // All government schemes data with their icons and departments
  final List<Map<String, dynamic>> _allSchemes = [
    {
      'name': 'Amma Laptop',
      'department': 'STATE_GOVT',
      'icon': Icons.laptop_mac,
      'color': Colors.blue,
    },
    {
      'name': 'Amma Scooty for Ladies',
      'department': 'STATE_GOVT',
      'icon': Icons.two_wheeler,
      'color': Colors.pink,
    },
    {
      'name': 'Free Maternity Kit',
      'department': 'STATE_GOVT',
      'icon': Icons.pregnant_woman,
      'color': Colors.orange,
    },
    {
      'name': 'Crop Loan Waiver Scheme',
      'department': 'STATE_GOVT',
      'icon': Icons.agriculture,
      'color': Colors.brown,
    },
    {
      'name': 'Kalaignar Magalir Urimai Thogai',
      'department': 'STATE_GOVT',
      'icon': Icons.account_balance_wallet,
      'color': Colors.purple,
    },
    {
      'name': 'Free Bus Travel for Women',
      'department': 'STATE_GOVT',
      'icon': Icons.directions_bus,
      'color': Colors.green,
    },
  ];

  List<Map<String, dynamic>> _filteredSchemes = [];

  @override
  void initState() {
    super.initState();
    _filteredSchemes = _allSchemes;
    _searchController.addListener(_filterSchemes);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterSchemes() {
    setState(() {
      if (_searchController.text.isEmpty) {
        _filteredSchemes = _allSchemes;
      } else {
        _filteredSchemes = _allSchemes
            .where((scheme) => 
                scheme['name'].toLowerCase().contains(_searchController.text.toLowerCase()) ||
                scheme['department'].toLowerCase().contains(_searchController.text.toLowerCase()))
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
                    'Schemes',
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
                  hintText: 'Search Benefit Schemes',
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
          
          // Schemes list
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 20),
              itemCount: _filteredSchemes.length,
              itemBuilder: (context, index) {
                return _buildSchemeItem(_filteredSchemes[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSchemeItem(Map<String, dynamic> scheme) {
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
            // Scheme icon
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: scheme['color'].withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Icon(
                  scheme['icon'],
                  color: scheme['color'],
                  size: 28,
                ),
              ),
            ),
            
            const SizedBox(width: 16),
            
            // Scheme information
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Scheme name
                  Text(
                    scheme['name'],
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  // Department
                  Text(
                    scheme['department'],
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
                _showEditDialog(scheme);
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

  void _showEditDialog(Map<String, dynamic> scheme) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit ${scheme['name']}'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Scheme: ${scheme['name']}'),
              const SizedBox(height: 8),
              Text('Department: ${scheme['department']}'),
              const SizedBox(height: 16),
              Text(
                'Edit scheme details and eligibility criteria.',
                style: TextStyle(color: Colors.grey[600]),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('${scheme['name']} updated successfully'),
                    backgroundColor: Colors.green,
                  ),
                );
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }
}

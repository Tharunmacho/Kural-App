import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';

class CasteCategoryScreen extends StatefulWidget {
  const CasteCategoryScreen({super.key});

  @override
  State<CasteCategoryScreen> createState() => _CasteCategoryScreenState();
}

class _CasteCategoryScreenState extends State<CasteCategoryScreen> {
  final TextEditingController _searchController = TextEditingController();
  
  // All caste categories data with their counts
  final List<Map<String, dynamic>> _allCasteCategories = [
    {
      'name': 'ST',
      'fullName': 'Scheduled Tribe',
      'count': 23,
    },
    {
      'name': 'SC',
      'fullName': 'Scheduled Caste',
      'count': 22,
    },
    {
      'name': 'MBC',
      'fullName': 'Most Backward Class',
      'count': 21,
    },
    {
      'name': 'BC',
      'fullName': 'Backward Class',
      'count': 20,
    },
    {
      'name': 'OC',
      'fullName': 'Other Caste',
      'count': 19,
    },
  ];

  List<Map<String, dynamic>> _filteredCasteCategories = [];

  @override
  void initState() {
    super.initState();
    _filteredCasteCategories = _allCasteCategories;
    _searchController.addListener(_filterCasteCategories);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterCasteCategories() {
    setState(() {
      if (_searchController.text.isEmpty) {
        _filteredCasteCategories = _allCasteCategories;
      } else {
        _filteredCasteCategories = _allCasteCategories
            .where((category) => 
                category['name'].toLowerCase().contains(_searchController.text.toLowerCase()) ||
                category['fullName'].toLowerCase().contains(_searchController.text.toLowerCase()))
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
                    AppLocalizations.of(context)?.casteCategory ?? 'Caste Category',
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
                  hintText: 'Search Caste',
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
          
          // Caste categories list
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 20),
              itemCount: _filteredCasteCategories.length,
              itemBuilder: (context, index) {
                return _buildCasteCategoryItem(_filteredCasteCategories[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCasteCategoryItem(Map<String, dynamic> category) {
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
            // Category name and count
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Category abbreviation
                  Text(
                    category['name'],
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  // Count
                  Text(
                    category['count'].toString(),
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            
            // Action buttons
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Edit button
                GestureDetector(
                  onTap: () {
                    // Handle edit action
                    _showEditDialog(category);
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
                const SizedBox(width: 8),
                // Delete button
                GestureDetector(
                  onTap: () {
                    // Handle delete action
                    _showDeleteDialog(category);
                  },
                  child: Container(
                    padding: EdgeInsets.all(8),
                    child: Icon(
                      Icons.delete,
                      color: Colors.red[400],
                      size: 20,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showEditDialog(Map<String, dynamic> category) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit ${category['name']}'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Edit caste category: ${category['fullName']}'),
              const SizedBox(height: 16),
              Text('Current count: ${category['count']}'),
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
                    content: Text('${category['name']} edited successfully'),
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

  void _showDeleteDialog(Map<String, dynamic> category) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete ${category['name']}'),
          content: Text(
            'Are you sure you want to delete the caste category "${category['fullName']}"?\n\nThis action cannot be undone.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                setState(() {
                  _allCasteCategories.remove(category);
                  _filterCasteCategories();
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('${category['name']} deleted successfully'),
                    backgroundColor: Colors.red,
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              child: Text('Delete'),
            ),
          ],
        );
      },
    );
  }
}

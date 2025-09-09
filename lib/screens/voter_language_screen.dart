import 'package:flutter/material.dart';

class VoterLanguageScreen extends StatefulWidget {
  const VoterLanguageScreen({super.key});

  @override
  State<VoterLanguageScreen> createState() => _VoterLanguageScreenState();
}

class _VoterLanguageScreenState extends State<VoterLanguageScreen> {
  final TextEditingController _searchController = TextEditingController();
  
  // All voter languages data with their native scripts
  final List<Map<String, dynamic>> _allLanguages = [
    {
      'englishName': 'Malayalam',
      'nativeName': 'മലയാളം',
    },
    {
      'englishName': 'Kannada',
      'nativeName': 'ಕನ್ನಡ',
    },
    {
      'englishName': 'Telugu',
      'nativeName': 'తెలుగు',
    },
    {
      'englishName': 'Hindi',
      'nativeName': 'हिन्दी',
    },
    {
      'englishName': 'Tamil',
      'nativeName': 'தமிழ்',
    },
  ];

  List<Map<String, dynamic>> _filteredLanguages = [];

  @override
  void initState() {
    super.initState();
    _filteredLanguages = _allLanguages;
    _searchController.addListener(_filterLanguages);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterLanguages() {
    setState(() {
      if (_searchController.text.isEmpty) {
        _filteredLanguages = _allLanguages;
      } else {
        _filteredLanguages = _allLanguages
            .where((language) => 
                language['englishName'].toLowerCase().contains(_searchController.text.toLowerCase()) ||
                language['nativeName'].toLowerCase().contains(_searchController.text.toLowerCase()))
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
                    'Voter Language',
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
                  hintText: 'Search Voter Language',
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
          
          // Languages list
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 20),
              itemCount: _filteredLanguages.length,
              itemBuilder: (context, index) {
                return _buildLanguageItem(_filteredLanguages[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLanguageItem(Map<String, dynamic> language) {
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
            // Language name with native script
            Expanded(
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: language['englishName'],
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    TextSpan(
                      text: ' (${language['nativeName']})',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            // Edit button
            GestureDetector(
              onTap: () {
                // Handle edit action
                _showEditDialog(language);
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

  void _showEditDialog(Map<String, dynamic> language) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit ${language['englishName']}'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Language: ${language['englishName']}'),
              const SizedBox(height: 8),
              Text('Native Name: ${language['nativeName']}'),
              const SizedBox(height: 16),
              Text(
                'Edit language settings and preferences.',
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
                    content: Text('${language['englishName']} updated successfully'),
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

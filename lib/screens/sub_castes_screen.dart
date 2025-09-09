import 'package:flutter/material.dart';

class SubCastesScreen extends StatefulWidget {
  const SubCastesScreen({super.key});

  @override
  State<SubCastesScreen> createState() => _SubCastesScreenState();
}

class _SubCastesScreenState extends State<SubCastesScreen> {
  final TextEditingController _searchController = TextEditingController();
  
  // All sub-castes data with their Tamil names, parent castes, and religions
  final List<Map<String, dynamic>> _allSubCastes = [
    // Page 1 sub-castes
    {
      'englishName': 'Devendrakulathar',
      'tamilName': 'தேவேந்திரகுலத்தர்',
      'parentCaste': 'Devendra Kula Velaalar',
      'parentCasteTamil': 'தேவேந்திர குல வேளாளர்',
      'religion': 'Hindu',
    },
    {
      'englishName': 'Maravar',
      'tamilName': 'மறவர்',
      'parentCaste': 'Mukkulathor',
      'parentCasteTamil': 'முக்குலத்தோர்',
      'religion': 'Hindu',
    },
    {
      'englishName': 'Vanniyar',
      'tamilName': 'வன்னியர்',
      'parentCaste': 'Vanniyar',
      'parentCasteTamil': 'வன்னியர்',
      'religion': 'Hindu',
    },
    {
      'englishName': 'Kadaiyar',
      'tamilName': 'கடையர்',
      'parentCaste': 'Devendra Kula Velaalar',
      'parentCasteTamil': 'தேவேந்திர குல வேளாளர்',
      'religion': 'Hindu',
    },
    {
      'englishName': 'Kallar',
      'tamilName': 'கள்ளர்',
      'parentCaste': 'Mukkulathor',
      'parentCasteTamil': 'முக்குலத்தோர்',
      'religion': 'Hindu',
    },
    {
      'englishName': 'Vanniya Gounder',
      'tamilName': 'வன்னிய கவுண்டர்',
      'parentCaste': 'Vanniyar',
      'parentCasteTamil': 'வன்னியர்',
      'religion': 'Hindu',
    },
    // Page 2 sub-castes
    {
      'englishName': 'Agamudaiyaar',
      'tamilName': 'அகமுடையார்',
      'parentCaste': 'Mukkulathor',
      'parentCasteTamil': 'முக்குலத்தோர்',
      'religion': 'Hindu',
    },
    {
      'englishName': 'Kaalaadi',
      'tamilName': 'காலாடி',
      'parentCaste': 'Devendra Kula Velaalar',
      'parentCasteTamil': 'தேவேந்திர குல வேளாளர்',
      'religion': 'Hindu',
    },
    {
      'englishName': 'Kander',
      'tamilName': 'கண்டர்',
      'parentCaste': 'Vanniyar',
      'parentCasteTamil': 'வன்னியர்',
      'religion': 'Hindu',
    },
    {
      'englishName': 'Kudumbar',
      'tamilName': 'குடும்பர்',
      'parentCaste': 'Devendra Kula Velaalar',
      'parentCasteTamil': 'தேவேந்திர குல வேளாளர்',
      'religion': 'Hindu',
    },
    {
      'englishName': 'Padayaatchi',
      'tamilName': 'படையாட்சி',
      'parentCaste': 'Vanniyar',
      'parentCasteTamil': 'வன்னியர்',
      'religion': 'Hindu',
    },
    // Page 3 sub-castes
    {
      'englishName': 'Pallar',
      'tamilName': 'பள்ளர்',
      'parentCaste': 'Devendra Kula Velaalar',
      'parentCasteTamil': 'தேவேந்திர குல வேளாளர்',
      'religion': 'Hindu',
    },
    {
      'englishName': 'Palli',
      'tamilName': 'பள்ளி',
      'parentCaste': 'Vanniyar',
      'parentCasteTamil': 'வன்னியர்',
      'religion': 'Hindu',
    },
    {
      'englishName': 'Agni Kula Kshatriyar',
      'tamilName': 'அக்னி குல க்ஷத்ரியர்',
      'parentCaste': 'Vanniyar',
      'parentCasteTamil': 'வன்னியர்',
      'religion': 'Hindu',
    },
    {
      'englishName': 'Pannaadi',
      'tamilName': 'பண்ணாடி',
      'parentCaste': 'Devendra Kula Velaalar',
      'parentCasteTamil': 'தேவேந்திர குல வேளாளர்',
      'religion': 'Hindu',
    },
    {
      'englishName': 'Vaadhiriyaar',
      'tamilName': 'வாதிரியார்',
      'parentCaste': 'Devendra Kula Velaalar',
      'parentCasteTamil': 'தேவேந்திர குல வேளாளர்',
      'religion': 'Hindu',
    },
  ];

  List<Map<String, dynamic>> _filteredSubCastes = [];

  @override
  void initState() {
    super.initState();
    _filteredSubCastes = _allSubCastes;
    _searchController.addListener(_filterSubCastes);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterSubCastes() {
    setState(() {
      if (_searchController.text.isEmpty) {
        _filteredSubCastes = _allSubCastes;
      } else {
        _filteredSubCastes = _allSubCastes
            .where((subCaste) => 
                subCaste['englishName'].toLowerCase().contains(_searchController.text.toLowerCase()) ||
                subCaste['tamilName'].toLowerCase().contains(_searchController.text.toLowerCase()) ||
                subCaste['parentCaste'].toLowerCase().contains(_searchController.text.toLowerCase()) ||
                subCaste['religion'].toLowerCase().contains(_searchController.text.toLowerCase()))
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
                    'Sub-Castes',
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
                  hintText: 'Search Sub caste',
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
          
          // Sub-castes list
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 20),
              itemCount: _filteredSubCastes.length,
              itemBuilder: (context, index) {
                return _buildSubCasteItem(_filteredSubCastes[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubCasteItem(Map<String, dynamic> subCaste) {
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
            // Sub-caste information
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Sub-caste name with Tamil name
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: subCaste['englishName'],
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                        TextSpan(
                          text: ' (${subCaste['tamilName']})',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 4),
                  // Parent caste with Tamil name
                  Text(
                    '${subCaste['parentCaste']} (${subCaste['parentCasteTamil']})',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 2),
                  // Religion
                  Text(
                    subCaste['religion'],
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
                _showEditDialog(subCaste);
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

  void _showEditDialog(Map<String, dynamic> subCaste) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit ${subCaste['englishName']}'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Sub-Caste: ${subCaste['englishName']}'),
              const SizedBox(height: 8),
              Text('Tamil Name: ${subCaste['tamilName']}'),
              const SizedBox(height: 8),
              Text('Parent Caste: ${subCaste['parentCaste']}'),
              const SizedBox(height: 8),
              Text('Parent Caste (Tamil): ${subCaste['parentCasteTamil']}'),
              const SizedBox(height: 8),
              Text('Religion: ${subCaste['religion']}'),
              const SizedBox(height: 16),
              Text(
                'Edit sub-caste information and hierarchy.',
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
                    content: Text('${subCaste['englishName']} updated successfully'),
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

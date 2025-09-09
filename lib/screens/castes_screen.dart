import 'package:flutter/material.dart';

class CastesScreen extends StatefulWidget {
  const CastesScreen({super.key});

  @override
  State<CastesScreen> createState() => _CastesScreenState();
}

class _CastesScreenState extends State<CastesScreen> {
  final TextEditingController _searchController = TextEditingController();
  
  // All castes data with their Tamil names and religions
  final List<Map<String, dynamic>> _allCastes = [
    // Page 1 castes
    {
      'englishName': 'Vanniyar',
      'tamilName': 'வன்னியர்',
      'religion': 'Hindu',
    },
    {
      'englishName': 'Paraiyar',
      'tamilName': 'பறையர்',
      'religion': 'Hindu',
    },
    {
      'englishName': 'Mukkulathor',
      'tamilName': 'முக்குலத்தோர்',
      'religion': 'Hindu',
    },
    {
      'englishName': 'Devendra Kula Velaalar',
      'tamilName': 'தேவேந்திர குல வேளாளர்',
      'religion': 'Hindu',
    },
    {
      'englishName': 'Kongu Velaalar',
      'tamilName': 'கொங்கு வேளாளர்',
      'religion': 'Hindu',
    },
    {
      'englishName': 'Arunthathiyar',
      'tamilName': 'அருந்ததியர்',
      'religion': 'Hindu',
    },
    {
      'englishName': 'Yadavar',
      'tamilName': 'யாதவர்',
      'religion': 'Hindu',
    },
    // Page 2 castes
    {
      'englishName': 'Mudalaiyaar',
      'tamilName': 'முதலியார்',
      'religion': 'Hindu',
    },
    {
      'englishName': 'Mutharaiyar',
      'tamilName': 'முத்தரையர்',
      'religion': 'Hindu',
    },
    {
      'englishName': 'Vishwakarma',
      'tamilName': 'விஷ்வகர்மா',
      'religion': 'Hindu',
    },
    {
      'englishName': 'Chettiyaar',
      'tamilName': 'செட்டியார்',
      'religion': 'Hindu',
    },
    {
      'englishName': 'Pillai',
      'tamilName': 'பிள்ளை',
      'religion': 'Hindu',
    },
    {
      'englishName': 'Naidu',
      'tamilName': 'நாயுடு',
      'religion': 'Hindu',
    },
    {
      'englishName': 'Nadar',
      'tamilName': 'நாடார்',
      'religion': 'Hindu',
    },
    {
      'englishName': 'Reddy',
      'tamilName': 'ரெட்டி',
      'religion': 'Hindu',
    },
    // Page 3 castes
    {
      'englishName': 'Gowda',
      'tamilName': 'கௌடா',
      'religion': 'Hindu',
    },
    {
      'englishName': 'Irular',
      'tamilName': 'இருளர்',
      'religion': 'Hindu',
    },
    {
      'englishName': 'Kuravar',
      'tamilName': 'குறவர்',
      'religion': 'Hindu',
    },
    {
      'englishName': 'Paatinavar',
      'tamilName': 'பாட்டினவர்',
      'religion': 'Hindu',
    },
  ];

  List<Map<String, dynamic>> _filteredCastes = [];

  @override
  void initState() {
    super.initState();
    _filteredCastes = _allCastes;
    _searchController.addListener(_filterCastes);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterCastes() {
    setState(() {
      if (_searchController.text.isEmpty) {
        _filteredCastes = _allCastes;
      } else {
        _filteredCastes = _allCastes
            .where((caste) => 
                caste['englishName'].toLowerCase().contains(_searchController.text.toLowerCase()) ||
                caste['tamilName'].toLowerCase().contains(_searchController.text.toLowerCase()) ||
                caste['religion'].toLowerCase().contains(_searchController.text.toLowerCase()))
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
                    'Castes',
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
          
          // Castes list
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 20),
              itemCount: _filteredCastes.length,
              itemBuilder: (context, index) {
                return _buildCasteItem(_filteredCastes[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCasteItem(Map<String, dynamic> caste) {
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
            // Caste names and religion
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // English name with Tamil name
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: caste['englishName'],
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                        TextSpan(
                          text: ' (${caste['tamilName']})',
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
                  // Religion
                  Text(
                    caste['religion'],
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
                _showEditDialog(caste);
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

  void _showEditDialog(Map<String, dynamic> caste) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit ${caste['englishName']}'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Caste: ${caste['englishName']}'),
              const SizedBox(height: 8),
              Text('Tamil Name: ${caste['tamilName']}'),
              const SizedBox(height: 8),
              Text('Religion: ${caste['religion']}'),
              const SizedBox(height: 16),
              Text(
                'Edit caste information and settings.',
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
                    content: Text('${caste['englishName']} updated successfully'),
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

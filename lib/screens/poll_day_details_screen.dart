import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'voter_info_screen.dart';

class PollDayDetailsScreen extends StatefulWidget {
  final int partNumber;
  
  const PollDayDetailsScreen({super.key, required this.partNumber});

  @override
  State<PollDayDetailsScreen> createState() => _PollDayDetailsScreenState();
}

class _PollDayDetailsScreenState extends State<PollDayDetailsScreen> {
  final TextEditingController _searchController = TextEditingController();
  final Map<int, bool> _votingStatus = {}; // Track voting status for each booth
  int _votedCount = 3;
  int _notVotedCount = 1452;
  final int _totalCount = 1455;
  bool _showListView = false; // Toggle between grid and list view

  // Sample voter data for the poll day - matching your image
  List<Map<String, dynamic>> voters = [
    {
      'serialNo': 1,
      'name': 'prabhakar',
      'tamilName': 'பிரபாகர்',
      'relation': 'Father',
      'voterId': 'RIV0893552',
      'doorNo': '1',
      'age': 72,
      'hasVoted': false, // Red indicator in your image
      'voterName': 'prabhakar',
      'fatherName': 'srinivasan',
      'address': 'Door No 1, Chennai',
      'phoneNumber': '9876543210',
      'gender': 'Male',
      'familyCount': 1
    },
    {
      'serialNo': 2,
      'name': 'ramalingam',
      'tamilName': 'ராமலிங்கம்',
      'relation': 'Father',
      'voterId': 'RIV0893553',
      'doorNo': '2',
      'age': 65,
      'hasVoted': false, // Red indicator in your image
      'voterName': 'ramalingam',
      'fatherName': 'poonusamy',
      'address': 'Door No 2, Chennai',
      'phoneNumber': '9876543211',
      'gender': 'Male',
      'familyCount': 1
    },
    {
      'serialNo': 4,
      'name': 'Suresh Kumar',
      'tamilName': 'சுரேஷ் குமார்',
      'relation': 'Father',
      'voterId': 'RIV0893554',
      'doorNo': '4',
      'age': 45,
      'hasVoted': true, // Green indicator in your image
      'voterName': 'Suresh Kumar',
      'fatherName': 'Rajesh',
      'address': 'Door No 4, Chennai',
      'phoneNumber': '9876543212',
      'gender': 'Male',
      'familyCount': 1
    },
    // Add more voters to match the list in your image
    {
      'serialNo': 5,
      'name': 'Lakshmi',
      'tamilName': 'லக்ஷ்மி',
      'relation': 'Mother',
      'voterId': 'RIV0893557',
      'doorNo': '5',
      'age': 38,
      'hasVoted': false,
      'voterName': 'Lakshmi',
      'fatherName': 'Raman',
      'address': 'Door No 5, Chennai',
      'phoneNumber': '9876543215',
      'gender': 'Female',
      'familyCount': 1
    },
    {
      'serialNo': 6,
      'name': 'Karthik',
      'tamilName': 'கார்த்திக்',
      'relation': 'Son',
      'voterId': 'RIV0893558',
      'doorNo': '6',
      'age': 28,
      'hasVoted': false,
      'voterName': 'Karthik',
      'fatherName': 'Suresh Kumar',
      'address': 'Door No 6, Chennai',
      'phoneNumber': '9876543216',
      'gender': 'Male',
      'familyCount': 1
    },
  ];

  @override
  void initState() {
    super.initState();
    _initializeVotingStatus();
  }

  void _initializeVotingStatus() {
    // Initialize voting status based on voter data
    for (var voter in voters) {
      _votingStatus[voter['serialNo']] = voter['hasVoted'];
    }
  }

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
                        'Poll day - Part ${widget.partNumber}',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _showListView = !_showListView;
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.3),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        _showListView ? Icons.apps : Icons.menu,
                        color: Colors.black87,
                        size: 24,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 16),
            
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
                        hintText: 'Search...',
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
            
            const SizedBox(height: 16),
            
            // Statistics section
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Expanded(
                    child: _buildStatCard('Voted : $_votedCount', Colors.green),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildStatCard('Not Voted :\n$_notVotedCount', Colors.pink),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildStatCard('Total : $_totalCount', Colors.lightBlue),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 20),
            
            // Voting status grid or voter list
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: _showListView ? _buildVoterList() : _buildVotingGrid(),
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Bottom navigation
            Container(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildBottomNavItem('Report', Icons.trending_up_outlined, false),
                  _buildBottomNavItem('Catalogue', Icons.list_alt_outlined, false),
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
                  _buildBottomNavItem('Slip Box', Icons.inventory_outlined, false),
                  _buildBottomNavItem('Poll Day', Icons.how_to_vote_outlined, true),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String text, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 14,
          color: color == Colors.lightBlue ? Color(0xFF1976D2) : color,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }





  Widget _buildBottomNavItem(String title, IconData icon, bool isSelected) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          size: 24,
          color: isSelected ? Color(0xFF1976D2) : Colors.black54,
        ),
        const SizedBox(height: 4),
        Text(
          title,
          style: TextStyle(
            fontSize: 10,
            color: isSelected ? Color(0xFF1976D2) : Colors.black54,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }



  Widget _buildVotingGrid() {
    // Show numbers 1-32 as in the image
    List<int> filteredNumbers = List.generate(32, (index) => index + 1);
    if (_searchController.text.isNotEmpty) {
      filteredNumbers = filteredNumbers.where((number) => 
        number.toString().contains(_searchController.text)).toList();
    }

    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 1.5,
      ),
      itemCount: filteredNumbers.length,
      itemBuilder: (context, index) {
        int number = filteredNumbers[index];
        bool hasVoted = _getVotingStatusForNumber(number);
        
        return GestureDetector(
          onTap: () {
            _toggleVotingStatus(number);
          },
          child: Container(
            decoration: BoxDecoration(
              color: hasVoted ? Colors.green[400] : Colors.red[400],
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Center(
              child: Text(
                number.toString(),
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  bool _getVotingStatusForNumber(int number) {
    // Set specific numbers as voted (green) to match your image
    // Numbers 2, 4, 7, 8 appear to be green in your image
    return [2, 4, 7, 8].contains(number);
  }

  Widget _buildVoterList() {
    // Filter voters based on search
    List<Map<String, dynamic>> filteredVoters = voters;
    if (_searchController.text.isNotEmpty) {
      String searchTerm = _searchController.text.toLowerCase();
      filteredVoters = voters.where((voter) =>
        voter['name'].toLowerCase().contains(searchTerm) ||
        voter['voterId'].toLowerCase().contains(searchTerm) ||
        voter['serialNo'].toString().contains(searchTerm)
      ).toList();
    }

    return ListView.builder(
      itemCount: filteredVoters.length,
      itemBuilder: (context, index) {
        final voter = filteredVoters[index];
        return _buildVoterCard(voter);
      },
    );
  }

  Widget _buildVoterCard(Map<String, dynamic> voter) {
    bool hasVoted = voter['hasVoted'];
    
    return GestureDetector(
      onTap: () {
        // Create properly structured voter data for VoterInfoScreen
        Map<String, dynamic> voterData = {
          'serialNo': voter['serialNo'],
          'serial': voter['serialNo'].toString(),
          'name': voter['name'] ?? 'Unknown',
          'tamilName': voter['tamilName'] ?? 'தெரியாது',
          'fatherName': voter['fatherName'] ?? 'Unknown',
          'fatherTamilName': voter['tamilName'] ?? 'தெரியாது', // Using tamilName as fallback
          'location': voter['address'] ?? 'Chennai',
          'tamilLocation': 'சென்னை',
          'voterId': voter['voterId'] ?? 'Unknown',
          'epicId': voter['voterId'] ?? 'Unknown',
          'doorNo': voter['doorNo'] ?? '0',
          'partNumber': widget.partNumber.toString(),
          'part': widget.partNumber.toString(),
          'section': '1',
          'age': voter['age'] ?? 0,
          'gender': voter['gender'] ?? 'Unknown',
          'relation': voter['relation'] ?? 'Unknown',
          'mobileNumber': voter['phoneNumber'] ?? 'Unknown',
          'politicalParty': 'Unknown',
          'religion': 'Unknown',
          'voterCategory': 'Active',
          'familyCount': voter['familyCount'] ?? 1,
        };
        
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => VoterInfoScreen(voterData: voterData),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 16),
        padding: EdgeInsets.all(16),
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Serial number with star
            Row(
              children: [
                Icon(
                  Icons.star_outline,
                  color: Color(0xFFE91E63),
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  'Serial No: ${voter['serialNo']}',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1976D2),
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 16),
            
            // Main content row
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Photo placeholder
                Container(
                  width: 80,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey[300]!),
                  ),
                  child: Stack(
                    children: [
                      Center(
                        child: Icon(
                          Icons.person,
                          size: 40,
                          color: Colors.grey[500],
                        ),
                      ),
                      Positioned(
                        bottom: 4,
                        left: 4,
                        right: 4,
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 2),
                          decoration: BoxDecoration(
                            color: Color(0xFF1976D2),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            voter['voterId'],
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(width: 16),
                
                // Voter details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Name
                      Text(
                        voter['name'],
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      Text(
                        voter['tamilName'],
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black87,
                        ),
                      ),
                      
                      const SizedBox(height: 8),
                      
                      // Father name
                      Text(
                        voter['fatherName'],
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[700],
                        ),
                      ),
                      
                      const SizedBox(height: 4),
                      
                      // Door number and Age
                      Row(
                        children: [
                          Text(
                            'Door No ${voter['doorNo']}',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[700],
                            ),
                          ),
                          const SizedBox(width: 16),
                          Icon(
                            Icons.person,
                            size: 16,
                            color: Colors.blue,
                          ),
                          Text(
                            ' ${voter['age']}',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[700],
                            ),
                          ),
                          Text(
                            ' ${voter['relation']}',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[700],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                
                // Action buttons
                Column(
                  children: [
                    // Voting status toggle
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          voter['hasVoted'] = !voter['hasVoted'];
                          _votingStatus[voter['serialNo']] = voter['hasVoted'];
                          
                          // Update counts
                          _votedCount = voters.where((v) => v['hasVoted']).length;
                          _notVotedCount = voters.where((v) => !v['hasVoted']).length;
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: hasVoted ? Colors.green : Colors.red,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          hasVoted ? Icons.check : Icons.close,
                          color: Colors.white,
                          size: 16,
                        ),
                      ),
                    ),
                    
                    const SizedBox(height: 8),
                    
                    // Phone call button
                    GestureDetector(
                      onTap: () => _makePhoneCall(voter['phoneNumber'] ?? '9965161134'),
                      child: Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.blue.withValues(alpha: 0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.phone,
                          color: Colors.blue,
                          size: 16,
                        ),
                      ),
                    ),
                    
                    const SizedBox(height: 8),
                    
                    // Family count
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Color(0xFF1976D2).withValues(alpha: 0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.family_restroom,
                            color: Color(0xFF1976D2),
                            size: 16,
                          ),
                          Text(
                            '1',
                            style: TextStyle(
                              color: Color(0xFF1976D2),
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _toggleVotingStatus(int number) {
    setState(() {
      _votingStatus[number] = !(_votingStatus[number] ?? false);
      
      // Update counts based on current status
      _votedCount = _votingStatus.values.where((voted) => voted).length;
      _notVotedCount = _totalCount - _votedCount;
    });
    
    String status = _votingStatus[number]! ? 'Voted' : 'Not Voted';
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Booth $number marked as $status'),
        duration: Duration(seconds: 1),
      ),
    );
  }

  void _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    try {
      await launchUrl(launchUri);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Could not launch phone dialer')),
        );
      }
    }
  }
}

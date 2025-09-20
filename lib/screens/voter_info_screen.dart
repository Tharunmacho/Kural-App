import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import 'share_screen.dart';

class VoterInfoScreen extends StatefulWidget {
  final Map<String, dynamic> voterData;
  
  const VoterInfoScreen({super.key, required this.voterData});

  @override
  State<VoterInfoScreen> createState() => _VoterInfoScreenState();
}

class _VoterInfoScreenState extends State<VoterInfoScreen> with TickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _feedbackController = TextEditingController();
  final TextEditingController _aadharController = TextEditingController();
  final TextEditingController _panController = TextEditingController();
  final TextEditingController _membershipController = TextEditingController();
  final TextEditingController _remarksController = TextEditingController();
  
  // Advanced search controllers
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _partNoController = TextEditingController();
  final TextEditingController _serialNoController = TextEditingController();
  final TextEditingController _epicIdController = TextEditingController();
  final TextEditingController _voterFirstNameController = TextEditingController();
  final TextEditingController _voterLastNameController = TextEditingController();
  final TextEditingController _relationFirstNameController = TextEditingController();
  final TextEditingController _relationLastNameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  
  // Filter state variables
  double minAge = 18;
  double maxAge = 120;
  Set<String> selectedGenders = {};
  Set<String> selectedVoterHistoryFilter = {};
  Set<String> selectedVoterCategory = {};
  Set<String> selectedPoliticalParty = {};
  Set<String> selectedReligionFilter = {};
  
  String selectedFeedback = 'Feedback';
  String selectedCasteCategory = 'Caste Category';
  String selectedCaste = 'Select Caste';
  String selectedSubCaste = 'Select Sub-Caste';
  String selectedParty = 'Select Party';
  String selectedCategory = 'Select Category';
  String selectedSchemes = 'Select Schemes';
  String selectedLanguage = 'Select Language';
  String selectedReligion = 'Select Religion';
  String selectedVoterHistory = 'Voter History';
  
  bool hasChanges = false;
  bool isShareExpanded = false; // For expanded share view

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this, initialIndex: 1); // Start with Family tab
  }

  void _showAdvancedSearchFamily() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.8,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'Advance Search',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Icon(Icons.close, size: 24),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              _buildSearchField('Mobile No', _mobileController),
              const SizedBox(height: 16),
              _buildSearchField('PartNo', _partNoController),
              const SizedBox(height: 16),
              _buildSearchField('Serial No', _serialNoController),
              const SizedBox(height: 16),
              _buildSearchField('EPIC Id', _epicIdController),
              const SizedBox(height: 16),
              _buildSearchField('Voter First Name', _voterFirstNameController),
              const SizedBox(height: 16),
              _buildSearchField('Voter Last Name', _voterLastNameController),
              const SizedBox(height: 16),
              _buildSearchField('Relation First Name', _relationFirstNameController),
              const SizedBox(height: 16),
              _buildSearchField('Relation Last Name', _relationLastNameController),
              const SizedBox(height: 16),
              _buildSearchField('Age', _ageController),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.grey[700],
                        side: BorderSide(color: Colors.grey[300]!),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text('Cancel'),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Search functionality implemented!')),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF1976D2),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text('Search'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showAdvancedSearchFriends() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.8,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'Advance Search',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Icon(Icons.close, size: 24),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              _buildSearchField('Mobile No', _mobileController),
              const SizedBox(height: 16),
              _buildSearchField('PartNo', _partNoController),
              const SizedBox(height: 16),
              _buildSearchField('Serial No', _serialNoController),
              const SizedBox(height: 16),
              _buildSearchField('EPIC Id', _epicIdController),
              const SizedBox(height: 16),
              _buildSearchField('Voter First Name', _voterFirstNameController),
              const SizedBox(height: 16),
              _buildSearchField('Voter Last Name', _voterLastNameController),
              const SizedBox(height: 16),
              _buildSearchField('Relation First Name', _relationFirstNameController),
              const SizedBox(height: 16),
              _buildSearchField('Relation Last Name', _relationLastNameController),
              const SizedBox(height: 16),
              _buildSearchField('Age', _ageController),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.grey[700],
                        side: BorderSide(color: Colors.grey[300]!),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text('Cancel'),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Search functionality implemented!')),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF1976D2),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text('Search'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchField(String label, TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Color(0xFF1976D2)),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    _feedbackController.dispose();
    _aadharController.dispose();
    _panController.dispose();
    _membershipController.dispose();
    _remarksController.dispose();
    _mobileController.dispose();
    _partNoController.dispose();
    _serialNoController.dispose();
    _epicIdController.dispose();
    _voterFirstNameController.dispose();
    _voterLastNameController.dispose();
    _relationFirstNameController.dispose();
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
                        'Voter Info',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 40,
                  ), // Spacer to center the title
                ],
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Voter card section
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16),
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
                children: [
                  // Header with serial, section, part
                  Row(
                    children: [
                      Icon(
                        Icons.star_outline,
                        color: Colors.pink,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Serial : ${widget.voterData['serialNo']}',
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF1976D2),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Spacer(),
                      Text(
                        'Section : ${widget.voterData['section'] ?? '1'}',
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF1976D2),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Spacer(),
                      Text(
                        'Part : ${widget.voterData['partNumber']}',
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF1976D2),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // Voter details row
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Profile image with camera icon
                      Stack(
                        children: [
                          Container(
                            width: 100,
                            height: 120,
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.grey[300]!),
                            ),
                            child: Column(
                              children: [
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.blue[100],
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(8),
                                        topRight: Radius.circular(8),
                                      ),
                                    ),
                                    child: Center(
                                      child: Icon(
                                        Icons.image,
                                        color: Colors.blue,
                                        size: 40,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.symmetric(vertical: 6),
                                  decoration: BoxDecoration(
                                    color: Color(0xFF1976D2),
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(8),
                                      bottomRight: Radius.circular(8),
                                    ),
                                  ),
                                  child: Text(
                                    widget.voterData['voterId'],
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Camera icon
                          Positioned(
                            top: 8,
                            right: 8,
                            child: Container(
                              padding: EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: Colors.black54,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.camera_alt,
                                color: Colors.white,
                                size: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                      
                      const SizedBox(width: 16),
                      
                      // Voter information
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.voterData['name'],
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                            Text(
                              widget.voterData['tamilName'],
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black54,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              widget.voterData['fatherName'],
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.black87,
                              ),
                            ),
                            Text(
                              widget.voterData['fatherTamilName'],
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black54,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              widget.voterData['doorNo'],
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black87,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // Age and relation row
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.blue[100],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.person,
                              color: Colors.blue,
                              size: 16,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '${widget.voterData['age']}',
                              style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        widget.voterData['relation'],
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 20),
            
            // Tabs section
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  _buildTab('Basic', 0, Icons.person_outline, onTap: _showBasicInfoModal),
                  _buildTab('Family', 1, Icons.family_restroom),
                  _buildTab('Share', 2, Icons.share_outlined, onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ShareScreen(voterData: widget.voterData),
                      ),
                    );
                  }),
                  _buildTab(AppLocalizations.of(context)?.friends ?? 'Friends', 3, Icons.people_outline, onTap: _showFriendsModal),
                ],
              ),
            ),
            
            const SizedBox(height: 20),
            
            // Tab content
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildBasicTab(),
                  _buildFamilyTab(),
                  _buildShareTab(),
                  _buildFriendsTab(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTab(String title, int index, IconData icon, {VoidCallback? onTap}) {
    bool isSelected = _tabController.index == index;
    return Expanded(
      child: GestureDetector(
        onTap: onTap ?? () {
          _tabController.animateTo(index);
          setState(() {});
        },
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 4),
          padding: EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? Color(0xFF1976D2) : Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: isSelected ? Color(0xFF1976D2) : Colors.grey[300]!,
            ),
          ),
          child: Column(
            children: [
              Icon(
                icon,
                color: isSelected ? Colors.white : Colors.grey[600],
                size: 20,
              ),
              const SizedBox(height: 4),
              Text(
                title,
                style: TextStyle(
                  fontSize: 12,
                  color: isSelected ? Colors.white : Colors.grey[600],
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBasicTab() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      child: SingleChildScrollView(
        child: Column(
          children: [
            // Caste Category dropdown
            _buildDropdownField(
              icon: Icons.category_outlined,
              value: selectedCasteCategory,
              items: ['Caste Category', 'General', 'OBC', 'SC', 'ST'],
              onChanged: (String? newValue) {
                setState(() {
                  selectedCasteCategory = newValue!;
                  _checkForChanges();
                });
              },
            ),
            
            const SizedBox(height: 16),
            
            // Caste dropdown
            _buildDropdownField(
              icon: Icons.people_outlined,
              value: selectedCaste,
              items: ['Select Caste', 'Vanniyar', 'Mudaliar', 'Pillai', 'Naidu', 'Reddy', 'Chettiar', 'Gounder', 'Other'],
              onChanged: (String? newValue) {
                setState(() {
                  selectedCaste = newValue!;
                  _checkForChanges();
                });
              },
            ),
            
            const SizedBox(height: 16),
            
            // Sub-Caste dropdown
            _buildDropdownField(
              icon: Icons.group_outlined,
              value: selectedSubCaste,
              items: ['Select Sub-Caste', 'Agamudayar', 'Kallar', 'Maravar', 'Thevar', 'Nadar', 'Other'],
              onChanged: (String? newValue) {
                setState(() {
                  selectedSubCaste = newValue!;
                  _checkForChanges();
                });
              },
            ),
            
            const SizedBox(height: 16),
            
            // Party dropdown
            _buildDropdownField(
              icon: Icons.how_to_vote_outlined,
              value: selectedParty,
              items: ['Select Party', 'ADMK', 'DMK', 'BJP', 'Congress', 'PMK', 'MDMK', 'VCK', 'AMMK', 'NTK', 'Other'],
              onChanged: (String? newValue) {
                setState(() {
                  selectedParty = newValue!;
                  _checkForChanges();
                });
              },
            ),
            
            const SizedBox(height: 16),
            
            // Category dropdown
            _buildDropdownField(
              icon: Icons.label_outlined,
              value: selectedCategory,
              items: ['Select Category', 'Active', 'Inactive', 'New', 'Shifted', 'Deleted', 'Pending'],
              onChanged: (String? newValue) {
                setState(() {
                  selectedCategory = newValue!;
                  _checkForChanges();
                });
              },
            ),
            
            const SizedBox(height: 16),
            
            // Schemes dropdown
            _buildDropdownField(
              icon: Icons.card_giftcard_outlined,
              value: selectedSchemes,
              items: ['Select Schemes', 'Ration Card', 'Pension', 'Housing', 'Education', 'Healthcare', 'Employment', 'Other'],
              onChanged: (String? newValue) {
                setState(() {
                  selectedSchemes = newValue!;
                  _checkForChanges();
                });
              },
            ),
            
            const SizedBox(height: 16),
            
            // Language dropdown
            _buildDropdownField(
              icon: Icons.language_outlined,
              value: selectedLanguage,
              items: ['Select Language', 'Tamil', 'English', 'Hindi', 'Telugu', 'Malayalam', 'Kannada', 'Other'],
              onChanged: (String? newValue) {
                setState(() {
                  selectedLanguage = newValue!;
                  _checkForChanges();
                });
              },
            ),
            
            const SizedBox(height: 16),
            
            // Feedback text field
            _buildTextField(
              icon: Icons.feedback_outlined,
              hint: 'Feedback',
              controller: _feedbackController,
              onChanged: (value) => _checkForChanges(),
            ),
            
            const SizedBox(height: 16),
            
            // Aadhar text field
            _buildTextField(
              icon: Icons.credit_card_outlined,
              hint: 'Aadhar Number',
              controller: _aadharController,
              onChanged: (value) => _checkForChanges(),
            ),
            
            const SizedBox(height: 16),
            
            // PAN text field
            _buildTextField(
              icon: Icons.account_balance_wallet_outlined,
              hint: 'PAN Number',
              controller: _panController,
              onChanged: (value) => _checkForChanges(),
            ),
            
            const SizedBox(height: 16),
            
            // Membership text field
            _buildTextField(
              icon: Icons.card_membership_outlined,
              hint: 'Membership Details',
              controller: _membershipController,
              onChanged: (value) => _checkForChanges(),
            ),
            
            const SizedBox(height: 16),
            
            // Remarks text field
            _buildTextField(
              icon: Icons.note_outlined,
              hint: 'Remarks',
              controller: _remarksController,
              maxLines: 3,
              onChanged: (value) => _checkForChanges(),
            ),
            
            const SizedBox(height: 24),
            
            // Dynamic button (No Changes / Update)
            GestureDetector(
              onTap: hasChanges ? _updateVoterInfo : null,
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  color: hasChanges ? Color(0xFF1976D2) : Colors.grey[400],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  hasChanges ? 'UPDATE' : 'NO CHANGES',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildFamilyTab() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          // Search and Filter section
          Row(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(color: Colors.grey[300]!),
                  ),
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Search by EPIC number or name',
                      hintStyle: TextStyle(
                        color: Colors.grey[400],
                        fontSize: 16,
                      ),
                      prefixIcon: Icon(Icons.search, color: Colors.grey[400]),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 15,
                      ),
                    ),
                    onTap: _showAdvancedSearchFamily,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              GestureDetector(
                onTap: _showAdvancedSearchFamily,
                child: Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey[300]!),
                  ),
                  child: Icon(
                    Icons.tune,
                    color: Colors.grey[600],
                    size: 20,
                  ),
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 40),
          
          // No family members found section
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.people_outline,
                    size: 80,
                    color: Colors.grey[400],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No family members found',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey[500],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Search by EPIC number to add family members',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[400],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildShareTab() {
    if (isShareExpanded) {
      return _buildExpandedShareView();
    }
    
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            
            // Voter card preview
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 8,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      // Voter photo
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          Icons.person,
                          size: 40,
                          color: Colors.grey[600],
                        ),
                      ),
                      
                      const SizedBox(width: 16),
                      
                      // Voter details
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.voterData['name'],
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'EPIC: ${widget.voterData['epicId']}',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[600],
                              ),
                            ),
                            Text(
                              'Age: ${widget.voterData['age']} | ${widget.voterData['relation']}',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[600],
                              ),
                            ),
                            Text(
                              'Part: ${widget.voterData['part']} | Serial: ${widget.voterData['serial']}',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 30),
            
            // Share options
            Text(
              'Share Voter Information',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            
            const SizedBox(height: 20),
            
            // Share buttons grid
            GridView.count(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 1.2,
              children: [
                _buildShareOption(
                  icon: Icons.message,
                  label: 'WhatsApp',
                  color: Colors.green,
                  onTap: () => _shareViaWhatsApp(),
                ),
                _buildShareOption(
                  icon: Icons.sms,
                  label: 'SMS',
                  color: Colors.blue,
                  onTap: () => _shareViaSMS(),
                ),
                _buildShareOption(
                  icon: Icons.share,
                  label: 'Share',
                  color: Colors.orange,
                  onTap: () => _shareGeneral(),
                ),
                _buildShareOption(
                  icon: Icons.print,
                  label: 'Take Print',
                  color: Colors.purple,
                  onTap: () => _takePrint(),
                ),
              ],
            ),
            
            const SizedBox(height: 30),
            
            // Additional sharing options
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey[300]!),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Share Options',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 12),
                  
                  // Share with details toggle
                  Row(
                    children: [
                      Checkbox(
                        value: true,
                        onChanged: (value) {},
                        activeColor: Color(0xFF1976D2),
                      ),
                      Text('Include personal details'),
                    ],
                  ),
                  
                  Row(
                    children: [
                      Checkbox(
                        value: false,
                        onChanged: (value) {},
                        activeColor: Color(0xFF1976D2),
                      ),
                      Text('Include contact information'),
                    ],
                  ),
                  
                  Row(
                    children: [
                      Checkbox(
                        value: true,
                        onChanged: (value) {},
                        activeColor: Color(0xFF1976D2),
                      ),
                      Text('Include voting history'),
                    ],
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildFriendsTab() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Center(
        child: Text(
          'Friends Information\nComing Soon!',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[600],
          ),
        ),
      ),
    );
  }

  // Helper methods for Basic tab
  Widget _buildDropdownField({
    required IconData icon,
    required String value,
    required List<String> items,
    required Function(String?) onChanged,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: DropdownButtonFormField<String>(
        value: value,
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: Color(0xFF1976D2)),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
        items: items.map((String item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Text(item),
          );
        }).toList(),
        onChanged: onChanged,
      ),
    );
  }

  Widget _buildTextField({
    required IconData icon,
    required String hint,
    required TextEditingController controller,
    required Function(String) onChanged,
    int maxLines = 1,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        onChanged: onChanged,
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: Color(0xFF1976D2)),
          hintText: hint,
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
      ),
    );
  }

  void _checkForChanges() {
    bool newHasChanges = 
        selectedCasteCategory != 'Caste Category' ||
        selectedCaste != 'Select Caste' ||
        selectedSubCaste != 'Select Sub-Caste' ||
        selectedParty != 'Select Party' ||
        selectedCategory != 'Select Category' ||
        selectedSchemes != 'Select Schemes' ||
        selectedLanguage != 'Select Language' ||
        selectedReligion != 'Select Religion' ||
        selectedVoterHistory != 'Voter History' ||
        selectedFeedback != 'Feedback' ||
        _feedbackController.text.isNotEmpty ||
        _aadharController.text.isNotEmpty ||
        _panController.text.isNotEmpty ||
        _membershipController.text.isNotEmpty ||
        _remarksController.text.isNotEmpty;
    
    if (newHasChanges != hasChanges) {
      setState(() {
        hasChanges = newHasChanges;
      });
    }
  }

  void _updateVoterInfo() {
    // Simulate update process
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Voter information updated successfully!'),
        backgroundColor: Colors.green,
      ),
    );
    
    // Reset changes flag
    setState(() {
      hasChanges = false;
    });
  }

  // Helper methods for Share tab
  Widget _buildShareOption({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withValues(alpha: 0.3)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: color,
                size: 24,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _shareViaWhatsApp() {
    _showShareOptionsModal();
  }

  void _shareViaSMS() {
    _generateShareMessage();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Opening SMS to share voter information...'),
        backgroundColor: Colors.blue,
      ),
    );
  }

  void _shareGeneral() {
    _generateShareMessage();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Opening share dialog...'),
        backgroundColor: Colors.orange,
      ),
    );
  }

  void _takePrint() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Preparing voter information for printing...'),
        backgroundColor: Colors.purple,
      ),
    );
  }

  String _generateShareMessage() {
    return '''
Voter Information:
Name: ${widget.voterData['name']}
EPIC ID: ${widget.voterData['epicId']}
Age: ${widget.voterData['age']}
Relation: ${widget.voterData['relation']}
Part: ${widget.voterData['part']}
Serial: ${widget.voterData['serial']}
${AppLocalizations.of(context)?.doorNo ?? 'Door No'}: ${widget.voterData['doorNo']}
    ''';
  }

  void _showShareOptionsModal() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.75,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          children: [
            const SizedBox(height: 20),
            
            // Share Options Grid
            SizedBox(
              height: 180,
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                padding: EdgeInsets.symmetric(horizontal: 30),
                children: [
                  _buildShareOption(
                    icon: Icons.message,
                    label: 'WhatsApp',
                    color: Colors.green,
                    onTap: () {
                      Navigator.pop(context);
                      _shareViaWhatsAppActual();
                    },
                  ),
                  _buildShareOption(
                    icon: Icons.sms,
                    label: 'SMS',
                    color: Colors.blue,
                    onTap: () {
                      Navigator.pop(context);
                      _shareViaSMS();
                    },
                  ),
                  _buildShareOption(
                    icon: Icons.share,
                    label: 'Share',
                    color: Colors.orange,
                    onTap: () {
                      Navigator.pop(context);
                      _shareGeneral();
                    },
                  ),
                  _buildShareOption(
                    icon: Icons.print,
                    label: 'Take Print',
                    color: Colors.purple,
                    onTap: () {
                      Navigator.pop(context);
                      _takePrint();
                    },
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 30),
            
            // Part & Section Info
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Part & Section Info',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 20),
                  
                  // Part info card
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey[300]!),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.05),
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '1 - Panchayat Union Ele. School,Thaliyur',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1976D2),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '1 - ஊராட்சி ஒன்றிய ஆரம்ப\nபள்ளி,தாளியூர்',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // Section info card
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey[300]!),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.05),
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '999 - வெளிநாட்டு வாக்காளர்',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1976D2),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '999 - OVERSEAS ELECTORS',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  void _shareViaWhatsAppActual() {
    _generateShareMessage();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Opening WhatsApp to share voter information...'),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _showBasicInfoModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => StatefulBuilder(
        builder: (context, setModalState) => Container(
          height: MediaQuery.of(context).size.height * 0.95,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Voter Info',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(Icons.close, size: 28),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 16),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        // Voter History dropdown
                        _buildDropdownField(
                          icon: Icons.history,
                          value: selectedVoterHistory,
                          items: ['Voter History', 'Active', 'Inactive', 'New', 'Transferred'],
                          onChanged: (String? newValue) {
                            setModalState(() {
                              selectedVoterHistory = newValue!;
                              _checkForChanges();
                            });
                          },
                        ),
                        const SizedBox(height: 16),
                        
                        // Phone Number field
                        _buildTextField(
                          icon: Icons.phone,
                          hint: '9965161134',
                          controller: TextEditingController(text: '9965161134'),
                          onChanged: (value) => _checkForChanges(),
                        ),
                        const SizedBox(height: 16),
                        
                        // WhatsApp Number field
                        _buildTextField(
                          icon: Icons.message,
                          hint: 'Enter Whatsapp Number',
                          controller: TextEditingController(),
                          onChanged: (value) => _checkForChanges(),
                        ),
                        const SizedBox(height: 16),
                        
                        // Location field with Fetch Location button
                        Row(
                          children: [
                            Expanded(
                              child: _buildTextField(
                                icon: Icons.location_on,
                                hint: '° N,° E',
                                controller: TextEditingController(),
                                onChanged: (value) => _checkForChanges(),
                              ),
                            ),
                            const SizedBox(width: 12),
                            ElevatedButton(
                              onPressed: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Fetching current location...'),
                                    backgroundColor: Colors.blue,
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xFF1976D2),
                                foregroundColor: Colors.white,
                                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: Text('Fetch Location'),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        
                        // Date field (01-SEP-1995)
                        _buildTextField(
                          icon: Icons.calendar_today,
                          hint: '01-SEP-1995',
                          controller: TextEditingController(text: '01-SEP-1995'),
                          onChanged: (value) => _checkForChanges(),
                        ),
                        const SizedBox(height: 16),
                        
                        // Email field
                        _buildTextField(
                          icon: Icons.email,
                          hint: 'Enter Email',
                          controller: _feedbackController,
                          onChanged: (value) => _checkForChanges(),
                        ),
                        const SizedBox(height: 16),
                        
                        // Religion dropdown
                        _buildDropdownField(
                          icon: Icons.temple_hindu,
                          value: selectedReligion,
                          items: ['Select Religion', 'Hindu', 'Muslim', 'Christian', 'Sikh', 'Buddhist', 'Jain', 'Other'],
                          onChanged: (String? newValue) {
                            setModalState(() {
                              selectedReligion = newValue!;
                              _checkForChanges();
                            });
                          },
                        ),
                        const SizedBox(height: 16),
                        
                        // Caste Category dropdown
                        _buildDropdownField(
                          icon: Icons.category,
                          value: selectedCasteCategory,
                          items: ['Caste Category', 'General', 'OBC', 'SC', 'ST'],
                          onChanged: (String? newValue) {
                            setModalState(() {
                              selectedCasteCategory = newValue!;
                              _checkForChanges();
                            });
                          },
                        ),
                        const SizedBox(height: 16),
                        
                        // Caste dropdown
                        _buildDropdownField(
                          icon: Icons.people,
                          value: selectedCaste,
                          items: ['Select Caste', 'Vanniyar', 'Mudaliar', 'Pillai', 'Naidu', 'Reddy', 'Chettiar', 'Gounder', 'Other'],
                          onChanged: (String? newValue) {
                            setModalState(() {
                              selectedCaste = newValue!;
                              _checkForChanges();
                            });
                          },
                        ),
                        const SizedBox(height: 16),
                        
                        // Sub-Caste dropdown
                        _buildDropdownField(
                          icon: Icons.group,
                          value: selectedSubCaste,
                          items: ['Select Sub-Caste', 'Agamudayar', 'Kallar', 'Maravar', 'Thevar', 'Nadar', 'Other'],
                          onChanged: (String? newValue) {
                            setModalState(() {
                              selectedSubCaste = newValue!;
                              _checkForChanges();
                            });
                          },
                        ),
                        const SizedBox(height: 16),
                        
                        // Party dropdown
                        _buildDropdownField(
                          icon: Icons.flag,
                          value: selectedParty,
                          items: ['Select Party', 'ADMK', 'DMK', 'BJP', 'Congress', 'PMK', 'MDMK', 'VCK', 'AMMK', 'NTK', 'Other'],
                          onChanged: (String? newValue) {
                            setModalState(() {
                              selectedParty = newValue!;
                              _checkForChanges();
                            });
                          },
                        ),
                        const SizedBox(height: 16),
                        
                        // Category dropdown
                        _buildDropdownField(
                          icon: Icons.label,
                          value: selectedCategory,
                          items: ['Select Category', 'Active', 'Inactive', 'New', 'Shifted', 'Deleted', 'Pending'],
                          onChanged: (String? newValue) {
                            setModalState(() {
                              selectedCategory = newValue!;
                              _checkForChanges();
                            });
                          },
                        ),
                        const SizedBox(height: 16),
                        
                        // Schemes dropdown
                        _buildDropdownField(
                          icon: Icons.card_giftcard,
                          value: selectedSchemes,
                          items: ['Select Schemes', 'Ration Card', 'Pension', 'Housing', 'Education', 'Healthcare', 'Employment', 'Other'],
                          onChanged: (String? newValue) {
                            setModalState(() {
                              selectedSchemes = newValue!;
                              _checkForChanges();
                            });
                          },
                        ),
                        const SizedBox(height: 16),
                        
                        // Language dropdown
                        _buildDropdownField(
                          icon: Icons.language,
                          value: selectedLanguage,
                          items: ['Select Language', 'Tamil', 'English', 'Hindi', 'Telugu', 'Malayalam', 'Kannada', 'Other'],
                          onChanged: (String? newValue) {
                            setModalState(() {
                              selectedLanguage = newValue!;
                              _checkForChanges();
                            });
                          },
                        ),
                        const SizedBox(height: 16),
                        
                        // Feedback dropdown
                        _buildDropdownField(
                          icon: Icons.feedback,
                          value: 'Feedback',
                          items: ['Feedback', 'Excellent', 'Good', 'Average', 'Poor', 'Very Poor'],
                          onChanged: (String? newValue) {
                            setModalState(() {
                              _checkForChanges();
                            });
                          },
                        ),
                        const SizedBox(height: 16),
                        
                        // Aadhar Number field
                        _buildTextField(
                          icon: Icons.credit_card,
                          hint: 'Enter Aadhar Number',
                          controller: _aadharController,
                          onChanged: (value) => _checkForChanges(),
                        ),
                        const SizedBox(height: 16),
                        
                        // PAN Number field
                        _buildTextField(
                          icon: Icons.account_balance_wallet,
                          hint: 'Xx',
                          controller: _panController,
                          onChanged: (value) => _checkForChanges(),
                        ),
                        const SizedBox(height: 16),
                        
                        // Membership Number field
                        _buildTextField(
                          icon: Icons.card_membership,
                          hint: 'Enter Membership Number',
                          controller: _membershipController,
                          onChanged: (value) => _checkForChanges(),
                        ),
                        const SizedBox(height: 24),
                        
                        // Dynamic Update/No Changes button
                        GestureDetector(
                          onTap: hasChanges ? () {
                            _updateVoterInfo();
                            Navigator.pop(context);
                          } : null,
                          child: Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(vertical: 16),
                            decoration: BoxDecoration(
                              color: hasChanges ? Color(0xFF1976D2) : Colors.grey[400],
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              hasChanges ? 'Update' : 'NO CHANGES',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showFriendsModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.95,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Voter Info',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(Icons.close, size: 28),
                  ),
                ],
              ),
            ),
            
            // Voter card at top
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16),
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
              child: Row(
                children: [
                  Icon(
                    Icons.person,
                    color: Color(0xFF1976D2),
                    size: 16,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '${widget.voterData['age']}',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF1976D2),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Text(
                    widget.voterData['relation'],
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black87,
                    ),
                  ),
                  Spacer(),
                  Text(
                    '${AppLocalizations.of(context)?.doorNo ?? 'Door No'} ${widget.voterData['doorNo']}',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 20),
            
            // Tab buttons
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  _buildModalTab('Basic', false),
                  _buildModalTab('Family', false),
                  _buildModalTab('Share', false),
                  _buildModalTab(AppLocalizations.of(context)?.friends ?? 'Friends', true),
                ],
              ),
            ),
            
            const SizedBox(height: 30),
            
            // Search and Filter section
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(25),
                        border: Border.all(color: Colors.grey[300]!),
                      ),
                      child: GestureDetector(
                        onTap: _showAdvancedSearchFriends,
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                AppLocalizations.of(context)?.searchByEpicOrName ?? 'Search by EPIC number or name',
                                style: TextStyle(
                                  color: Colors.grey[500],
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            Icon(
                              Icons.search,
                              color: Colors.grey[500],
                              size: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  GestureDetector(
                    onTap: _showAdvancedSearchFriends,
                    child: Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey[300]!),
                      ),
                      child: Icon(
                        Icons.tune,
                        color: Colors.grey[600],
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 40),
            
            // No friends found section
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.people_outline,
                      size: 80,
                      color: Colors.grey[400],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      AppLocalizations.of(context)?.noFriendsFound ?? 'No friends Found',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey[500],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Search by EPIC number or name',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[400],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildModalTab(String title, bool isSelected) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 4),
        padding: EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? Color(0xFF1976D2) : Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? Color(0xFF1976D2) : Colors.grey[300]!,
          ),
        ),
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 12,
            color: isSelected ? Colors.white : Colors.grey[600],
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _buildExpandedShareView() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            
            // Enhanced voter card matching image 2
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 8,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  // Voter details
                  Row(
                    children: [
                      // Photo section
                      Container(
                        width: 80,
                        height: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.grey[300]!),
                        ),
                        child: Column(
                          children: [
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Color(0xFF64B5F6),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(8),
                                    topRight: Radius.circular(8),
                                  ),
                                ),
                                child: Stack(
                                  children: [
                                    Center(
                                      child: Icon(
                                        Icons.person,
                                        color: Colors.white,
                                        size: 32,
                                      ),
                                    ),
                                    Positioned(
                                      top: 4,
                                      right: 4,
                                      child: Container(
                                        padding: EdgeInsets.all(2),
                                        decoration: BoxDecoration(
                                          color: Colors.black.withValues(alpha: 0.6),
                                          borderRadius: BorderRadius.circular(4),
                                        ),
                                        child: Icon(
                                          Icons.camera_alt,
                                          color: Colors.white,
                                          size: 12,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.symmetric(vertical: 4),
                              decoration: BoxDecoration(
                                color: Color(0xFF1976D2),
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(8),
                                  bottomRight: Radius.circular(8),
                                ),
                              ),
                              child: Text(
                                widget.voterData['voterId'] ?? 'RIV1048099',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                      
                      const SizedBox(width: 16),
                      
                      // Voter info
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.voterData['name'] ?? 'anitha',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                            Text(
                              widget.voterData['tamilName'] ?? 'அனிதா',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black54,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              widget.voterData['fatherName'] ?? 'nataraj',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black87,
                              ),
                            ),
                            Text(
                              widget.voterData['fatherTamilName'] ?? 'நடராஜ்',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black54,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              '${AppLocalizations.of(context)?.doorNo ?? 'Door No'} ${widget.voterData['doorNo'] ?? '1-24'}',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black87,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // Age and relation
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.pink[100],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.person,
                              color: Colors.pink,
                              size: 16,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '${widget.voterData['age'] ?? 33}',
                              style: TextStyle(
                                color: Colors.pink,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        widget.voterData['relation'] ?? 'Husband',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 30),
            
            // Share action buttons (matching image 2)
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 8,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(child: _buildActionButton('WhatsApp', Icons.message, Colors.green)),
                  const SizedBox(width: 12),
                  Expanded(child: _buildActionButton('SMS', Icons.chat_bubble, Colors.blue)),
                  const SizedBox(width: 12),
                  Expanded(child: _buildActionButton('Share', Icons.share, Color(0xFF1976D2))),
                  const SizedBox(width: 12),
                  Expanded(child: _buildActionButton('Take Print', Icons.print, Colors.grey[600]!)),
                ],
              ),
            ),
            
            const SizedBox(height: 30),
            
            // Part & Section Info
            Text(
              'Part & Section Info',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Part info cards
            _buildPartInfoCard(
              '2 - Panchayat Union Ele. School,Thaliyur',
              '2 - ஊராட்சி ஒன்றிய ஆரம்ப பள்ளி,தாளியூர்',
            ),
            
            const SizedBox(height: 16),
            
            _buildPartInfoCard(
              '1 - உலியம்பாளையம் மெயின்ரோடு வா.எண்.15',
              '1 - ULIYAMPALAYAM MAIN ROAD WARD NO.15',
            ),
            
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }



  Widget _buildActionButton(String title, IconData icon, Color color) {
    return GestureDetector(
      onTap: () {
        if (title == 'WhatsApp') {
          _shareViaWhatsAppActual();
        } else if (title == 'SMS') {
          _shareViaSMS();
        } else if (title == 'Share') {
          _shareGeneral();
        } else if (title == 'Take Print') {
          _takePrint();
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey[300]!),
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: color,
                size: 24,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(
                fontSize: 10,
                color: Colors.black87,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPartInfoCard(String title, String subtitle) {
    return Container(
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
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1976D2),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 14,
              color: Colors.black87,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}

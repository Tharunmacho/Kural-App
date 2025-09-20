import 'package:flutter/material.dart';
import '../data/voter.dart';

class VoterDetailScreen extends StatefulWidget {
  final Voter voter;
  
  const VoterDetailScreen({super.key, required this.voter});

  @override
  State<VoterDetailScreen> createState() => _VoterDetailScreenState();
}

class _VoterDetailScreenState extends State<VoterDetailScreen> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _whatsappController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _feedbackController = TextEditingController();
  final TextEditingController _aadharController = TextEditingController();
  final TextEditingController _panController = TextEditingController();
  final TextEditingController _membershipController = TextEditingController();
  final TextEditingController _remarksController = TextEditingController();
  
  String? _selectedReligion;
  String? _selectedCasteCategory;
  String? _selectedCaste;
  String? _selectedSubCaste;
  String? _selectedParty;
  String? _selectedCategory;
  String? _selectedSchemes;
  String? _selectedLanguage;
  String? _selectedFeedback;
  String? _selectedVoterHistory;
  int _selectedTabIndex = 1; // Start with Family tab selected
  bool hasChanges = false;

  @override
  void initState() {
    super.initState();
    print('VoterDetailScreen initialized with voter: ${widget.voter.voterFirstName}');
    
    // Pre-fill with voter data
    _phoneController.text = widget.voter.mobileNo ?? '';
    _dateController.text = '01-SEP-1995'; // Default date format
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _whatsappController.dispose();
    _locationController.dispose();
    _dateController.dispose();
    _emailController.dispose();
    _searchController.dispose();
    _feedbackController.dispose();
    _aadharController.dispose();
    _panController.dispose();
    _membershipController.dispose();
    _remarksController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F7FA),
      appBar: AppBar(
        backgroundColor: Color(0xFF1976D2),
        foregroundColor: Colors.white,
        elevation: 0,
        title: Text('Voter Info'),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back, color: Colors.white),
        ),
      ),
      body: Column(
        children: [
          // Voter Info Card
          Container(
            margin: EdgeInsets.all(16),
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 12,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              children: [
                // Top row with Serial, Section, Part
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Color(0xFF1976D2),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        'Serial : ${widget.voter.serialNo ?? 'N/A'}',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(width: 12),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Color(0xFF1976D2),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        'Section : 1',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(width: 12),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Color(0xFF1976D2),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        'Part : ${widget.voter.partNo ?? 'N/A'}',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                
                SizedBox(height: 16),
                
                // Main content row
                Row(
                  children: [
                    // Profile image placeholder
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: Color(0xFFE3F2FD),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Stack(
                        children: [
                          Center(
                            child: Icon(
                              Icons.landscape,
                              size: 40,
                              color: Colors.white,
                            ),
                          ),
                          Positioned(
                            top: 4,
                            right: 4,
                            child: Container(
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                color: Colors.grey[600],
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.camera_alt,
                                color: Colors.white,
                                size: 10,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    SizedBox(width: 16),
                    
                    // Voter details
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // EPIC ID
                          if (widget.voter.epicId != null && widget.voter.epicId!.isNotEmpty)
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: Color(0xFF1976D2),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                widget.voter.epicId!,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          
                          SizedBox(height: 8),
                          
                          // Voter name (English)
                          Text(
                            widget.voter.voterFirstName ?? 'N/A',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          
                          // Voter name (Tamil) - placeholder for now
                          Text(
                            'ஈஸ்வர்யா', // This would be dynamic in real implementation
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[600],
                            ),
                          ),
                          
                          SizedBox(height: 4),
                          
                          // Relation name (English)
                          if (widget.voter.relationFirstName != null && widget.voter.relationFirstName!.isNotEmpty)
                            Text(
                              widget.voter.relationFirstName!,
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey[600],
                              ),
                            ),
                          
                          // Relation name (Tamil) - placeholder for now
                          Text(
                            'இரத்னபாய்', // This would be dynamic in real implementation
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[500],
                            ),
                          ),
                          
                          SizedBox(height: 4),
                          
                          // Address
                          Text(
                            '2-3-5', // This would be dynamic in real implementation
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
                
                SizedBox(height: 16),
                
                // Bottom row with age and relation
                Row(
                  children: [
                    Icon(
                      Icons.people,
                      color: Color(0xFF1976D2),
                      size: 20,
                    ),
                    SizedBox(width: 8),
                    Text(
                      '${widget.voter.age ?? 'N/A'}',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(width: 8),
                    Text(
                      '|',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[400],
                      ),
                    ),
                    SizedBox(width: 8),
                    Text(
                      'Mother', // This would be dynamic in real implementation
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
          
          // Tab Bar
          Container(
            color: Colors.white,
            child: Row(
              children: [
                Expanded(
                  child: _buildTabButton('Basic', Icons.person, 0),
                ),
                Expanded(
                  child: _buildTabButton('Family', Icons.people, 1),
                ),
                Expanded(
                  child: _buildTabButton('Share', Icons.share, 2),
                ),
                Expanded(
                  child: _buildTabButton('Friends', Icons.people_outline, 3),
                ),
              ],
            ),
          ),
          
          // Tab Content
          Expanded(
            child: _buildTabContent(),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoField({
    required IconData icon,
    required String label,
    TextEditingController? controller,
    String? hintText,
    bool isDropdown = false,
    String? selectedValue,
    VoidCallback? onTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: ListTile(
        leading: Icon(
          icon,
          color: Colors.grey[600],
          size: 24,
        ),
        title: isDropdown
            ? Text(
                selectedValue ?? label,
                style: TextStyle(
                  color: selectedValue != null ? Colors.black : Colors.grey[500],
                  fontSize: 16,
                ),
              )
            : TextField(
                controller: controller,
                decoration: InputDecoration(
                  hintText: hintText ?? label,
                  hintStyle: TextStyle(color: Colors.grey[500]),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.zero,
                ),
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
        trailing: isDropdown
            ? Icon(
                Icons.keyboard_arrow_down,
                color: Colors.grey[600],
              )
            : null,
        onTap: onTap,
      ),
    );
  }

  Widget _buildLocationField() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: ListTile(
        leading: Icon(
          Icons.location_on,
          color: Colors.grey[600],
          size: 24,
        ),
        title: TextField(
          controller: _locationController,
          decoration: InputDecoration(
            hintText: '° N,° E',
            hintStyle: TextStyle(color: Colors.grey[500]),
            border: InputBorder.none,
            contentPadding: EdgeInsets.zero,
          ),
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
          ),
        ),
        trailing: Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: Color(0xFF1976D2),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            'Fetch Location',
            style: TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        onTap: () {
          // Handle location fetch
        },
      ),
    );
  }

  void _showReligionDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Select Religion'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildDialogOption('Hindu', _selectedReligion),
            _buildDialogOption('Muslim', _selectedReligion),
            _buildDialogOption('Christian', _selectedReligion),
            _buildDialogOption('Sikh', _selectedReligion),
            _buildDialogOption('Buddhist', _selectedReligion),
            _buildDialogOption('Jain', _selectedReligion),
            _buildDialogOption('Other', _selectedReligion),
          ],
        ),
      ),
    );
  }

  void _showCasteCategoryDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Select Caste Category'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildDialogOption('General', _selectedCasteCategory),
            _buildDialogOption('OBC', _selectedCasteCategory),
            _buildDialogOption('SC', _selectedCasteCategory),
            _buildDialogOption('ST', _selectedCasteCategory),
          ],
        ),
      ),
    );
  }

  void _showCasteDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Select Caste'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildDialogOption('Brahmin', _selectedCaste),
            _buildDialogOption('Kshatriya', _selectedCaste),
            _buildDialogOption('Vaishya', _selectedCaste),
            _buildDialogOption('Shudra', _selectedCaste),
            _buildDialogOption('Other', _selectedCaste),
          ],
        ),
      ),
    );
  }

  Widget _buildDialogOption(String option, String? selectedValue) {
    return ListTile(
      title: Text(option),
      trailing: selectedValue == option ? Icon(Icons.check, color: Color(0xFF1976D2)) : null,
      onTap: () {
        setState(() {
          if (option == 'Hindu' || option == 'Muslim' || option == 'Christian' || 
              option == 'Sikh' || option == 'Buddhist' || option == 'Jain' || option == 'Other') {
            _selectedReligion = option;
          } else if (option == 'General' || option == 'OBC' || option == 'SC' || option == 'ST') {
            _selectedCasteCategory = option;
          } else {
            _selectedCaste = option;
          }
        });
        Navigator.pop(context);
      },
    );
  }

  Widget _buildDropdownField({
    required IconData icon,
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(16),
            child: Icon(
              icon,
              color: Colors.grey[600],
              size: 20,
            ),
          ),
          Expanded(
            child: DropdownButtonFormField<String>(
              value: value,
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 15),
              ),
              items: items.map((String item) {
                return DropdownMenuItem<String>(
                  value: item,
                  child: Text(
                    item,
                    style: TextStyle(
                      color: item == value && items.indexOf(item) == 0 
                          ? Colors.grey[400] 
                          : Colors.black87,
                    ),
                  ),
                );
              }).toList(),
              onChanged: onChanged,
              icon: Icon(
                Icons.keyboard_arrow_down,
                color: Colors.grey[600],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputField({
    required IconData icon,
    required Widget child,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(16),
            child: Icon(
              icon,
              color: Colors.grey[600],
              size: 20,
            ),
          ),
          Expanded(child: child),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required IconData icon,
    required String hint,
    required TextEditingController controller,
    required Function(String) onChanged,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(16),
            child: Icon(
              icon,
              color: Colors.grey[600],
              size: 20,
            ),
          ),
          Expanded(
            child: TextField(
              controller: controller,
              onChanged: onChanged,
              decoration: InputDecoration(
                hintText: hint,
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 15),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _checkForChanges() {
    // This method can be implemented to track changes
    setState(() {
      hasChanges = true;
    });
  }

  void _updateVoterInfo() {
    // This method can be implemented to update voter info
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Voter info updated successfully!'),
        backgroundColor: Colors.green,
      ),
    );
    setState(() {
      hasChanges = false;
    });
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
                          value: _selectedVoterHistory ?? 'Voter History',
                          items: ['Voter History', 'Active', 'Inactive', 'New', 'Transferred'],
                          onChanged: (String? newValue) {
                            setModalState(() {
                              _selectedVoterHistory = newValue;
                              _checkForChanges();
                            });
                          },
                        ),
                        const SizedBox(height: 16),
                        
                        // Phone Number field
                        _buildTextField(
                          icon: Icons.phone,
                          hint: widget.voter.mobileNo ?? '9965161134',
                          controller: TextEditingController(text: widget.voter.mobileNo ?? '9965161134'),
                          onChanged: (value) => _checkForChanges(),
                        ),
                        const SizedBox(height: 16),
                        
                        // WhatsApp Number field
                        _buildTextField(
                          icon: Icons.message,
                          hint: 'Enter Whatsapp Number',
                          controller: _whatsappController,
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
                                controller: _locationController,
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
                                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: Text('Fetch Location'),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        
                        // Date field
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
                          controller: _emailController,
                          onChanged: (value) => _checkForChanges(),
                        ),
                        const SizedBox(height: 16),
                        
                        // Religion dropdown
                        _buildDropdownField(
                          icon: Icons.temple_hindu,
                          value: _selectedReligion ?? 'Select Religion',
                          items: ['Select Religion', 'Hindu', 'Muslim', 'Christian', 'Sikh', 'Buddhist', 'Jain', 'Other'],
                          onChanged: (String? newValue) {
                            setModalState(() {
                              _selectedReligion = newValue;
                              _checkForChanges();
                            });
                          },
                        ),
                        const SizedBox(height: 16),
                        
                        // Caste Category dropdown
                        _buildDropdownField(
                          icon: Icons.category,
                          value: _selectedCasteCategory ?? 'Caste Category',
                          items: ['Caste Category', 'General', 'OBC', 'SC', 'ST'],
                          onChanged: (String? newValue) {
                            setModalState(() {
                              _selectedCasteCategory = newValue;
                              _checkForChanges();
                            });
                          },
                        ),
                        const SizedBox(height: 16),
                        
                        // Caste dropdown
                        _buildDropdownField(
                          icon: Icons.people,
                          value: _selectedCaste ?? 'Select Caste',
                          items: ['Select Caste', 'Brahmin', 'Kshatriya', 'Vaishya', 'Shudra', 'Other'],
                          onChanged: (String? newValue) {
                            setModalState(() {
                              _selectedCaste = newValue;
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
                          hint: 'Enter Pan Number',
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
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Voter info updated successfully!'),
                                backgroundColor: Colors.green,
                              ),
                            );
                            setModalState(() {
                              hasChanges = false;
                            });
                            Navigator.pop(context);
                          } : null,
                          child: Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(vertical: 16),
                            decoration: BoxDecoration(
                              color: hasChanges ? Color(0xFF1976D2) : Colors.grey[300],
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              hasChanges ? 'Update Voter Info' : 'No Changes',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: hasChanges ? Colors.white : Colors.grey[600],
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 40),
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

  Widget _buildTabButton(String title, IconData icon, int index) {
    bool isSelected = _selectedTabIndex == index;
    return GestureDetector(
      onTap: () {
        if (index == 0) {
          // Basic tab - show modal
          _showBasicInfoModal();
        } else {
          // Other tabs - normal tab switching
          setState(() {
            _selectedTabIndex = index;
          });
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: isSelected ? Color(0xFF1976D2) : Colors.white,
          border: Border(
            bottom: BorderSide(
              color: isSelected ? Color(0xFF1976D2) : Colors.grey[300]!,
              width: 2,
            ),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isSelected ? Colors.white : Colors.grey[600],
              size: 24,
            ),
            SizedBox(height: 4),
            Text(
              title,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.grey[600],
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabContent() {
    switch (_selectedTabIndex) {
      case 0:
        // Basic tab - show a placeholder since it opens modal
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 16),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.description_outlined,
                  size: 80,
                  color: Colors.grey[400],
                ),
                const SizedBox(height: 16),
                Text(
                  'Tap "Basic" tab to edit voter information',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'All form fields and voter details are available in the modal',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
          ),
        );
      case 1:
        return _buildFamilyTab();
      case 2:
        return _buildShareTab();
      case 3:
        return _buildFriendsTab();
      default:
        return _buildFamilyTab();
    }
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
              value: _selectedCasteCategory ?? 'Caste Category',
              items: ['Caste Category', 'General', 'OBC', 'SC', 'ST'],
              onChanged: (String? newValue) {
                setState(() {
                  _selectedCasteCategory = newValue;
                  _checkForChanges();
                });
              },
            ),
            
            const SizedBox(height: 16),
            
            // Select Caste dropdown
            _buildDropdownField(
              icon: Icons.people_outline,
              value: _selectedCaste ?? 'Select Caste',
              items: ['Select Caste', 'Brahmin', 'Kshatriya', 'Vaishya', 'Shudra', 'Other'],
              onChanged: (String? newValue) {
                setState(() {
                  _selectedCaste = newValue;
                  _checkForChanges();
                });
              },
            ),
            
            const SizedBox(height: 16),
            
            // Select Sub-Caste dropdown
            _buildDropdownField(
              icon: Icons.group_outlined,
              value: _selectedSubCaste ?? 'Select Sub-Caste',
              items: ['Select Sub-Caste', 'Sub-Caste 1', 'Sub-Caste 2', 'Sub-Caste 3'],
              onChanged: (String? newValue) {
                setState(() {
                  _selectedSubCaste = newValue;
                  _checkForChanges();
                });
              },
            ),
            
            const SizedBox(height: 16),
            
            // Select Party dropdown
            _buildDropdownField(
              icon: Icons.flag_outlined,
              value: _selectedParty ?? 'Select Party',
              items: ['Select Party', 'BJP', 'Congress', 'AAP', 'DMK', 'AIADMK', 'Other'],
              onChanged: (String? newValue) {
                setState(() {
                  _selectedParty = newValue;
                  _checkForChanges();
                });
              },
            ),
            
            const SizedBox(height: 16),
            
            // Select Category dropdown
            _buildDropdownField(
              icon: Icons.category,
              value: _selectedCategory ?? 'Select Category',
              items: ['Select Category', 'Category 1', 'Category 2', 'Category 3'],
              onChanged: (String? newValue) {
                setState(() {
                  _selectedCategory = newValue;
                  _checkForChanges();
                });
              },
            ),
            
            const SizedBox(height: 16),
            
            // Select Schemes dropdown
            _buildDropdownField(
              icon: Icons.schema_outlined,
              value: _selectedSchemes ?? 'Select Schemes',
              items: ['Select Schemes', 'Scheme 1', 'Scheme 2', 'Scheme 3'],
              onChanged: (String? newValue) {
                setState(() {
                  _selectedSchemes = newValue;
                  _checkForChanges();
                });
              },
            ),
            
            const SizedBox(height: 16),
            
            // Select Language dropdown
            _buildDropdownField(
              icon: Icons.language_outlined,
              value: _selectedLanguage ?? 'Select Language',
              items: ['Select Language', 'Tamil', 'English', 'Hindi', 'Telugu', 'Malayalam'],
              onChanged: (String? newValue) {
                setState(() {
                  _selectedLanguage = newValue;
                  _checkForChanges();
                });
              },
            ),
            
            const SizedBox(height: 16),
            
            // Feedback dropdown
            _buildDropdownField(
              icon: Icons.feedback_outlined,
              value: _selectedFeedback ?? 'Feedback',
              items: ['Feedback', 'Positive', 'Negative', 'Neutral'],
              onChanged: (String? newValue) {
                setState(() {
                  _selectedFeedback = newValue;
                  _checkForChanges();
                });
              },
            ),
            
            const SizedBox(height: 16),
            
            // Aadhar Number
            _buildInputField(
              icon: Icons.credit_card,
              child: TextField(
                controller: _aadharController,
                onChanged: (value) => _checkForChanges(),
                decoration: InputDecoration(
                  hintText: 'Enter Aadhar Number',
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 15),
                ),
              ),
            ),
            
            const SizedBox(height: 16),
            
            // PAN Number
            _buildInputField(
              icon: Icons.account_balance_wallet,
              child: TextField(
                controller: _panController,
                onChanged: (value) => _checkForChanges(),
                decoration: InputDecoration(
                  hintText: 'Enter Pan Number',
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 15),
                ),
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Membership Number
            _buildInputField(
              icon: Icons.card_membership,
              child: TextField(
                controller: _membershipController,
                onChanged: (value) => _checkForChanges(),
                decoration: InputDecoration(
                  hintText: 'Enter Membership Number',
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 15),
                ),
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Phone Number
            _buildInputField(
              icon: Icons.phone,
              child: TextField(
                controller: _phoneController,
                onChanged: (value) => _checkForChanges(),
                decoration: InputDecoration(
                  hintText: 'Enter Phone Number',
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 15),
                ),
              ),
            ),
            
            const SizedBox(height: 16),
            
            // WhatsApp Number
            _buildInputField(
              icon: Icons.chat,
              child: TextField(
                controller: _whatsappController,
                onChanged: (value) => _checkForChanges(),
                decoration: InputDecoration(
                  hintText: 'Enter WhatsApp Number',
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 15),
                ),
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Email
            _buildInputField(
              icon: Icons.email,
              child: TextField(
                controller: _emailController,
                onChanged: (value) => _checkForChanges(),
                decoration: InputDecoration(
                  hintText: 'Enter Email',
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 15),
                ),
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Location
            _buildLocationField(),
            
            const SizedBox(height: 16),
            
            // Date
            _buildInputField(
              icon: Icons.calendar_today,
              child: TextField(
                controller: _dateController,
                onChanged: (value) => _checkForChanges(),
                decoration: InputDecoration(
                  hintText: 'Enter Date',
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 15),
                ),
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Religion dropdown
            _buildDropdownField(
              icon: Icons.temple_hindu,
              value: _selectedReligion ?? 'Select Religion',
              items: ['Select Religion', 'Hindu', 'Muslim', 'Christian', 'Sikh', 'Buddhist', 'Jain', 'Other'],
              onChanged: (String? newValue) {
                setState(() {
                  _selectedReligion = newValue;
                  _checkForChanges();
                });
              },
            ),
            
            const SizedBox(height: 16),
            
            // Voter History dropdown
            _buildDropdownField(
              icon: Icons.history,
              value: _selectedVoterHistory ?? 'Voter History',
              items: ['Voter History', 'First Time', 'Regular', 'Occasional'],
              onChanged: (String? newValue) {
                setState(() {
                  _selectedVoterHistory = newValue;
                  _checkForChanges();
                });
              },
            ),
            
            const SizedBox(height: 16),
            
            // Remarks
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey[300]!),
              ),
              child: TextField(
                controller: _remarksController,
                onChanged: (value) => _checkForChanges(),
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: 'Enter Remarks',
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(16),
                ),
              ),
            ),
            
            const SizedBox(height: 30),
            
            // Dynamic button (No Changes / Update)
            GestureDetector(
              onTap: hasChanges ? _updateVoterInfo : null,
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  color: hasChanges ? Color(0xFF1976D2) : Colors.grey[300],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  hasChanges ? 'Update Voter Info' : 'No Changes',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: hasChanges ? Colors.white : Colors.grey[600],
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildFamilyTab() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          // Search section
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25),
              border: Border.all(color: Colors.grey[300]!),
            ),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search by EPIC number or ...',
                hintStyle: TextStyle(color: Colors.grey[500]),
                prefixIcon: Icon(Icons.search, color: Colors.grey[600]),
                suffixIcon: Icon(Icons.tune, color: Colors.grey[600]),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              ),
            ),
          ),
          
          const SizedBox(height: 20),
          
          // Family members section
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey[300]!),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.people,
                      size: 80,
                      color: Colors.grey[400],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'No family members found',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Search by EPIC number to add family members',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[500],
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        // Add family member functionality
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Add family member functionality coming soon!'),
                            backgroundColor: Color(0xFF1976D2),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF1976D2),
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text('Add Family Member'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildShareTab() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          // Age and relation info
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey[300]!),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.people,
                  color: Color(0xFF1976D2),
                  size: 24,
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Age: ${widget.voter.age ?? 'N/A'}',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Relation: Mother', // This would be dynamic in real implementation
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 20),
          
          // Share options
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey[300]!),
            ),
            child: Column(
              children: [
                Text(
                  'Share Voter Information',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 16),
                
                // Share buttons
                Row(
                  children: [
                    Expanded(
                      child: _buildShareButton(
                        icon: Icons.share,
                        label: 'Share',
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Share functionality coming soon!'),
                              backgroundColor: Color(0xFF1976D2),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildShareButton(
                        icon: Icons.copy,
                        label: 'Copy',
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Voter info copied to clipboard!'),
                              backgroundColor: Colors.green,
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: 12),
                
                Row(
                  children: [
                    Expanded(
                      child: _buildShareButton(
                        icon: Icons.print,
                        label: 'Print',
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Print functionality coming soon!'),
                              backgroundColor: Color(0xFF1976D2),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildShareButton(
                        icon: Icons.download,
                        label: 'Export',
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Export functionality coming soon!'),
                              backgroundColor: Color(0xFF1976D2),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildShareButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          color: Color(0xFF1976D2).withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Color(0xFF1976D2).withValues(alpha: 0.3)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: Color(0xFF1976D2),
              size: 20,
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                color: Color(0xFF1976D2),
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFriendsTab() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.group_off,
              size: 80,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 16),
            Text(
              'No friends found',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Add friends to see their voter information',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[500],
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Add friends functionality coming soon!'),
                    backgroundColor: Color(0xFF1976D2),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF1976D2),
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text('Add Friends'),
            ),
          ],
        ),
      ),
    );
  }
}

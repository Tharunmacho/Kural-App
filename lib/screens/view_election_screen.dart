import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';

class ViewElectionScreen extends StatefulWidget {
  const ViewElectionScreen({super.key});

  @override
  State<ViewElectionScreen> createState() => _ViewElectionScreenState();
}

class _ViewElectionScreenState extends State<ViewElectionScreen> {
  final ScrollController _scrollController = ScrollController();
  final ImagePicker _picker = ImagePicker();
  File? _selectedImage;
  
  // Text editing controllers for all fields
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _electionTypeController = TextEditingController();
  final TextEditingController _electionBodyController = TextEditingController();
  final TextEditingController _countryController = TextEditingController(text: 'India');
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _pcNameController = TextEditingController(text: 'Pollachi');
  final TextEditingController _acNameController = TextEditingController(text: 'Thondamuthur');
  final TextEditingController _urbanNameController = TextEditingController();
  final TextEditingController _ruralNameController = TextEditingController();
  final TextEditingController _electionNameController = TextEditingController(text: '119 - Thondamuthur');
  final TextEditingController _electionDescriptionController = TextEditingController();
  final TextEditingController _electionDateController = TextEditingController();
  final TextEditingController _statusController = TextEditingController();
  
  // Booth Information Controllers
  final TextEditingController _totalBoothsController = TextEditingController();
  final TextEditingController _totalAllBoothsController = TextEditingController();
  final TextEditingController _pinkBoothsController = TextEditingController();
  
  // Voter Information Controllers
  final TextEditingController _totalVotersController = TextEditingController();
  final TextEditingController _maleVotersController = TextEditingController();
  final TextEditingController _femaleVotersController = TextEditingController();
  final TextEditingController _transgenderVotersController = TextEditingController();
  
  // Remarks Controller
  final TextEditingController _remarksController = TextEditingController();
  
  // Calendar of Event Controllers
  final TextEditingController _gazetteNotificationController = TextEditingController();
  final TextEditingController _lastDateNominationController = TextEditingController();
  final TextEditingController _scrutinyNominationController = TextEditingController();
  final TextEditingController _lastDateWithdrawalController = TextEditingController();
  final TextEditingController _dateOfPollController = TextEditingController();
  final TextEditingController _dateOfCountingController = TextEditingController();
  final TextEditingController _completionDeadlineController = TextEditingController();
  
  // Dropdown selections
  String _selectedCategory = 'Political';
  String _selectedElectionType = 'General';
  String _selectedElectionBody = 'Union Body (MP)';
  String _selectedState = 'Tamil Nadu';
  String _selectedStatus = 'Yet to Start';

  // Date selections
  DateTime? _selectedElectionDate;
  DateTime? _selectedGazetteDate;
  DateTime? _selectedLastDateNomination;
  DateTime? _selectedScrutinyDate;
  DateTime? _selectedLastDateWithdrawal;
  DateTime? _selectedDateOfPoll;
  DateTime? _selectedDateOfCounting;
  DateTime? _selectedCompletionDeadline;

  // State management
  bool _hasChanges = false;
  bool _isSaving = false;
  bool _isLoading = true;
  String? _electionDocumentId;

  // Original values for change tracking
  String _originalCategory = 'Political';
  String _originalElectionType = 'General';
  String _originalElectionBody = 'Union Body (MP)';
  String _originalState = 'Tamil Nadu';
  String _originalStatus = 'Yet to Start';
  DateTime? _originalElectionDate;
  DateTime? _originalGazetteDate;
  DateTime? _originalLastDateNomination;
  DateTime? _originalScrutinyDate;
  DateTime? _originalLastDateWithdrawal;
  DateTime? _originalDateOfPoll;
  DateTime? _originalDateOfCounting;
  DateTime? _originalCompletionDeadline;

  // Dropdown options
  final List<String> _categoryOptions = ['Political', 'Non-Political'];
  final List<String> _electionTypeOptions = ['General', 'By-election'];
  final List<String> _electionBodyOptions = [
    'Union Body (MP)',
    'State Body (MLA)',
    'Urban Body',
    'Rural Body'
  ];
  final List<String> _statusOptions = [
    'Yet to Start',
    'In-Progress',
    'Completed',
    'Cancelled'
  ];
  final List<String> _stateOptions = [
    'Andhra Pradesh', 'Arunachal Pradesh', 'Assam', 'Bihar', 'Chhattisgarh',
    'Goa', 'Gujarat', 'Haryana', 'Himachal Pradesh', 'Jharkhand', 'Karnataka',
    'Kerala', 'Madhya Pradesh', 'Maharashtra', 'Manipur', 'Meghalaya', 'Mizoram',
    'Nagaland', 'Odisha', 'Punjab', 'Rajasthan', 'Sikkim', 'Tamil Nadu',
    'Telangana', 'Tripura', 'Uttar Pradesh', 'Uttarakhand', 'West Bengal',
    'Andaman and Nicobar Islands', 'Chandigarh', 'Dadra and Nagar Haveli and Daman and Diu',
    'Delhi', 'Jammu and Kashmir', 'Ladakh', 'Lakshadweep', 'Puducherry'
  ];

  @override
  void initState() {
    super.initState();
    _setupChangeListeners();
    _loadElectionData();
  }

  void _setupChangeListeners() {
    // Add listeners to all controllers to track changes
    final controllers = [
      _categoryController, _electionTypeController, _electionBodyController,
      _stateController, _urbanNameController, _ruralNameController,
      _electionDescriptionController, _electionDateController, _statusController,
      _totalBoothsController, _totalAllBoothsController, _pinkBoothsController,
      _totalVotersController, _maleVotersController, _femaleVotersController,
      _transgenderVotersController, _remarksController, _gazetteNotificationController,
      _lastDateNominationController, _scrutinyNominationController,
      _lastDateWithdrawalController, _dateOfPollController,
      _dateOfCountingController, _completionDeadlineController
    ];
    
    for (var controller in controllers) {
      controller.addListener(_checkForChanges);
    }
  }

  void _checkForChanges() {
    final newHasChanges = 
        // Dropdown changes (comparing against original values)
        _selectedCategory != _originalCategory ||
        _selectedElectionType != _originalElectionType ||
        _selectedElectionBody != _originalElectionBody ||
        _selectedState != _originalState ||
        _selectedStatus != _originalStatus ||
        
        // Date changes (comparing against original values)
        !_datesEqual(_selectedElectionDate, _originalElectionDate) ||
        !_datesEqual(_selectedGazetteDate, _originalGazetteDate) ||
        !_datesEqual(_selectedLastDateNomination, _originalLastDateNomination) ||
        !_datesEqual(_selectedScrutinyDate, _originalScrutinyDate) ||
        !_datesEqual(_selectedLastDateWithdrawal, _originalLastDateWithdrawal) ||
        !_datesEqual(_selectedDateOfPoll, _originalDateOfPoll) ||
        !_datesEqual(_selectedDateOfCounting, _originalDateOfCounting) ||
        !_datesEqual(_selectedCompletionDeadline, _originalCompletionDeadline) ||
        
        // Text field changes
        _urbanNameController.text.isNotEmpty ||
        _ruralNameController.text.isNotEmpty ||
        _electionDescriptionController.text.isNotEmpty ||
        _totalBoothsController.text.isNotEmpty ||
        _totalAllBoothsController.text.isNotEmpty ||
        _pinkBoothsController.text.isNotEmpty ||
        _totalVotersController.text.isNotEmpty ||
        _maleVotersController.text.isNotEmpty ||
        _femaleVotersController.text.isNotEmpty ||
        _transgenderVotersController.text.isNotEmpty ||
        _remarksController.text.isNotEmpty;
    
    if (newHasChanges != _hasChanges) {
      setState(() {
        _hasChanges = newHasChanges;
      });
      debugPrint('Changes detected: $_hasChanges');
      if (_hasChanges) {
        debugPrint('Completion deadline changed: ${!_datesEqual(_selectedCompletionDeadline, _originalCompletionDeadline)}');
        debugPrint('Original: $_originalCompletionDeadline, Current: $_selectedCompletionDeadline');
      }
    }
  }

  bool _datesEqual(DateTime? date1, DateTime? date2) {
    if (date1 == null && date2 == null) return true;
    if (date1 == null || date2 == null) return false;
    return date1.year == date2.year && 
           date1.month == date2.month && 
           date1.day == date2.day;
  }

  @override
  void dispose() {
    _scrollController.dispose();
    // Dispose all controllers
    _categoryController.dispose();
    _electionTypeController.dispose();
    _electionBodyController.dispose();
    _countryController.dispose();
    _stateController.dispose();
    _pcNameController.dispose();
    _acNameController.dispose();
    _urbanNameController.dispose();
    _ruralNameController.dispose();
    _electionNameController.dispose();
    _electionDescriptionController.dispose();
    _electionDateController.dispose();
    _statusController.dispose();
    _totalBoothsController.dispose();
    _totalAllBoothsController.dispose();
    _pinkBoothsController.dispose();
    _totalVotersController.dispose();
    _maleVotersController.dispose();
    _femaleVotersController.dispose();
    _transgenderVotersController.dispose();
    _remarksController.dispose();
    _gazetteNotificationController.dispose();
    _lastDateNominationController.dispose();
    _scrutinyNominationController.dispose();
    _lastDateWithdrawalController.dispose();
    _dateOfPollController.dispose();
    _dateOfCountingController.dispose();
    _completionDeadlineController.dispose();
    super.dispose();
  }

  Future<void> _loadElectionData() async {
    try {
      debugPrint('Starting to load election data from Firebase...');
      
      // Ensure we have an authenticated session
      if (FirebaseAuth.instance.currentUser == null) {
        debugPrint('No authenticated user, signing in anonymously...');
        await FirebaseAuth.instance.signInAnonymously();
        debugPrint('Anonymous sign-in successful');
      } else {
        debugPrint('User already authenticated: ${FirebaseAuth.instance.currentUser?.uid}');
      }

      // Test basic Firebase connection first
      try {
        await FirebaseFirestore.instance.enableNetwork();
        debugPrint('Firebase network enabled successfully');
      } catch (e) {
        debugPrint('Failed to enable Firebase network: $e');
      }

      // Query for existing election document
      debugPrint('Querying Election collection...');
      final QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore.instance
          .collection('Election')
          .get(const GetOptions(source: Source.serverAndCache))
          .timeout(const Duration(seconds: 15));
      
      debugPrint('Query completed. Found ${querySnapshot.docs.length} documents');
      
      if (querySnapshot.docs.isNotEmpty) {
        debugPrint('Available documents:');
        for (var doc in querySnapshot.docs) {
          debugPrint('  - Document ID: ${doc.id}');
          debugPrint('  - Document data keys: ${doc.data().keys.toList()}');
        }
      }

      if (querySnapshot.docs.isNotEmpty) {
        final doc = querySnapshot.docs.first;
        _electionDocumentId = doc.id;
        final data = doc.data();

        // Load data into form
        setState(() {
          // Load dropdown selections - convert to proper case if needed
          _selectedCategory = data['Category'] ?? 'Political';
          _originalCategory = _selectedCategory;
          
          String electionType = data['Election_Type'] ?? 'General';
          _selectedElectionType = electionType.toLowerCase() == 'general' ? 'General' : 'By-election';
          _originalElectionType = _selectedElectionType;
          
          String electionBody = data['Election_body'] ?? 'Union Body (MP)';
          // Map Firebase values to dropdown options
          if (electionBody.toLowerCase().contains('state') || electionBody.toLowerCase().contains('mla')) {
            _selectedElectionBody = 'State Body (MLA)';
          } else if (electionBody.toLowerCase().contains('union') || electionBody.toLowerCase().contains('mp')) {
            _selectedElectionBody = 'Union Body (MP)';
          } else if (electionBody.toLowerCase().contains('urban')) {
            _selectedElectionBody = 'Urban Body';
          } else if (electionBody.toLowerCase().contains('rural')) {
            _selectedElectionBody = 'Rural Body';
          } else {
            _selectedElectionBody = 'State Body (MLA)'; // Default
          }
          _originalElectionBody = _selectedElectionBody;
          
          _selectedState = data['State'] ?? 'Tamil Nadu';
          _originalState = _selectedState;
          _selectedStatus = data['Status'] ?? 'Yet to Start';
          _originalStatus = _selectedStatus;
          
          // Load text fields
          _countryController.text = data['Country'] ?? 'India';
          _pcNameController.text = data['PC_Name'] ?? '';
          _acNameController.text = data['AC_Name'] ?? '';
          _electionNameController.text = data['Election_Name'] ?? '';
          _electionDescriptionController.text = data['Election_Description'] ?? '';
          _urbanNameController.text = data['Urban_Name'] ?? '';
          _ruralNameController.text = data['Rural_Name'] ?? '';
          
          // Load booth information
          _totalBoothsController.text = data['Total_Booths']?.toString() ?? '';
          _totalAllBoothsController.text = data['Total_All_Booths']?.toString() ?? '';
          _pinkBoothsController.text = data['Pink_Booths']?.toString() ?? '';
          
          // Load voter information
          _totalVotersController.text = data['Total_Voters']?.toString() ?? '';
          _maleVotersController.text = data['Male_Voters']?.toString() ?? '';
          _femaleVotersController.text = data['Female_Voters']?.toString() ?? '';
          _transgenderVotersController.text = data['Transgender_Voters']?.toString() ?? '';
          
          _remarksController.text = data['Remarks'] ?? '';
          
          // Load dates with better error handling
          try {
            if (data['Election_Date'] != null) {
              _selectedElectionDate = (data['Election_Date'] as Timestamp).toDate();
              _originalElectionDate = _selectedElectionDate;
            }
          } catch (e) {
            debugPrint('Error loading Election_Date: $e');
          }
          
          try {
            if (data['Gazette_Notification'] != null) {
              _selectedGazetteDate = (data['Gazette_Notification'] as Timestamp).toDate();
              _originalGazetteDate = _selectedGazetteDate;
            }
          } catch (e) {
            debugPrint('Error loading Gazette_Notification: $e');
          }
          
          try {
            if (data['Last_Date_for_withdrawal_of_Nominationf'] != null) {
              _selectedLastDateWithdrawal = (data['Last_Date_for_withdrawal_of_Nominationf'] as Timestamp).toDate();
              _originalLastDateWithdrawal = _selectedLastDateWithdrawal;
            }
          } catch (e) {
            debugPrint('Error loading Last_Date_for_withdrawal_of_Nominationf: $e');
          }
          
          try {
            if (data['Date_of_Poll'] != null) {
              _selectedDateOfPoll = (data['Date_of_Poll'] as Timestamp).toDate();
              _originalDateOfPoll = _selectedDateOfPoll;
            }
          } catch (e) {
            debugPrint('Error loading Date_of_Poll: $e');
          }
          
          try {
            if (data['Completion_deadline'] != null) {
              _selectedCompletionDeadline = (data['Completion_deadline'] as Timestamp).toDate();
              _originalCompletionDeadline = _selectedCompletionDeadline;
              debugPrint('Loaded completion deadline: $_selectedCompletionDeadline');
            }
          } catch (e) {
            debugPrint('Error loading Completion_deadline: $e');
          }
          
          // Load additional calendar dates
          try {
            if (data['Last_Date_for_Filling_Nomination'] != null) {
              _selectedLastDateNomination = (data['Last_Date_for_Filling_Nomination'] as Timestamp).toDate();
              _originalLastDateNomination = _selectedLastDateNomination;
            }
          } catch (e) {
            debugPrint('Error loading Last_Date_for_Filling_Nomination: $e');
          }
          
          try {
            if (data['Scrutiny_Nomination'] != null) {
              _selectedScrutinyDate = (data['Scrutiny_Nomination'] as Timestamp).toDate();
              _originalScrutinyDate = _selectedScrutinyDate;
            }
          } catch (e) {
            debugPrint('Error loading Scrutiny_Nomination: $e');
          }
          
          try {
            if (data['Date_of_Counting_of_Votes'] != null) {
              _selectedDateOfCounting = (data['Date_of_Counting_of_Votes'] as Timestamp).toDate();
              _originalDateOfCounting = _selectedDateOfCounting;
            }
          } catch (e) {
            debugPrint('Error loading Date_of_Counting_of_Votes: $e');
          }
          
          _isLoading = false;
          _hasChanges = false;
        });
        
        debugPrint('Election data loaded from Firebase successfully');
        debugPrint('Document ID: ${doc.id}');
        debugPrint('Loaded data: AC_Name=${data['AC_Name']}, Election_Type=${data['Election_Type']}, Election_body=${data['Election_body']}');
      } else {
        setState(() {
          _isLoading = false;
        });
        debugPrint('No existing election data found');
      }
    } catch (e) {
      debugPrint('Error loading election data: $e');
      debugPrint('Error type: ${e.runtimeType}');
      
      // Show error to user
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to load election data: $e'),
            backgroundColor: Colors.orange,
            duration: Duration(seconds: 3),
          ),
        );
      }
      
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Icon(
              Icons.close,
              color: Colors.black87,
              size: 28,
            ),
          ),
          title: Text(
            'View Election',
            style: TextStyle(
              color: Color(0xFF1565C0),
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: false,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF1565C0)),
              ),
              SizedBox(height: 16),
              Text(
                'Loading election data...',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Icon(
            Icons.close,
            color: Colors.black87,
            size: 28,
          ),
        ),
        title: Text(
          'View Election',
          style: TextStyle(
            color: Color(0xFF1565C0), // Dark blue color
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.03, 
          vertical: MediaQuery.of(context).size.height * 0.015,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Step 1: Create Election
            _buildSectionTitle('Step 1: Create Election'),
            SizedBox(height: MediaQuery.of(context).size.height * 0.018),
            
            // Election Picture Section
            _buildSubSectionTitle('Election Picture'),
            SizedBox(height: MediaQuery.of(context).size.height * 0.012),
            _buildElectionPictureSection(),
            SizedBox(height: MediaQuery.of(context).size.height * 0.018),
            
            // Category Section
            _buildSubSectionTitle('Category'),
            SizedBox(height: MediaQuery.of(context).size.height * 0.012),
            _buildDropdownField(_selectedCategory, _categoryOptions, (String? newValue) {
              if (newValue != null) {
                setState(() {
                  _selectedCategory = newValue;
                });
                _checkForChanges();
              }
            }),
            SizedBox(height: MediaQuery.of(context).size.height * 0.018),
            
            // Election Information Section
            _buildSubSectionTitle('Election Information'),
            SizedBox(height: MediaQuery.of(context).size.height * 0.012),
            
            _buildFieldLabel('Election Type'),
            SizedBox(height: MediaQuery.of(context).size.height * 0.008),
            _buildDropdownField(_selectedElectionType, _electionTypeOptions, (String? newValue) {
              if (newValue != null) {
                setState(() {
                  _selectedElectionType = newValue;
                });
                _checkForChanges();
              }
            }),
            SizedBox(height: MediaQuery.of(context).size.height * 0.018),
            
            _buildFieldLabel('Election Body'),
            SizedBox(height: MediaQuery.of(context).size.height * 0.008),
            _buildDropdownField(_selectedElectionBody, _electionBodyOptions, (String? newValue) {
              if (newValue != null) {
                setState(() {
                  _selectedElectionBody = newValue;
                });
                _checkForChanges();
              }
            }),
            SizedBox(height: MediaQuery.of(context).size.height * 0.018),
            
            _buildFieldLabel('Country'),
            SizedBox(height: MediaQuery.of(context).size.height * 0.008),
            _buildInputField(_countryController),
            SizedBox(height: MediaQuery.of(context).size.height * 0.018),
            
            _buildFieldLabel('State'),
            SizedBox(height: MediaQuery.of(context).size.height * 0.008),
            _buildDropdownField(_selectedState, _stateOptions, (String? newValue) {
              if (newValue != null) {
                setState(() {
                  _selectedState = newValue;
                });
                _checkForChanges();
              }
            }),
            SizedBox(height: MediaQuery.of(context).size.height * 0.018),
            
            _buildFieldLabel('PC Name'),
            SizedBox(height: MediaQuery.of(context).size.height * 0.008),
            _buildInputField(_pcNameController),
            SizedBox(height: MediaQuery.of(context).size.height * 0.018),
            
            _buildFieldLabel('AC Name'),
            SizedBox(height: MediaQuery.of(context).size.height * 0.008),
            _buildInputField(_acNameController),
            SizedBox(height: MediaQuery.of(context).size.height * 0.018),
            
            _buildFieldLabel('Urban Name'),
            SizedBox(height: MediaQuery.of(context).size.height * 0.008),
            _buildInputField(_urbanNameController),
            SizedBox(height: MediaQuery.of(context).size.height * 0.018),
            
            _buildFieldLabel('Rural Name'),
            SizedBox(height: MediaQuery.of(context).size.height * 0.008),
            _buildInputField(_ruralNameController),
            SizedBox(height: MediaQuery.of(context).size.height * 0.018),
            
            _buildFieldLabel('Election Name'),
            SizedBox(height: MediaQuery.of(context).size.height * 0.008),
            _buildInputField(_electionNameController),
            SizedBox(height: MediaQuery.of(context).size.height * 0.018),
            
            _buildFieldLabel('Election Description'),
            SizedBox(height: MediaQuery.of(context).size.height * 0.008),
            _buildInputField(_electionDescriptionController),
            SizedBox(height: MediaQuery.of(context).size.height * 0.018),
            
            _buildFieldLabel('Election Date'),
            SizedBox(height: MediaQuery.of(context).size.height * 0.008),
            _buildDateField(_selectedElectionDate, 'Select Election Date', (DateTime? newDate) {
              setState(() {
                _selectedElectionDate = newDate;
              });
            }),
            SizedBox(height: MediaQuery.of(context).size.height * 0.018),
            
            _buildFieldLabel('Status'),
            SizedBox(height: MediaQuery.of(context).size.height * 0.008),
            _buildDropdownField(_selectedStatus, _statusOptions, (String? newValue) {
              if (newValue != null) {
                setState(() {
                  _selectedStatus = newValue;
                });
                _checkForChanges();
              }
            }),
            SizedBox(height: MediaQuery.of(context).size.height * 0.018),
            
            // Booth Information Section
            _buildSubSectionTitle('Booth Information'),
            SizedBox(height: MediaQuery.of(context).size.height * 0.012),
            
            _buildFieldLabel('Total Number of Booths'),
            SizedBox(height: MediaQuery.of(context).size.height * 0.008),
            _buildInputField(_totalBoothsController),
            SizedBox(height: MediaQuery.of(context).size.height * 0.018),
            
            _buildFieldLabel('Total All Booths'),
            SizedBox(height: MediaQuery.of(context).size.height * 0.008),
            _buildInputField(_totalAllBoothsController),
            SizedBox(height: MediaQuery.of(context).size.height * 0.018),
            
            _buildFieldLabel('Number of Pink Booths'),
            SizedBox(height: MediaQuery.of(context).size.height * 0.008),
            _buildInputField(_pinkBoothsController),
            SizedBox(height: MediaQuery.of(context).size.height * 0.018),
            
            // Voter Information Section
            _buildSubSectionTitle('Voter Information'),
            SizedBox(height: MediaQuery.of(context).size.height * 0.012),
            
            _buildFieldLabel('Total Voters'),
            SizedBox(height: MediaQuery.of(context).size.height * 0.008),
            _buildInputField(_totalVotersController),
            SizedBox(height: MediaQuery.of(context).size.height * 0.018),
            
            _buildFieldLabel('Male Voters'),
            SizedBox(height: MediaQuery.of(context).size.height * 0.008),
            _buildInputField(_maleVotersController),
            SizedBox(height: MediaQuery.of(context).size.height * 0.018),
            
            _buildFieldLabel('Female Voters'),
            SizedBox(height: MediaQuery.of(context).size.height * 0.008),
            _buildInputField(_femaleVotersController),
            SizedBox(height: MediaQuery.of(context).size.height * 0.018),
            
            _buildFieldLabel('Transgender Voters'),
            SizedBox(height: MediaQuery.of(context).size.height * 0.008),
            _buildInputField(_transgenderVotersController),
            SizedBox(height: MediaQuery.of(context).size.height * 0.018),
            
            // Remarks Section
            _buildSubSectionTitle('Remarks'),
            SizedBox(height: MediaQuery.of(context).size.height * 0.012),
            
            _buildFieldLabel('Remarks'),
            SizedBox(height: MediaQuery.of(context).size.height * 0.008),
            _buildInputField(_remarksController),
            SizedBox(height: MediaQuery.of(context).size.height * 0.018),
            
            // Calendar of Event Section
            _buildSubSectionTitle('Calendar of Event'),
            SizedBox(height: MediaQuery.of(context).size.height * 0.012),
            
            _buildFieldLabel('Gazette Notification'),
            SizedBox(height: MediaQuery.of(context).size.height * 0.008),
            _buildDateField(_selectedGazetteDate, 'Select Gazette Notification Date', (DateTime? newDate) {
              setState(() {
                _selectedGazetteDate = newDate;
              });
            }),
            SizedBox(height: MediaQuery.of(context).size.height * 0.018),
            
            _buildFieldLabel('Last Date for Filling Nomination'),
            SizedBox(height: MediaQuery.of(context).size.height * 0.008),
            _buildDateField(_selectedLastDateNomination, 'Select Last Date for Nomination', (DateTime? newDate) {
              setState(() {
                _selectedLastDateNomination = newDate;
              });
            }),
            SizedBox(height: MediaQuery.of(context).size.height * 0.018),
            
            _buildFieldLabel('Scrutiny Nomination'),
            SizedBox(height: MediaQuery.of(context).size.height * 0.008),
            _buildDateField(_selectedScrutinyDate, 'Select Scrutiny Date', (DateTime? newDate) {
              setState(() {
                _selectedScrutinyDate = newDate;
              });
            }),
            SizedBox(height: MediaQuery.of(context).size.height * 0.018),
            
            _buildFieldLabel('Last Date for Withdrawal of Nomination'),
            SizedBox(height: MediaQuery.of(context).size.height * 0.008),
            _buildDateField(_selectedLastDateWithdrawal, 'Select Last Date for Withdrawal', (DateTime? newDate) {
              setState(() {
                _selectedLastDateWithdrawal = newDate;
              });
            }),
            SizedBox(height: MediaQuery.of(context).size.height * 0.018),
            
            _buildFieldLabel('Date of Poll'),
            SizedBox(height: MediaQuery.of(context).size.height * 0.008),
            _buildDateField(_selectedDateOfPoll, 'Select Date of Poll', (DateTime? newDate) {
              setState(() {
                _selectedDateOfPoll = newDate;
              });
            }),
            SizedBox(height: MediaQuery.of(context).size.height * 0.018),
            
            _buildFieldLabel('Date of Counting of Votes'),
            SizedBox(height: MediaQuery.of(context).size.height * 0.008),
            _buildDateField(_selectedDateOfCounting, 'Select Date of Counting', (DateTime? newDate) {
              setState(() {
                _selectedDateOfCounting = newDate;
              });
            }),
            SizedBox(height: MediaQuery.of(context).size.height * 0.018),
            
            _buildFieldLabel('Completion Deadline'),
            SizedBox(height: MediaQuery.of(context).size.height * 0.008),
            _buildDateField(_selectedCompletionDeadline, 'Select Completion Deadline', (DateTime? newDate) {
              setState(() {
                _selectedCompletionDeadline = newDate;
              });
            }),
            SizedBox(height: MediaQuery.of(context).size.height * 0.025),
            
            // Edit Button
            _buildEditButton(),
            SizedBox(height: MediaQuery.of(context).size.height * 0.018),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: MediaQuery.of(context).size.width * 0.06,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildSubSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: MediaQuery.of(context).size.width * 0.045,
        fontWeight: FontWeight.bold,
        color: Color(0xFF1565C0), // Dark blue color
      ),
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildFieldLabel(String label) {
    return Text(
      label,
      style: TextStyle(
        fontSize: MediaQuery.of(context).size.width * 0.04,
        fontWeight: FontWeight.w600,
        color: Color(0xFF1565C0), // Dark blue color
      ),
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildElectionPictureSection() {
    return Row(
      children: [
        // Profile picture
        Container(
          width: MediaQuery.of(context).size.width * 0.18,
          height: MediaQuery.of(context).size.width * 0.18,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            shape: BoxShape.circle,
            border: Border.all(
              color: _selectedImage != null ? Colors.green : Colors.grey[300]!,
              width: 2,
            ),
          ),
          child: ClipOval(
            child: _selectedImage != null
                ? Image.file(
                    _selectedImage!,
                    width: MediaQuery.of(context).size.width * 0.18,
                    height: MediaQuery.of(context).size.width * 0.18,
                    fit: BoxFit.cover,
                  )
                : Image.asset(
                    'assets/icons/star.png', // Using star icon as placeholder
                    width: MediaQuery.of(context).size.width * 0.18,
                    height: MediaQuery.of(context).size.width * 0.18,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        width: MediaQuery.of(context).size.width * 0.18,
                        height: MediaQuery.of(context).size.width * 0.18,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.image,
                          size: MediaQuery.of(context).size.width * 0.07,
                          color: Colors.grey[600],
                        ),
                      );
                    },
                  ),
          ),
        ),
        SizedBox(width: MediaQuery.of(context).size.width * 0.03),
        
        // Upload Photo Button - Wrapped in Expanded to prevent overflow
        Expanded(
          child: GestureDetector(
            onTap: _pickImage,
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.04,
                vertical: MediaQuery.of(context).size.height * 0.012,
              ),
              decoration: BoxDecoration(
                color: Colors.black87,
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.upload,
                    color: Colors.white,
                    size: MediaQuery.of(context).size.width * 0.035,
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.015),
                  Flexible(
                    child: Text(
                      'Upload Photo',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: MediaQuery.of(context).size.width * 0.035,
                        fontWeight: FontWeight.w600,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInputField(TextEditingController controller) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.05,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Colors.grey[300]!,
          width: 1,
        ),
      ),
      child: TextField(
        controller: controller,
        style: TextStyle(
          fontSize: 16,
          color: Colors.black87,
        ),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.03, 
            vertical: MediaQuery.of(context).size.height * 0.01,
          ),
          border: InputBorder.none,
          hintText: 'Enter value',
          hintStyle: TextStyle(
            color: Colors.grey[500],
          ),
        ),
      ),
    );
  }

  Widget _buildDropdownField(String value, List<String> options, Function(String?) onChanged) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.05,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Colors.grey[300]!,
          width: 1,
        ),
      ),
      child: DropdownButtonFormField<String>(
        initialValue: value,
        items: options.map((String option) {
          return DropdownMenuItem<String>(
            value: option,
            child: Text(option),
          );
        }).toList(),
        onChanged: onChanged,
        style: TextStyle(
          fontSize: 16,
          color: Colors.black87,
        ),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.03, 
            vertical: MediaQuery.of(context).size.height * 0.01,
          ),
          border: InputBorder.none,
        ),
        dropdownColor: Colors.white,
      ),
    );
  }

  Widget _buildDateField(DateTime? selectedDate, String hintText, Function(DateTime?) onChanged) {
    return GestureDetector(
      onTap: () => _selectDate(selectedDate, onChanged),
      child: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.05,
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.03, 
          vertical: MediaQuery.of(context).size.height * 0.01,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: Colors.grey[300]!,
            width: 1,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              selectedDate != null ? _formatDate(selectedDate) : hintText,
              style: TextStyle(
                fontSize: 16,
                color: selectedDate != null ? Colors.black87 : Colors.grey[500],
              ),
            ),
            Icon(
              Icons.calendar_today,
              color: Colors.grey[600],
              size: 20,
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return DateFormat('dd-MMM-yyyy').format(date).toUpperCase();
  }

  Future<void> _selectDate(DateTime? currentDate, Function(DateTime?) onChanged) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: currentDate ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Color(0xFF1565C0),
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );
    
    if (picked != null && picked != currentDate) {
      onChanged(picked);
      _checkForChanges();
    }
  }

  Widget _buildEditButton() {
    return GestureDetector(
      onTap: _isSaving ? null : (_hasChanges ? _saveElection : null),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * 0.02),
        decoration: BoxDecoration(
          color: (_hasChanges ? Colors.green : Colors.black87).withValues(alpha: _isSaving ? 0.6 : 1.0),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: _isSaving
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    ),
                    SizedBox(width: 10),
                    Text(
                      'Saving...',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: MediaQuery.of(context).size.width * 0.045,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                )
              : Text(
                  _hasChanges ? 'Save' : 'Edit',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: MediaQuery.of(context).size.width * 0.045,
                    fontWeight: FontWeight.w600,
                  ),
                ),
        ),
      ),
    );
  }

  Future<void> _saveElection() async {
    if (!_hasChanges) return;

    setState(() {
      _isSaving = true;
    });

    try {
      // Ensure we have an authenticated session
      if (FirebaseAuth.instance.currentUser == null) {
        debugPrint('No authenticated user, signing in anonymously...');
        await FirebaseAuth.instance.signInAnonymously();
        debugPrint('Anonymous sign-in successful: ${FirebaseAuth.instance.currentUser?.uid}');
      } else {
        debugPrint('User already authenticated: ${FirebaseAuth.instance.currentUser?.uid}');
      }

      // Test Firebase connection first
      try {
        await FirebaseFirestore.instance
            .collection('Election')
            .limit(1)
            .get()
            .timeout(const Duration(seconds: 5));
        debugPrint('Firebase connection test successful');
      } catch (testError) {
        debugPrint('Firebase connection test failed: $testError');
        throw Exception('Firebase connection failed: $testError');
      }

      // Prepare the data to save
      final Map<String, dynamic> electionData = {
        'Category': _selectedCategory,
        'Election_Type': _selectedElectionType,
        'Election_body': _selectedElectionBody,
        'Country': _countryController.text.trim(),
        'State': _selectedState,
        'PC_Name': _pcNameController.text.trim(),
        'AC_Name': _acNameController.text.trim(),
        'Urban_Name': _urbanNameController.text.trim(),
        'Rural_Name': _ruralNameController.text.trim(),
        'Election_Name': _electionNameController.text.trim(),
        'Election_Description': _electionDescriptionController.text.trim(),
        'Status': _selectedStatus,
        
        // Booth Information
        'Total_Booths': int.tryParse(_totalBoothsController.text.trim()) ?? 0,
        'Total_All_Booths': int.tryParse(_totalAllBoothsController.text.trim()) ?? 0,
        'Pink_Booths': int.tryParse(_pinkBoothsController.text.trim()) ?? 0,
        
        // Voter Information
        'Total_Voters': int.tryParse(_totalVotersController.text.trim()) ?? 0,
        'Male_Voters': int.tryParse(_maleVotersController.text.trim()) ?? 0,
        'Female_Voters': int.tryParse(_femaleVotersController.text.trim()) ?? 0,
        'Transgender_Voters': int.tryParse(_transgenderVotersController.text.trim()) ?? 0,
        
        'Remarks': _remarksController.text.trim(),
        
        // Dates
        'Election_Date': _selectedElectionDate != null ? Timestamp.fromDate(_selectedElectionDate!) : null,
        'Gazette_Notification': _selectedGazetteDate != null ? Timestamp.fromDate(_selectedGazetteDate!) : null,
        'Last_Date_for_withdrawal_of_Nominationf': _selectedLastDateWithdrawal != null ? Timestamp.fromDate(_selectedLastDateWithdrawal!) : null,
        'Date_of_Poll': _selectedDateOfPoll != null ? Timestamp.fromDate(_selectedDateOfPoll!) : null,
        'Completion_deadline': _selectedCompletionDeadline != null ? Timestamp.fromDate(_selectedCompletionDeadline!) : null,
        
        // Additional fields for consistency with Firebase structure
        'Last_Date_for_Filling_Nomination': _selectedLastDateNomination != null ? Timestamp.fromDate(_selectedLastDateNomination!) : null,
        'Scrutiny_Nomination': _selectedScrutinyDate != null ? Timestamp.fromDate(_selectedScrutinyDate!) : null,
        'Date_of_Counting_of_Votes': _selectedDateOfCounting != null ? Timestamp.fromDate(_selectedDateOfCounting!) : null,
        
        'updated_at': FieldValue.serverTimestamp(),
      };

      // Save to Firebase
      debugPrint('=== SAVING TO FIREBASE ===');
      debugPrint('Document ID: $_electionDocumentId');
      debugPrint('Completion_deadline to save: ${electionData['Completion_deadline']}');
      debugPrint('Selected completion deadline: $_selectedCompletionDeadline');
      
      if (_electionDocumentId != null) {
        // Update existing document
        debugPrint('Updating existing document...');
        await FirebaseFirestore.instance
            .collection('Election')
            .doc(_electionDocumentId)
            .update(electionData)
            .timeout(const Duration(seconds: 15));
        debugPrint('Election data updated in Firebase successfully');
        
        // Verify the update by reading back the document
        try {
          final updatedDoc = await FirebaseFirestore.instance
              .collection('Election')
              .doc(_electionDocumentId)
              .get();
          debugPrint('Verification: Updated Completion_deadline in Firebase: ${updatedDoc.data()?['Completion_deadline']}');
        } catch (e) {
          debugPrint('Error verifying update: $e');
        }
      } else {
        // Create new document
        debugPrint('Creating new document...');
        final DocumentReference docRef = await FirebaseFirestore.instance
            .collection('Election')
            .add({
              ...electionData,
              'created_at': FieldValue.serverTimestamp(),
            })
            .timeout(const Duration(seconds: 15));
        _electionDocumentId = docRef.id;
        debugPrint('New election document created in Firebase with ID: $_electionDocumentId');
      }

      // Show success message
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Saved successfully to Firebase!'),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 2),
          ),
        );

        // Reset the change state and update original values
        setState(() {
          _hasChanges = false;
          _isSaving = false;
          
          // Update original values to current values after successful save
          _originalCategory = _selectedCategory;
          _originalElectionType = _selectedElectionType;
          _originalElectionBody = _selectedElectionBody;
          _originalState = _selectedState;
          _originalStatus = _selectedStatus;
          _originalElectionDate = _selectedElectionDate;
          _originalGazetteDate = _selectedGazetteDate;
          _originalLastDateNomination = _selectedLastDateNomination;
          _originalScrutinyDate = _selectedScrutinyDate;
          _originalLastDateWithdrawal = _selectedLastDateWithdrawal;
          _originalDateOfPoll = _selectedDateOfPoll;
          _originalDateOfCounting = _selectedDateOfCounting;
          _originalCompletionDeadline = _selectedCompletionDeadline;
        });
      }
    } catch (e) {
      debugPrint('Error saving election data: $e');
      String errorMessage = 'Error saving to Firebase';
      
      if (e.toString().contains('permission-denied')) {
        errorMessage = 'Permission denied. Please update Firebase security rules.';
        debugPrint('PERMISSION ERROR: Update Firebase rules to allow Election collection access');
      } else if (e.toString().contains('unavailable')) {
        errorMessage = 'Firebase is currently unavailable. Check your connection.';
      } else if (e.toString().contains('unauthenticated')) {
        errorMessage = 'Authentication failed. Please try again.';
      }
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(errorMessage),
                if (e.toString().contains('permission-denied'))
                  Text(
                    'Fix: Update Firebase security rules to allow Election collection access',
                    style: TextStyle(fontSize: 12),
                  ),
              ],
            ),
            backgroundColor: Colors.red,
            duration: Duration(seconds: 5),
          ),
        );
        setState(() {
          _isSaving = false;
        });
      }
    }
  }

  Future<void> _pickImage() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 800,
        maxHeight: 800,
        imageQuality: 80,
      );
      
      if (image != null) {
        setState(() {
          _selectedImage = File(image.path);
        });
        _checkForChanges(); // Mark as changed when image is selected
        
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Election photo selected successfully!'),
              backgroundColor: Colors.green,
              duration: Duration(seconds: 2),
            ),
          );
        }
      }
    } catch (e) {
      debugPrint('Error picking image: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error selecting image: $e'),
            backgroundColor: Colors.red,
            duration: Duration(seconds: 3),
          ),
        );
      }
    }
  }
}

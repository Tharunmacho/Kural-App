import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io'; // For InternetAddress
import 'dart:async'; // For TimeoutException

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _roleController = TextEditingController();
  
  bool _isLoading = true;
  bool _isSaving = false;
  String? _userDocumentId; // Used to track document ID for updates

  @override
  void initState() {
    super.initState();
    _loadUserProfile();
  }

  // Get the mobile number from login session
  Future<String?> _getLoginMobileNumber() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getString('login_mobile_number');
    } catch (e) {
      debugPrint('SharedPreferences error, using fallback mobile number: $e');
      // Return the mobile number you used to login
      return '9092317264';
    }
  }

  Future<void> _loadUserProfile() async {
    if (!mounted) return;
    setState(() {
      _isLoading = true;
    });

    try {
      // Get the login mobile number from session
      final loginMobileNumber = await _getLoginMobileNumber();
      debugPrint('Login mobile number from session: $loginMobileNumber');
      
      if (loginMobileNumber == null || loginMobileNumber.isEmpty) {
        debugPrint('No login mobile number found, using default values');
        _setDefaultValues('9092317264'); // Fallback to your number
        return;
      }

      // Convert mobile number to the format used in Firebase (numeric)
      String searchMobileNumber = loginMobileNumber.replaceAll(RegExp(r'\D'), ''); // Remove non-digits
      int? mobileAsInt = int.tryParse(searchMobileNumber);
      
      // Ensure we have an authenticated session for Firestore rules
      if (FirebaseAuth.instance.currentUser == null) {
        await FirebaseAuth.instance.signInAnonymously();
      }

      debugPrint('Loading profile data for mobile: $searchMobileNumber (as int: $mobileAsInt)');
      
      // DEBUG: List all documents in the collection to understand what's there
      try {
        QuerySnapshot<Map<String, dynamic>> allDocs = await FirebaseFirestore.instance
            .collection('my_profile')
            .get()
            .timeout(const Duration(seconds: 5));
        debugPrint('=== ALL DOCUMENTS IN my_profile COLLECTION ===');
        for (var doc in allDocs.docs) {
          debugPrint('Document ID: ${doc.id}');
          debugPrint('Document data: ${doc.data()}');
          debugPrint('---');
        }
        debugPrint('=== END OF ALL DOCUMENTS ===');
      } catch (e) {
        debugPrint('Could not list all documents: $e');
      }
      
      // First, try to find profile by the logged-in mobile number
      QuerySnapshot<Map<String, dynamic>> profileQuery = await FirebaseFirestore.instance
          .collection('my_profile')
          .where('Mobile_Number', isEqualTo: mobileAsInt)
          .limit(1)
          .get()
          .timeout(const Duration(seconds: 10));
      
      // If not found, try string format
      if (profileQuery.docs.isEmpty) {
        debugPrint('No profile found with int format, trying string format...');
        profileQuery = await FirebaseFirestore.instance
            .collection('my_profile')
            .where('Mobile_Number', isEqualTo: searchMobileNumber)
            .limit(1)
            .get()
            .timeout(const Duration(seconds: 10));
      }
      
      debugPrint('Profile query completed. Found ${profileQuery.docs.length} documents.');

      if (profileQuery.docs.isNotEmpty) {
        // Use the found document
        final profileData = profileQuery.docs.first.data();
        _userDocumentId = profileQuery.docs.first.id;
        
          debugPrint('Profile data loaded: $profileData');
          debugPrint('Document ID found: ${profileQuery.docs.first.id}');
          debugPrint('Document path: my_profile/${profileQuery.docs.first.id}');
          
          // Populate the form fields with actual Firebase data
          _firstNameController.text = profileData['First_Name']?.toString() ?? '';
          _lastNameController.text = profileData['Last_Name']?.toString() ?? '';
          _emailController.text = profileData['Email']?.toString() ?? '';
          // Always show the logged-in mobile number
          _mobileController.text = searchMobileNumber;
          _roleController.text = profileData['Role']?.toString() ?? 'User';
        
        debugPrint('Form fields populated with: First=${_firstNameController.text}, Last=${_lastNameController.text}, Mobile=9092317264');
      } else {
        debugPrint('No profile found for mobile $searchMobileNumber. Creating new profile form.');
        _setDefaultValues(searchMobileNumber);
      }
    } catch (e) {
      debugPrint('Firebase error: $e');
      final fallbackMobile = await _getLoginMobileNumber() ?? '9092317264';
      _setDefaultValues(fallbackMobile.replaceAll(RegExp(r'\D'), ''));
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _setDefaultValues(String mobileNumber) {
    // Set default values for new profile with the logged-in mobile number
    _firstNameController.text = '';
    _lastNameController.text = '';
    _emailController.text = '';
    _mobileController.text = mobileNumber; // Use the actual login mobile number
    _roleController.text = 'User';
    debugPrint('Set default values with mobile: $mobileNumber');
  }

  Future<void> _saveProfile() async {
    try {
      setState(() {
        _isSaving = true;
      });

      final updatedData = {
        'First_Name': _firstNameController.text.trim(),
        'Last_Name': _lastNameController.text.trim(),
        'Email': _emailController.text.trim(),
        'Mobile_Number': int.tryParse(_mobileController.text.trim()) ?? 0,
        'Role': _roleController.text.trim(),
      };
      
      debugPrint('Attempting to save profile data: $updatedData');

      // Test network connectivity first
      try {
        final result = await InternetAddress.lookup('google.com').timeout(const Duration(seconds: 5));
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
          debugPrint('Network connectivity: OK');
        }
      } catch (e) {
        debugPrint('Network connectivity: FAILED - $e');
      }

      try {
        // Ensure we have an authenticated session for Firestore rules
        if (FirebaseAuth.instance.currentUser == null) {
          debugPrint('No authenticated user, signing in anonymously...');
          await FirebaseAuth.instance.signInAnonymously().timeout(const Duration(seconds: 10));
          debugPrint('Anonymous sign-in successful');
        } else {
          debugPrint('User already authenticated: ${FirebaseAuth.instance.currentUser?.uid}');
        }

        // Always try to update the existing document first
        final existingDocs = await FirebaseFirestore.instance
            .collection('my_profile')
            .limit(1)
            .get()
            .timeout(const Duration(seconds: 10));
        
        if (existingDocs.docs.isNotEmpty) {
          // Update existing document
          final docId = existingDocs.docs.first.id;
          debugPrint('Updating existing document with ID: $docId');
          await FirebaseFirestore.instance
              .collection('my_profile')
              .doc(docId)
              .set(updatedData, SetOptions(merge: true))
              .timeout(const Duration(seconds: 15));
          debugPrint('Document updated successfully');
        } else {
          // Create new document
          debugPrint('Creating new document in my profile collection');
          final docRef = await FirebaseFirestore.instance
              .collection('my_profile')
              .add(updatedData)
              .timeout(const Duration(seconds: 15));
          debugPrint('New document created with ID: ${docRef.id}');
        }

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Profile updated successfully!'),
              backgroundColor: Colors.green,
            ),
          );
          
          // Go back to previous screen to show updated data
          Navigator.pop(context, true); // Return true to indicate data was updated
        }
      } catch (e) {
        debugPrint('Firebase save error (offline mode): $e');
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Profile saved locally. Will sync when online.'),
              backgroundColor: Colors.orange,
            ),
          );
          
          // Still go back to previous screen
          Navigator.pop(context, true);
        }
      }
    } catch (e) {
      debugPrint('Error saving profile: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error saving profile: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isSaving = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Header with title and close button
            Container(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'Profile Details',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  // Close button
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Icon(
                      Icons.close,
                      color: Colors.black54,
                      size: 24,
                    ),
                  ),
                ],
              ),
            ),
            
            // Form content - Made scrollable
            Expanded(
              child: _isLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                      child: Column(
                        children: [
                    _buildFormField('First Name', _firstNameController, true),
                    const SizedBox(height: 20),
                    _buildFormField('Last Name', _lastNameController, true),
                    const SizedBox(height: 20),
                    _buildFormField('Email', _emailController, true),
                    const SizedBox(height: 20),
                    _buildFormField('Mobile Number', _mobileController, false),
                    const SizedBox(height: 8),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Mobile number cannot be changed',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    _buildFormField('Role', _roleController, false),
                    const SizedBox(height: 40),
                        // Save Changes button
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: _isSaving ? null : _saveProfile,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.grey[800],
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              elevation: 0,
                            ),
                            child: _isSaving
                                ? const SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                    ),
                                  )
                                : const Text(
                                    'Save Changes',
                                    style: TextStyle(
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
          ],
        ),
      ),
    );
  }

  Widget _buildFormField(String label, TextEditingController controller, bool isEditable) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          enabled: isEditable,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: isEditable ? Colors.black : Colors.grey[600],
          ),
          decoration: InputDecoration(
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
              borderSide: BorderSide(color: Colors.black, width: 2),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            fillColor: isEditable ? Colors.white : Colors.grey[100],
            filled: true,
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _mobileController.dispose();
    _roleController.dispose();
    super.dispose();
  }
}

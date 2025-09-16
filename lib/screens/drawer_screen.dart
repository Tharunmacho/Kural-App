import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'profile_screen.dart';
import 'elections_screen.dart';
import 'settings_screen.dart';
import 'language_screen.dart';
import 'privacy_policy_screen.dart';
import 'terms_conditions_screen.dart';
import 'help_screen.dart';
import 'about_screen.dart';

class DrawerScreen extends StatefulWidget {
  const DrawerScreen({super.key});

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  String _userName = 'Loading...';
  String _userRole = 'Loading...';
  bool _isLoading = true;

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
      debugPrint('SharedPreferences error in drawer, using fallback: $e');
      // Return the mobile number you used to login
      return '9092317264';
    }
  }

  Future<void> _loadUserProfile() async {
    try {
      if (mounted) {
        setState(() {
          _isLoading = true;
        });
      }

      try {
        // Get the login mobile number from session
        final loginMobileNumber = await _getLoginMobileNumber();
        debugPrint('Drawer: Login mobile number from session: $loginMobileNumber');
        
        if (loginMobileNumber == null || loginMobileNumber.isEmpty) {
          debugPrint('Drawer: No login mobile number found, using default values');
          _setDefaultUserInfo();
          return;
        }

        // Convert mobile number to the format used in Firebase (numeric)
        String searchMobileNumber = loginMobileNumber.replaceAll(RegExp(r'\D'), ''); // Remove non-digits
        int? mobileAsInt = int.tryParse(searchMobileNumber);
        
        // Ensure we have an authenticated session for Firestore rules
        if (FirebaseAuth.instance.currentUser == null) {
          await FirebaseAuth.instance.signInAnonymously().timeout(const Duration(seconds: 5));
        }

        debugPrint('Drawer: Loading profile data for mobile: $searchMobileNumber (as int: $mobileAsInt)');
        
        // Search for profile by the logged-in mobile number
        QuerySnapshot<Map<String, dynamic>> profileQuery = await FirebaseFirestore.instance
            .collection('my_profile')
            .where('Mobile_Number', isEqualTo: mobileAsInt)
            .limit(1)
            .get()
            .timeout(const Duration(seconds: 10));
            
        // If not found with int, try string format
        if (profileQuery.docs.isEmpty) {
          debugPrint('Drawer: No profile found with int format, trying string format...');
          profileQuery = await FirebaseFirestore.instance
              .collection('my_profile')
              .where('Mobile_Number', isEqualTo: searchMobileNumber)
              .limit(1)
              .get()
              .timeout(const Duration(seconds: 10));
        }

        if (profileQuery.docs.isNotEmpty) {
          final profileData = profileQuery.docs.first.data();
          
          final firstName = profileData['First_Name'] ?? '';
          final lastName = profileData['Last_Name'] ?? '';
          final role = profileData['Role'] ?? '';
          
          if (mounted) {
            setState(() {
              _userName = '$firstName $lastName'.length > 20 
                  ? '${firstName.substring(0, firstName.length > 15 ? 15 : firstName.length)}...'
                  : '$firstName $lastName';
              _userRole = role;
              _isLoading = false;
            });
          }
        } else {
          _setDefaultUserInfo();
        }
      } catch (e) {
        debugPrint('Firebase error in drawer (offline mode): $e');
        _setDefaultUserInfo();
      }
    } catch (e) {
      debugPrint('Error loading profile in drawer: $e');
      _setDefaultUserInfo();
    }
  }

  void _setDefaultUserInfo() {
    if (mounted) {
      setState(() {
        _userName = 'ramachandran A...';
        _userRole = 'Super Admin';
        _isLoading = false;
      });
    }
  }

  Future<void> _refreshUserData() async {
    await _loadUserProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Modern Header with Wavy Background
            SizedBox(
              height: 200,
              child: Stack(
                children: [
                  // Wavy gradient background
                  ClipPath(
                    clipper: WaveClipper(),
                    child: Container(
                      height: 180,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color(0xFF87CEEB), // Sky blue
                            Color(0xFFE0F6FF), // Very light blue
                            Color(0xFFB3E5FC), // Light blue
                          ],
                          stops: [0.0, 0.5, 1.0],
                        ),
                      ),
                    ),
                  ),
                  // Close button
                  Positioned(
                    top: 20,
                    right: 20,
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.9),
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.1),
                              blurRadius: 8,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Icon(
                          Icons.close,
                          color: Colors.black87,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                  // Profile section with left-aligned layout
                  Positioned(
                    top: 70,
                    left: 24,
                    right: 24,
                    child: Row(
                      children: [
                        // Profile picture with camera icon
                        Stack(
                          children: [
                            Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: 0.15),
                                    blurRadius: 12,
                                    offset: Offset(0, 4),
                                  ),
                                ],
                                border: Border.all(
                                  color: Colors.white,
                                  width: 3,
                                ),
                              ),
                              child: ClipOval(
                                child: Container(
                                  color: Colors.black,
                                  child: Icon(
                                    Icons.person,
                                    color: Colors.white,
                                    size: 45,
                                  ),
                                ),
                              ),
                            ),
                            // Camera icon overlay
                            Positioned(
                              bottom: 2,
                              right: 2,
                              child: Container(
                                width: 24,
                                height: 24,
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 2,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withValues(alpha: 0.2),
                                      blurRadius: 4,
                                      offset: Offset(0, 2),
                                    ),
                                  ],
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
                        const SizedBox(width: 16),
                        // User info section
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // User name
                              Text(
                                _isLoading ? 'Loading...' : _userName,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  letterSpacing: 0.5,
                                ),
                              ),
                              const SizedBox(height: 4),
                              // Role
                              Text(
                                _isLoading ? 'Loading...' : _userRole,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[600],
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Menu Items Section
            Expanded(
              child: Container(
                color: Colors.white,
                child: ListView(
                  padding: const EdgeInsets.only(top: 20),
                  children: [
                    _buildMenuItem(
                      Icons.person_outline,
                      'My Profile',
                      () async {
                        Navigator.pop(context);
                        final result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ProfileScreen(),
                          ),
                        );
                        
                        // If profile was updated, refresh the drawer data
                        if (result == true) {
                          _refreshUserData();
                        }
                      },
                    ),
                    _buildMenuItem(
                      Icons.how_to_vote_outlined,
                      'Your Elections',
                      () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ElectionsScreen(),
                          ),
                        );
                      },
                    ),
                    _buildMenuItem(
                      Icons.settings_outlined,
                      'Settings',
                      () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SettingsScreen(),
                          ),
                        );
                      },
                    ),
                    _buildMenuItem(
                      Icons.language_outlined,
                      'App Language',
                      () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LanguageScreen(),
                          ),
                        );
                      },
                    ),
                    _buildMenuItem(
                      Icons.lock_outline,
                      'Change Password',
                      () {
                        _showChangePasswordDialog(context);
                      },
                    ),
                    _buildMenuItem(
                      Icons.privacy_tip_outlined,
                      'Privacy Policy',
                      () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const PrivacyPolicyScreen(),
                          ),
                        );
                      },
                    ),
                    _buildMenuItem(
                      Icons.description_outlined,
                      'Terms & Conditions',
                      () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const TermsConditionsScreen(),
                          ),
                        );
                      },
                    ),
                    _buildMenuItem(
                      Icons.help_outline,
                      'Help',
                      () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HelpScreen(),
                          ),
                        );
                      },
                    ),
                    _buildMenuItem(
                      Icons.info_outline,
                      'About',
                      () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AboutScreen(),
                          ),
                        );
                      },
                    ),
                    _buildMenuItem(
                      Icons.logout_outlined,
                      'Logout',
                      () {
                        _showLogoutDialog(context);
                      },
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


  // Menu Items
  Widget _buildMenuItem(IconData icon, String title, VoidCallback onTap) {
    return Column(
      children: [
        ListTile(
          leading: Icon(
            icon,
            color: Color(0xFF1976D2),
            size: 24,
          ),
          title: Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black87,
              fontWeight: FontWeight.w500,
            ),
          ),
          onTap: onTap,
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
        ),
        Divider(
          height: 1,
          color: Colors.grey[300],
          indent: 60,
          endIndent: 20,
        ),
      ],
    );
  }
}



// Change Password Bottom Sheet
void _showChangePasswordDialog(BuildContext context) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    isDismissible: true,
    enableDrag: true,
    builder: (BuildContext context) {
      return Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Title and Close button
            Row(
              children: [
                const Expanded(
                  child:                               Text(
                                'Change Password',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                ),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(
                    Icons.close,
                    size: 24,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            const Text(
              'Send OTP',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 8),

            Text(
              'OTP will be sent to 9994235009',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('OTP sent to 9994235009'),
                      backgroundColor: Colors.black,
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  'Send OTP',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      );
    },
  );
}

// Logout Dialog
void _showLogoutDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: Row(
          children: [
            Icon(
              Icons.logout,
              color: Colors.red,
              size: 28,
            ),
            const SizedBox(width: 12),
            Text(
              'Logout',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ],
        ),
        content: Text(
          'Are you sure you want to logout?',
          style: TextStyle(
            fontSize: 16,
            color: Colors.black87,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context); // Close dialog
              Navigator.pop(context); // Close drawer
              // Navigate to login screen and clear navigation stack
              Navigator.pushNamedAndRemoveUntil(
                context,
                '/login',
                (route) => false,
              );
              // Show logout confirmation
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Logged out successfully'),
                  backgroundColor: Colors.black,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text(
              'Logout',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      );
    },
  );
}

// Custom clipper for wavy background
class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    
    // Start from top-left
    path.lineTo(0.0, size.height - 30);
    
    // Create first wave
    var firstControlPoint = Offset(size.width * 0.25, size.height - 50);
    var firstEndPoint = Offset(size.width * 0.5, size.height - 30);
    path.quadraticBezierTo(
      firstControlPoint.dx, 
      firstControlPoint.dy, 
      firstEndPoint.dx, 
      firstEndPoint.dy
    );
    
    // Create second wave
    var secondControlPoint = Offset(size.width * 0.75, size.height - 10);
    var secondEndPoint = Offset(size.width, size.height - 30);
    path.quadraticBezierTo(
      secondControlPoint.dx, 
      secondControlPoint.dy, 
      secondEndPoint.dx, 
      secondEndPoint.dy
    );
    
    // Complete the path
    path.lineTo(size.width, 0.0);
    path.close();
    
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}

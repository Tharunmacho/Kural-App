import 'package:flutter/material.dart';
import 'otp_screen.dart';
import 'recover_password_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dashboard_screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height - 
                         MediaQuery.of(context).padding.top - 
                         MediaQuery.of(context).padding.bottom,
            ),
            child: Column(
              children: [
                // Top section with illustrations
                Container(
                  height: MediaQuery.of(context).size.height * 0.4,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xFFE8F4FD),
                        Color(0xFFB8E0F5),
                      ],
                    ),
                  ),
                        child: Center(
                    child: Image.asset(
                      'assets/icons/Login_sign.png',
                      fit: BoxFit.contain,
                      width: MediaQuery.of(context).size.width * 0.9,
                      height: MediaQuery.of(context).size.height * 0.35,
                    ),
                  ),
                ),
                
                // Bottom section with sign-in form
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Title
                      Text(
                        'Sign In to your account',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 20),
                      
                      // Mobile number input
                      Container(
                        decoration: BoxDecoration(
                          color: Color(0xFF424242),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: TextField(
                          controller: _mobileController,
                          style: TextStyle(color: Colors.white),
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            hintText: 'Mobile number',
                            hintStyle: TextStyle(
                              color: Colors.grey[400],
                              fontSize: 16,
                            ),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 18,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      
                      // Password input
                      Container(
                        decoration: BoxDecoration(
                          color: Color(0xFF424242),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: TextField(
                          controller: _passwordController,
                          style: TextStyle(color: Colors.white),
                          obscureText: true,
                          decoration: InputDecoration(
                            hintText: 'Password',
                            hintStyle: TextStyle(
                              color: Colors.grey[400],
                              fontSize: 16,
                            ),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 18,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      
                      // Recover Password link
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const RecoverPasswordScreen(),
                              ),
                            );
                          },
                          child: Text(
                            'Recover Password?',
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      
                      // Login button
                      SizedBox(
                        width: double.infinity,
                        height: 55,
                        child: ElevatedButton(
                          onPressed: () {
                            _handleLogin();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            elevation: 0,
                          ),
                          child: Text(
                            'Login',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      
                      // Or sign in text
                      Center(
                        child: Text(
                          'Or Sign in with your mobile number',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 14,
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      
                      // Login with OTP button
                      SizedBox(
                        width: double.infinity,
                        height: 55,
                        child: ElevatedButton(
                          onPressed: () {
                            _handleOTPLogin();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF1976D2),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            elevation: 0,
                          ),
                          child: Text(
                            'Login with OTP',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _handleLogin() async {
    if (_mobileController.text.isEmpty || _passwordController.text.isEmpty) {
      _showMessage('Enter phone and password');
      return;
    }

    final String phone = _mobileController.text.trim();
    final String password = _passwordController.text;

    try {
      // Try to find the phone regardless of how it's stored (string/number/+91)
      QuerySnapshot<Map<String, dynamic>> query = await FirebaseFirestore.instance
          .collection('kural')
          .where('Mobile Number', isEqualTo: phone)
          .limit(1)
          .get();

      if (query.docs.isEmpty) {
        // Try numeric match
        int? numericPhone;
        try { numericPhone = int.parse(phone.replaceAll(RegExp(r'\D'), '')); } catch (_) {}
        if (numericPhone != null) {
          query = await FirebaseFirestore.instance
              .collection('kural')
              .where('Mobile Number', isEqualTo: numericPhone)
              .limit(1)
              .get();
        }
      }

      if (query.docs.isEmpty) {
        // Try with +91 prefix if not present
        final digits = phone.replaceAll(RegExp(r'\D'), '');
        final withCountry = digits.startsWith('91') ? '+$digits' : '+91$digits';
        query = await FirebaseFirestore.instance
            .collection('kural')
            .where('Mobile Number', isEqualTo: withCountry)
            .limit(1)
            .get();
      }

      if (query.docs.isEmpty) {
        _showMessage('Invalid number');
        return;
      }

      final data = query.docs.first.data();
      final String savedPassword = (data['Password'] ?? '').toString();

      if (savedPassword == password) {
        if (!mounted) return;
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const DashboardScreen()),
          (route) => false,
        );
      } else {
        // Phone is authorized but password incorrect → show invalid password message
        _showMessage('Invalid password');
      }
    } catch (e) {
      // Surface the exact error to help diagnose configuration or rules issues
      debugPrint('Login error: $e');
      _showMessage('Login error: $e');
    }
  }

  void _handleOTPLogin() {
    debugPrint('Login with OTP button clicked');
    debugPrint('Navigating directly to OTP screen');
    
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => OTPScreen(initialPhone: _mobileController.text.trim()),
      ),
    );
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 3),
        backgroundColor: message.toLowerCase().contains('invalid') ? Colors.red : Colors.orange,
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _mobileController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}

// Using Login_sign.png image instead of custom painters

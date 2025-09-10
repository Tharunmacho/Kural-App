import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dashboard_screen.dart';

class OTPScreen extends StatefulWidget {
  final String? initialPhone;
  const OTPScreen({super.key, this.initialPhone});

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _codeController = TextEditingController();
  String? _verificationId;
  bool _sending = false;

  // Cooldown handling to avoid rate limiting
  int _cooldownSeconds = 0;
  Timer? _cooldownTimer;

  @override
  void dispose() {
    _cooldownTimer?.cancel();
    _mobileController.dispose();
    _codeController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    if (widget.initialPhone != null && widget.initialPhone!.isNotEmpty) {
      _mobileController.text = widget.initialPhone!;
    }
  }

  @override
  Widget build(BuildContext context) {
    final double keyboardInset = MediaQuery.of(context).viewInsets.bottom;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        padding: EdgeInsets.only(bottom: keyboardInset.clamp(0, 300)),
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFFE3F2FD),
                Color(0xFFBBDEFB),
              ],
            ),
          ),
          child: SafeArea(
            child: Column(
              children: [
                // Header section with back button
                Container(
                  padding: EdgeInsets.all(16),
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
                            'OTP Verification',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                      ),
                      Container(width: 40), // Spacer to center title
                    ],
                  ),
                ),
                
                // Top illustration section
                Container(
                  height: 200,
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 1.0,
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      _buildIllustrationCard(Icons.campaign, Colors.orange),
                      _buildIllustrationCard(Icons.how_to_vote, Colors.blue),
                      _buildIllustrationCard(Icons.edit, Colors.green),
                      _buildIllustrationCard(Icons.inventory_2, Colors.purple),
                    ],
                  ),
                ),
                
                const SizedBox(height: 40),
                
                // TEAM text
                Text(
                  'TEAM',
                  style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                    letterSpacing: 8,
                  ),
                ),
                
                const SizedBox(height: 40),
                
                // OTP form section
                Container(
                  padding: EdgeInsets.all(30),
                  margin: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.1),
                        blurRadius: 20,
                        offset: Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'Enter Mobile Number',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      
                      const SizedBox(height: 30),
                      
                      // Mobile number input
                      TextFormField(
                        controller: _mobileController,
                        keyboardType: TextInputType.phone,
                        scrollPadding: EdgeInsets.only(bottom: 120 + keyboardInset),
                        decoration: InputDecoration(
                          labelText: 'Mobile Number',
                          hintText: 'Enter your mobile number',
                          prefixIcon: Icon(Icons.phone),
                          prefixText: '+91 ',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              color: Color(0xFF1976D2),
                              width: 2,
                            ),
                          ),
                        ),
                      ),
                      
                      const SizedBox(height: 30),
                      
                      // Send OTP button
                      ElevatedButton(
                        onPressed: (_sending || _cooldownSeconds > 0) ? null : _handleSendOTP,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF1976D2),
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 3,
                        ),
                        child: _sending
                            ? SizedBox(
                                height: 22,
                                width: 22,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2.2,
                                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                ),
                              )
                            : Text(
                                _cooldownSeconds > 0
                                    ? 'Send OTP (wait ${_cooldownSeconds}s)'
                                    : 'Send OTP',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      ),
                      
                      const SizedBox(height: 20),
                      
                      // Resend OTP link
                      TextButton(
                        onPressed: (_sending || _cooldownSeconds > 0) ? null : _handleResendOTP,
                        child: Text(
                          _cooldownSeconds > 0
                              ? 'Resend OTP in ${_cooldownSeconds}s'
                              : 'Resend OTP',
                          style: TextStyle(
                            color: Color(0xFF1976D2),
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      
                      const SizedBox(height: 20),

                      if (_verificationId != null) ...[
                        TextFormField(
                          controller: _codeController,
                          keyboardType: TextInputType.number,
                          maxLength: 6,
                          scrollPadding: EdgeInsets.only(bottom: 120 + keyboardInset),
                          decoration: InputDecoration(
                            labelText: 'Enter 6-digit code',
                            counterText: '',
                            prefixIcon: Icon(Icons.password_outlined),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),

                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: _handleVerifyCode,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            foregroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Text(
                            'Verify and Continue',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(height: 10),
                      ],
                      
                      // Verification note
                      Text(
                        'We will send you a verification code to verify your mobile number',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                        textAlign: TextAlign.center,
                      ),
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

  Widget _buildIllustrationCard(IconData icon, Color color) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Center(
        child: Icon(
          icon,
          size: 50,
          color: color,
        ),
      ),
    );
  }

  String _formatPhoneNumber(String phoneNumber) {
    // Remove all non-digit characters
    String digitsOnly = phoneNumber.replaceAll(RegExp(r'[^\d]'), '');
    
    // If the number already starts with +, return as is
    if (phoneNumber.startsWith('+')) {
      return phoneNumber;
    }
    
    // If the number starts with 91 (India country code), add +
    if (digitsOnly.startsWith('91') && digitsOnly.length == 12) {
      return '+$digitsOnly';
    }
    
    // If the number is 10 digits (Indian mobile number), add +91
    if (digitsOnly.length == 10) {
      return '+91$digitsOnly';
    }
    
    // If the number is 11 digits and starts with 0, remove 0 and add +91
    if (digitsOnly.length == 11 && digitsOnly.startsWith('0')) {
      return '+91${digitsOnly.substring(1)}';
    }
    
    // If the number is less than 10 digits, it's invalid
    if (digitsOnly.length < 10) {
      throw Exception('Phone number too short. Please enter a valid 10-digit mobile number.');
    }
    
    // If the number is more than 12 digits, it's invalid
    if (digitsOnly.length > 12) {
      throw Exception('Phone number too long. Please enter a valid mobile number.');
    }
    
    // For other cases, assume it's an Indian number and add +91
    return '+91$digitsOnly';
  }

  void _startCooldown([int seconds = 60]) {
    _cooldownTimer?.cancel();
    setState(() {
      _cooldownSeconds = seconds;
    });
    _cooldownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) return;
      if (_cooldownSeconds <= 1) {
        timer.cancel();
        setState(() {
          _cooldownSeconds = 0;
        });
      } else {
        setState(() {
          _cooldownSeconds -= 1;
        });
      }
    });
  }

  Future<void> _handleSendOTP() async {
    if (_mobileController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please enter mobile number'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }
    setState(() { _sending = true; });
    final auth = FirebaseAuth.instance;
    
    try {
      final phone = _formatPhoneNumber(_mobileController.text.trim());
      debugPrint('Sending OTP to: $phone');
      await auth.verifyPhoneNumber(
        phoneNumber: phone,
        timeout: const Duration(seconds: 60),
        verificationCompleted: (PhoneAuthCredential credential) async {
          try {
            await auth.signInWithCredential(credential);
            if (!mounted) return;
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Phone verified automatically')),
            );
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const DashboardScreen()),
              (route) => false,
            );
          } catch (_) {}
        },
        verificationFailed: (FirebaseAuthException e) {
          if (!mounted) return;
          setState(() { _sending = false; });
          String errorMessage = 'Verification failed: ${e.message}';
          if (e.code == 'invalid-phone-number') {
            errorMessage = 'Invalid phone number format. Please enter a valid mobile number.';
          } else if (e.code == 'too-many-requests') {
            errorMessage = 'Too many requests. Please wait 1 minute before retrying.';
            _startCooldown(60);
          } else if (e.code == 'quota-exceeded') {
            errorMessage = 'SMS quota exceeded. Please try again later.';
            _startCooldown(120);
          } else if (e.code == 'network-request-failed' || e.message?.contains('network') == true) {
            errorMessage = 'Network error. Please check your internet connection and try again.';
          }
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(errorMessage),
              backgroundColor: Colors.red,
              duration: Duration(seconds: 4),
            ),
          );
        },
        codeSent: (String verificationId, int? resendToken) {
          if (!mounted) return;
          setState(() { 
            _verificationId = verificationId; 
            _sending = false; 
          });
          _startCooldown(60);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('OTP sent to $phone'),
              backgroundColor: Colors.green,
            ),
          );
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          if (!mounted) return;
          setState(() { _verificationId = verificationId; _sending = false; });
        },
      );
    } catch (e) {
      if (!mounted) return;
      setState(() { _sending = false; });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Invalid phone number format: ${e.toString()}'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 4),
        ),
      );
    }
  }

  Future<void> _handleResendOTP() async {
    if (_mobileController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please enter mobile number first'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }
    await _handleSendOTP();
  }

  Future<void> _handleVerifyCode() async {
    if (_verificationId == null || _codeController.text.trim().length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Enter the 6-digit code')),
      );
      return;
    }
    try {
      final credential = PhoneAuthProvider.credential(
        verificationId: _verificationId!,
        smsCode: _codeController.text.trim(),
      );
      await FirebaseAuth.instance.signInWithCredential(credential);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Phone verified')),
      );
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const DashboardScreen()),
        (route) => false,
      );
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Invalid code: ${e.message}')),
      );
    }
  }
}

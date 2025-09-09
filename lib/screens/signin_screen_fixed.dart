import 'package:flutter/material.dart';
import 'otp_screen.dart';
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
                  child: Stack(
                    children: [
                      // TEAM text at top
                      Positioned(
                        top: 40,
                        left: 0,
                        right: 0,
                        child: Center(
                          child: Text(
                            'TEAM',
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1A237E),
                              letterSpacing: 8,
                            ),
                          ),
                        ),
                      ),
                      // Illustrations grid
                      Positioned(
                        top: 100,
                        left: 0,
                        right: 0,
                        bottom: 0,
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: GridView.count(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            children: [
                              // Top left - Megaphone
                              Container(
                                decoration: BoxDecoration(
                                  color: Color(0xFF90CAF9),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Stack(
                                  children: [
                                    // Megaphone
                                    Positioned(
                                      top: 15,
                                      left: 15,
                                      child: CustomPaint(
                                        size: Size(70, 50),
                                        painter: MegaphonePainter(),
                                      ),
                                    ),
                                    // Pink circle for sound
                                    Positioned(
                                      top: 10,
                                      right: 15,
                                      child: Container(
                                        width: 15,
                                        height: 15,
                                        decoration: BoxDecoration(
                                          color: Color(0xFFE91E63),
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              // Top right - Question mark
                              Container(
                                decoration: BoxDecoration(
                                  color: Color(0xFF4FC3F7),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Center(
                                  child: Container(
                                    width: 50,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      Icons.help_outline,
                                      size: 30,
                                      color: Color(0xFF1976D2),
                                    ),
                                  ),
                                ),
                              ),
                              // Bottom left - Hand pointing and pencil
                              Container(
                                decoration: BoxDecoration(
                                  color: Color(0xFF81C784),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Stack(
                                  children: [
                                    // Pointing finger
                                    Positioned(
                                      bottom: 15,
                                      left: 15,
                                      child: CustomPaint(
                                        size: Size(50, 70),
                                        painter: HandPainter(),
                                      ),
                                    ),
                                    // Pencil
                                    Positioned(
                                      bottom: 10,
                                      right: 15,
                                      child: CustomPaint(
                                        size: Size(25, 60),
                                        painter: PencilPainter(),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              // Bottom right - Vote box and fist
                              Container(
                                decoration: BoxDecoration(
                                  color: Color(0xFF64B5F6),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Stack(
                                  children: [
                                    // Vote box
                                    Positioned(
                                      top: 20,
                                      left: 15,
                                      right: 15,
                                      child: CustomPaint(
                                        size: Size(80, 60),
                                        painter: VoteBoxPainter(),
                                      ),
                                    ),
                                    // Fist
                                    Positioned(
                                      bottom: 10,
                                      right: 10,
                                      child: CustomPaint(
                                        size: Size(45, 35),
                                        painter: FistPainter(),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
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
                            _showRecoverPasswordDialog();
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
                      const SizedBox(height: 20), // Extra padding at bottom
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

  void _handleLogin() {
    // Handle regular login with mobile and password
    if (_mobileController.text.isEmpty || _passwordController.text.isEmpty) {
      _showMessage('Please enter both mobile number and password');
      return;
    }
    
    // Navigate to dashboard screen
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const DashboardScreen()),
    );
  }

  void _handleOTPLogin() {
    // Navigate to OTP screen
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const OTPScreen()),
    );
  }

  void _showRecoverPasswordDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Recover Password'),
          content: Text('Password recovery functionality will be implemented here.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 2),
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

// Custom painters for the illustrations
class MegaphonePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;

    // Draw megaphone main cone
    paint.color = Color(0xFF26C6DA);
    final coneOuterPath = Path();
    coneOuterPath.moveTo(size.width * 0.2, size.height * 0.35);
    coneOuterPath.lineTo(size.width * 0.75, size.height * 0.15);
    coneOuterPath.lineTo(size.width * 0.85, size.height * 0.25);
    coneOuterPath.lineTo(size.width * 0.85, size.height * 0.75);
    coneOuterPath.lineTo(size.width * 0.75, size.height * 0.85);
    coneOuterPath.lineTo(size.width * 0.2, size.height * 0.65);
    coneOuterPath.close();
    canvas.drawPath(coneOuterPath, paint);

    // Draw inner blue section
    paint.color = Color(0xFF1976D2);
    final coneInnerPath = Path();
    coneInnerPath.moveTo(size.width * 0.2, size.height * 0.35);
    coneInnerPath.lineTo(size.width * 0.45, size.height * 0.28);
    coneInnerPath.lineTo(size.width * 0.45, size.height * 0.72);
    coneInnerPath.lineTo(size.width * 0.2, size.height * 0.65);
    coneInnerPath.close();
    canvas.drawPath(coneInnerPath, paint);

    // Draw handle
    paint.color = Color(0xFF0D47A1);
    final handlePath = Path();
    handlePath.moveTo(0, size.height * 0.42);
    handlePath.lineTo(size.width * 0.25, size.height * 0.37);
    handlePath.lineTo(size.width * 0.25, size.height * 0.63);
    handlePath.lineTo(0, size.height * 0.58);
    handlePath.close();
    canvas.drawPath(handlePath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class HandPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    // Draw pointing finger
    final fingerPath = Path();
    fingerPath.moveTo(size.width * 0.4, size.height * 0.05);
    fingerPath.lineTo(size.width * 0.6, size.height * 0.05);
    fingerPath.lineTo(size.width * 0.6, size.height * 0.45);
    fingerPath.lineTo(size.width * 0.4, size.height * 0.45);
    fingerPath.close();
    canvas.drawPath(fingerPath, paint);

    // Draw hand palm
    final palmPath = Path();
    palmPath.moveTo(size.width * 0.2, size.height * 0.4);
    palmPath.lineTo(size.width * 0.8, size.height * 0.4);
    palmPath.lineTo(size.width * 0.8, size.height * 0.9);
    palmPath.lineTo(size.width * 0.2, size.height * 0.9);
    palmPath.close();
    canvas.drawPath(palmPath, paint);

    // Draw thumb
    final thumbPath = Path();
    thumbPath.moveTo(size.width * 0.05, size.height * 0.5);
    thumbPath.lineTo(size.width * 0.25, size.height * 0.45);
    thumbPath.lineTo(size.width * 0.25, size.height * 0.7);
    thumbPath.lineTo(size.width * 0.05, size.height * 0.75);
    thumbPath.close();
    canvas.drawPath(thumbPath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class PencilPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;

    // Draw pencil body
    paint.color = Color(0xFF1976D2);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(size.width * 0.3, size.height * 0.15, size.width * 0.4, size.width * 0.4),
        Radius.circular(size.width * 0.05),
      ),
      paint,
    );

    // Draw wooden part
    paint.color = Color(0xFFFFB74D);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(size.width * 0.3, size.height * 0.55, size.width * 0.4, size.height * 0.25),
        Radius.circular(size.width * 0.05),
      ),
      paint,
    );

    // Draw pencil tip
    final tipPath = Path();
    tipPath.moveTo(size.width * 0.4, size.height * 0.8);
    tipPath.lineTo(size.width * 0.5, size.height * 0.95);
    tipPath.lineTo(size.width * 0.6, size.height * 0.8);
    tipPath.close();
    
    paint.color = Color(0xFF424242);
    canvas.drawPath(tipPath, paint);

    // Draw eraser
    paint.color = Color(0xFFE91E63);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(size.width * 0.35, size.height * 0.05, size.width * 0.3, size.height * 0.12),
        Radius.circular(size.width * 0.05),
      ),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class VoteBoxPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;

    // Draw vote box base
    paint.color = Color(0xFF1976D2);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(size.width * 0.1, size.height * 0.45, size.width * 0.8, size.height * 0.45),
        Radius.circular(6),
      ),
      paint,
    );

    // Draw slot opening
    paint.color = Colors.black;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(size.width * 0.15, size.height * 0.4, size.width * 0.7, size.height * 0.06),
        Radius.circular(3),
      ),
      paint,
    );

    // Draw ballot paper
    paint.color = Color(0xFFFF7043);
    final ballotPath = Path();
    ballotPath.moveTo(size.width * 0.3, size.height * 0.05);
    ballotPath.lineTo(size.width * 0.7, size.height * 0.05);
    ballotPath.lineTo(size.width * 0.7, size.height * 0.45);
    ballotPath.lineTo(size.width * 0.3, size.height * 0.45);
    ballotPath.close();
    canvas.drawPath(ballotPath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class FistPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    // Draw main fist body
    final fistPath = Path();
    fistPath.moveTo(size.width * 0.15, size.height * 0.3);
    fistPath.lineTo(size.width * 0.85, size.height * 0.3);
    fistPath.lineTo(size.width * 0.9, size.height * 0.45);
    fistPath.lineTo(size.width * 0.85, size.height * 0.85);
    fistPath.lineTo(size.width * 0.15, size.height * 0.85);
    fistPath.lineTo(size.width * 0.1, size.height * 0.45);
    fistPath.close();
    canvas.drawPath(fistPath, paint);

    // Draw thumb
    final thumbPath = Path();
    thumbPath.moveTo(size.width * 0.05, size.height * 0.2);
    thumbPath.lineTo(size.width * 0.25, size.height * 0.15);
    thumbPath.lineTo(size.width * 0.3, size.height * 0.4);
    thumbPath.lineTo(size.width * 0.15, size.height * 0.45);
    thumbPath.close();
    canvas.drawPath(thumbPath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

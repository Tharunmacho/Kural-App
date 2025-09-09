import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PhoneCallScreen extends StatefulWidget {
  final String voterName;
  final String voterTamilName;
  final String phoneNumber;
  final String voterId;
  final String doorNo;
  final int age;
  final String gender;

  const PhoneCallScreen({
    super.key,
    required this.voterName,
    required this.voterTamilName,
    required this.phoneNumber,
    required this.voterId,
    required this.doorNo,
    required this.age,
    required this.gender,
  });

  @override
  State<PhoneCallScreen> createState() => _PhoneCallScreenState();
}

class _PhoneCallScreenState extends State<PhoneCallScreen>
    with TickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;
  bool _isCallActive = false;

  String _callStatus = 'Connecting...';

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    );
    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
    _pulseController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  void _makeCall() async {
    setState(() {
      _isCallActive = true;
      _callStatus = 'Calling...';
    });

    final Uri launchUri = Uri(
      scheme: 'tel',
      path: widget.phoneNumber,
    );

    try {
      if (await canLaunchUrl(launchUri)) {
        await launchUrl(launchUri);
        setState(() {
          _callStatus = 'Call in progress';
        });
      } else {
        setState(() {
          _callStatus = 'Unable to make call';
        });
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Could not launch phone dialer'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    } catch (e) {
      setState(() {
        _callStatus = 'Call failed';
      });
    }
  }

  void _endCall() {
    setState(() {
      _isCallActive = false;
      _callStatus = 'Call ended';
    });
    Navigator.pop(context);
  }

  Widget _buildCallButton(IconData icon, String label, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 70,
        height: 70,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.3),
              blurRadius: 15,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: Icon(
          icon,
          color: Colors.white,
          size: 30,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1A1A1A),
      body: SafeArea(
        child: Column(
          children: [
            // Header section
            Container(
              padding: EdgeInsets.all(20),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        'Guardian Call',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Container(width: 44), // Spacer for centering
                ],
              ),
            ),

            // Call status
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                _callStatus,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white70,
                ),
              ),
            ),

            const SizedBox(height: 40),

            // Voter profile section
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Profile image with pulse animation
                  AnimatedBuilder(
                    animation: _pulseAnimation,
                    builder: (context, child) {
                      return Transform.scale(
                        scale: _isCallActive ? _pulseAnimation.value : 1.0,
                        child: Container(
                          width: 180,
                          height: 180,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Color(0xFF4CAF50),
                                Color(0xFF2196F3),
                              ],
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Color(0xFF2196F3).withValues(alpha: 0.3),
                                blurRadius: 30,
                                offset: Offset(0, 10),
                              ),
                            ],
                          ),
                          child: Center(
                            child: Icon(
                              Icons.person,
                              size: 80,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 30),

                  // Voter name
                  Text(
                    widget.voterName,
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 8),

                  // Tamil name
                  Text(
                    widget.voterTamilName,
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white70,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 20),

                  // Phone number
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Text(
                      widget.phoneNumber,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        letterSpacing: 2,
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),

                  // Voter details
                  Container(
                    padding: EdgeInsets.all(20),
                    margin: EdgeInsets.symmetric(horizontal: 40),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.05),
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.1),
                      ),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Voter ID:',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              widget.voterId,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Door No:',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              widget.doorNo,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Age & Gender:',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              '${widget.age} years, ${widget.gender}',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Call action buttons
            Container(
              padding: EdgeInsets.all(40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Mute button
                  _buildCallButton(
                    Icons.mic_off,
                    'Mute',
                    Colors.grey[600]!,
                    () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Mute functionality will be handled by phone app'),
                          backgroundColor: Colors.grey,
                        ),
                      );
                    },
                  ),

                  // Call button
                  GestureDetector(
                    onTap: _isCallActive ? _endCall : _makeCall,
                    child: AnimatedBuilder(
                      animation: _pulseAnimation,
                      builder: (context, child) {
                        return Transform.scale(
                          scale: _isCallActive ? 1.0 : _pulseAnimation.value,
                          child: Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              color: _isCallActive ? Colors.red : Colors.green,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: (_isCallActive ? Colors.red : Colors.green)
                                      .withValues(alpha: 0.4),
                                  blurRadius: 20,
                                  offset: Offset(0, 8),
                                ),
                              ],
                            ),
                            child: Icon(
                              _isCallActive ? Icons.call_end : Icons.call,
                              color: Colors.white,
                              size: 35,
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  // Speaker button
                  _buildCallButton(
                    Icons.volume_up,
                    'Speaker',
                    Colors.grey[600]!,
                    () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Speaker functionality will be handled by phone app'),
                          backgroundColor: Colors.grey,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),

            // Alternative calling options
            Container(
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              child: Column(
                children: [
                  Text(
                    'Or choose your preferred calling app:',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildAppOption(
                        'Phone',
                        Icons.phone,
                        Colors.green,
                        () => _launchWithApp('tel:'),
                      ),
                      _buildAppOption(
                        'WhatsApp',
                        Icons.message,
                        Color(0xFF25D366),
                        () => _launchWhatsApp(),
                      ),
                      _buildAppOption(
                        'SMS',
                        Icons.sms,
                        Colors.blue,
                        () => _launchSMS(),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppOption(String label, IconData icon, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.2),
              shape: BoxShape.circle,
              border: Border.all(color: color, width: 2),
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
              color: Colors.white70,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  void _launchWithApp(String scheme) async {
    final Uri launchUri = Uri.parse('$scheme${widget.phoneNumber}');
    if (await canLaunchUrl(launchUri)) {
      await launchUrl(launchUri);
    }
  }

  void _launchWhatsApp() async {
    final Uri whatsappUri = Uri.parse('https://wa.me/${widget.phoneNumber}');
    if (await canLaunchUrl(whatsappUri)) {
      await launchUrl(whatsappUri);
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('WhatsApp not installed'),
            backgroundColor: Colors.orange,
          ),
        );
      }
    }
  }

  void _launchSMS() async {
    final Uri smsUri = Uri.parse('sms:${widget.phoneNumber}');
    if (await canLaunchUrl(smsUri)) {
      await launchUrl(smsUri);
    }
  }
}

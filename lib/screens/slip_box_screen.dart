import 'package:flutter/material.dart';
import 'voter_slip_screen.dart';
import '../widgets/bottom_navigation_bar.dart';
import 'dashboard_screen.dart';

class SlipBoxScreen extends StatefulWidget {
  const SlipBoxScreen({super.key});

  @override
  State<SlipBoxScreen> createState() => _SlipBoxScreenState();
}

class _SlipBoxScreenState extends State<SlipBoxScreen> {
  bool _isSlipBoxSelected = true;
  bool _showBluetoothDialog = true; // Show dialog by default

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (_) => const DashboardScreen()),
          (route) => false,
        );
      },
      child: Scaffold(
      backgroundColor: Color(0xFFF5F7FA),
      body: SafeArea(
        child: Stack(
          children: [
            Column(
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
                        onTap: () {
                          Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(builder: (_) => const DashboardScreen()),
                            (route) => false,
                          );
                        },
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
                            'Slip Box',
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
                
                const SizedBox(height: 30),
                
                // Toggle buttons section
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 16),
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Color(0xFF1976D2),
                      width: 2,
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              _isSlipBoxSelected = true;
                              _showBluetoothDialog = true;
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 16),
                            decoration: BoxDecoration(
                              color: _isSlipBoxSelected 
                                  ? Color(0xFF1976D2) 
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              'Slip Box',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: _isSlipBoxSelected 
                                    ? Colors.white 
                                    : Color(0xFF1976D2),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              _isSlipBoxSelected = false;
                            });
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => VoterSlipScreen(),
                              ),
                            );
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 16),
                            decoration: BoxDecoration(
                              color: !_isSlipBoxSelected 
                                  ? Color(0xFF1976D2) 
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              'Voter Slip',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: !_isSlipBoxSelected 
                                    ? Colors.white 
                                    : Color(0xFF1976D2),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                
                Spacer(),
                
                // Bottom navigation
                CustomBottomNavigationBar(currentIndex: 3), // 3 = Slip index
              ],
            ),
            
            // Bluetooth dialog overlay
            if (_showBluetoothDialog)
              Container(
                color: Colors.black.withValues(alpha: 0.5),
                child: Center(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    padding: EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                'Slip Box Setting',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  _showBluetoothDialog = false;
                                });
                              },
                              child: Icon(
                                Icons.close,
                                color: Colors.black54,
                                size: 24,
                              ),
                            ),
                          ],
                        ),
                        
                        const SizedBox(height: 20),
                        
                        Text(
                          'Enable Bluetooth to discover devices',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black54,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        
                        const SizedBox(height: 40),
                        
                        // Enable Bluetooth button
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: _enableBluetooth,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF1976D2),
                              foregroundColor: Colors.white,
                              padding: EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              elevation: 2,
                            ),
                            child: Text(
                              'Enable Bluetooth',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
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

  void _enableBluetooth() {
    // Simulate Bluetooth enabling
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(
              Icons.bluetooth_connected,
              color: Colors.white,
            ),
            const SizedBox(width: 8),
            Text('Bluetooth enabled successfully'),
          ],
        ),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 2),
      ),
    );
    
    setState(() {
      _showBluetoothDialog = false;
    });
    
    // Show device discovery
    Future.delayed(Duration(milliseconds: 500), () {
      _showDeviceDiscovery();
    });
  }

  void _showDeviceDiscovery() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Bluetooth Devices',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Discovering nearby devices...',
              style: TextStyle(color: Colors.black54),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF1976D2)),
                  ),
                ),
                const SizedBox(width: 12),
                Text('Searching for slip box devices...'),
              ],
            ),
            const SizedBox(height: 20),
            // Mock discovered device
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.blue.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.blue.withValues(alpha: 0.3)),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.bluetooth,
                    color: Colors.blue,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Slip Box Device',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Ready to connect',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Connected to Slip Box Device'),
                          backgroundColor: Colors.green,
                        ),
                      );
                    },
                    child: Text('Connect'),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Close'),
          ),
        ],
      ),
    );
  }

}

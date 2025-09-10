import 'package:flutter/material.dart';
import 'dashboard_screen.dart';

class VoterSlipScreen extends StatefulWidget {
  const VoterSlipScreen({super.key});

  @override
  State<VoterSlipScreen> createState() => _VoterSlipScreenState();
}

class _VoterSlipScreenState extends State<VoterSlipScreen> {
  final TextEditingController _searchController = TextEditingController();
  
  // Toggle states for Default section
  bool _defaultPrintEnabled = false;
  bool _defaultCandidateEnabled = false;
  
  // Toggle states for Thondamuthur4 section
  bool _thondamuthurPrintEnabled = true;
  bool _thondamuthurCandidateEnabled = true;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

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
        backgroundColor: Colors.grey[50],
        body: Column(
          children: [
            // Header with light blue background
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(top: 40, bottom: 20, left: 20, right: 20),
              decoration: BoxDecoration(
                color: Color(0xFFE3F2FD), // Light blue background
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: Row(
                children: [
                  // Back button
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (_) => const DashboardScreen()),
                        (route) => false,
                      );
                    },
                    child: Icon(
                      Icons.arrow_back,
                      size: 24,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(width: 16),
                  // Title
                  Expanded(
                    child: Text(
                      'Voter Slip',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  const SizedBox(width: 40), // Balance the back button
                ],
              ),
            ),
            
            // Search bar
            Padding(
              padding: const EdgeInsets.all(20),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 8,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Enter Voter Slip Name',
                    hintStyle: TextStyle(
                      color: Colors.grey[400],
                      fontSize: 16,
                    ),
                    suffixIcon: Icon(
                      Icons.search,
                      color: Colors.grey[400],
                      size: 20,
                    ),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  ),
                ),
              ),
            ),
            
            // Content sections
            Expanded(
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 20),
                children: [
                  // Default section
                  _buildVoterSlipSection(
                    title: 'Default',
                    printEnabled: _defaultPrintEnabled,
                    candidateEnabled: _defaultCandidateEnabled,
                    onPrintChanged: (value) {
                      setState(() {
                        _defaultPrintEnabled = value;
                      });
                    },
                    onCandidateChanged: (value) {
                      setState(() {
                        _defaultCandidateEnabled = value;
                      });
                    },
                  ),
                  
                  const SizedBox(height: 20),
                  
                  // Thondamuthur4 section
                  _buildVoterSlipSection(
                    title: 'Thondamuthur4',
                    printEnabled: _thondamuthurPrintEnabled,
                    candidateEnabled: _thondamuthurCandidateEnabled,
                    onPrintChanged: (value) {
                      setState(() {
                        _thondamuthurPrintEnabled = value;
                      });
                    },
                    onCandidateChanged: (value) {
                      setState(() {
                        _thondamuthurCandidateEnabled = value;
                      });
                    },
                    showPreview: true,
                  ),
                ],
              ),
            ),
          ],
        ),
        
        // Bottom navigation bar
        bottomNavigationBar: Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 8,
                offset: Offset(0, -2),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildNavItem('Repor', Icons.trending_up, false),
              _buildNavItem('Catalogue', Icons.view_module, false),
              _buildNavItem('', Icons.home, true),
              _buildNavItem('Slip', Icons.receipt_long, false),
              _buildNavItem('Poll', Icons.how_to_vote, false),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildVoterSlipSection({
    required String title,
    required bool printEnabled,
    required bool candidateEnabled,
    required Function(bool) onPrintChanged,
    required Function(bool) onCandidateChanged,
    bool showPreview = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section title
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            
            const SizedBox(height: 20),
            
            // Toggle switches row
            Row(
              children: [
                // Print toggle
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        'Prin',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Transform.scale(
                          scale: 1.2,
                          child: Switch(
                            value: printEnabled,
                            onChanged: onPrintChanged,
                            thumbColor: MaterialStateProperty.resolveWith((states) {
                              return Colors.white;
                            }),
                            trackColor: MaterialStateProperty.resolveWith((states) {
                              if (states.contains(MaterialState.selected)) {
                                return Colors.green;
                              }
                              return Colors.red;
                            }),
                            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(width: 20),
                
                // Candidate toggle
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        'Candidate',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Transform.scale(
                          scale: 1.2,
                          child: Switch(
                            value: candidateEnabled,
                            onChanged: onCandidateChanged,
                            thumbColor: MaterialStateProperty.resolveWith((states) {
                              return Colors.white;
                            }),
                            trackColor: MaterialStateProperty.resolveWith((states) {
                              if (states.contains(MaterialState.selected)) {
                                return Colors.green;
                              }
                              return Colors.red;
                            }),
                            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                
                // Preview image (only for Thondamuthur4)
                if (showPreview) ...[
                  const SizedBox(width: 20),
                  Container(
                    width: 80,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey[300]!),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.person,
                          size: 30,
                          color: Colors.grey[600],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Voter Slip\nPreview',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 8,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(String label, IconData icon, bool isActive) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: isActive ? Color(0xFF1976D2) : Colors.transparent,
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            size: 24,
            color: isActive ? Colors.white : Colors.grey[600],
          ),
        ),
        if (label.isNotEmpty) ...[
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: isActive ? Color(0xFF1976D2) : Colors.grey[600],
              fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
        ],
      ],
    );
  }
}
import 'package:flutter/material.dart';
import 'dart:math';
import '../widgets/bottom_navigation_bar.dart';

class CatalogueScreen extends StatelessWidget {
  const CatalogueScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Header with light blue background
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            decoration: BoxDecoration(
              color: Color(0xFFE3F2FD),
            ),
            child: Row(
              children: [
                // Back button
                GestureDetector(
                  onTap: () => Navigator.pop(context),
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
                    'Catalogue',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),
                const SizedBox(width: 40), // Balance the back button
              ],
            ),
          ),
          
          // Main content area with grid of product cards
          Expanded(
            child: Container(
              color: Colors.white,
              padding: const EdgeInsets.all(16),
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 0.75,
                children: [
                  _buildProductCard(
                    'SlipBox - Sticker',
                    '₹4,500',
                    _buildSlipBoxStickerImage(true), // White printer
                  ),
                  _buildProductCard(
                    'Slipbox - Sticker',
                    '₹4,500',
                    _buildSlipBoxStickerImage(false), // Black printer
                  ),
                  _buildProductCard(
                    'Slip Paper',
                    '₹25',
                    _buildSlipPaperImage(),
                  ),
                  _buildProductCard(
                    'Slip Sticker',
                    '₹50',
                    _buildSlipStickerImage(),
                  ),
                  _buildProductCard(
                    'EVM - Thermocol',
                    '₹150',
                    _buildEVMThermocolImage(),
                  ),
                  _buildProductCard(
                    'EVM - Plastic',
                    '₹50',
                    _buildEVMPlasticImage(),
                  ),
                  _buildProductCard(
                    'Bulk WhatsApp',
                    '₹0.85',
                    _buildBulkWhatsAppImage(),
                  ),
                  _buildProductCard(
                    'Bulk Video Call',
                    '₹2',
                    _buildBulkVideoCallImage(),
                  ),
                  _buildProductCard(
                    'Bulk Voice Call',
                    '₹0.25',
                    _buildBulkVoiceCallImage(),
                  ),
                  _buildProductCard(
                    'Bulk SMS',
                    '₹0.25',
                    _buildBulkSMSImage(),
                  ),
                  _buildProductCard(
                    'Bulk RCS',
                    '₹0.55',
                    _buildBulkRCSImage(),
                  ),
                  _buildProductCard(
                    'AR Video',
                    '₹1',
                    _buildARVideoImage(),
                  ),
                  _buildProductCard(
                    'Voter Slip PDF',
                    '₹1',
                    _buildVoterSlipPDFImage(),
                  ),
                  _buildProductCard(
                    'Family Slip PDF',
                    '₹5',
                    _buildFamilySlipPDFImage(),
                  ),
                  _buildProductCard(
                    'Cyber Security',
                    '₹1',
                    _buildCyberSecurityImage(),
                  ),
                  _buildProductCard(
                    'Content Creation',
                    '₹1',
                    _buildContentCreationImage(),
                  ),
                  _buildProductCard(
                    'FORM-20 Analyst',
                    '₹1',
                    _buildForm20AnalystImage(),
                  ),
                ],
              ),
            ),
          ),
          
          // Bottom navigation bar
          CustomBottomNavigationBar(currentIndex: 1), // 1 = Catalogue index
        ],
      ),
    );
  }

  Widget _buildProductCard(String title, String price, Widget image) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Image section with light blue background
          Expanded(
            flex: 3,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Color(0xFFE3F2FD),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
                child: image,
              ),
            ),
          ),
          // Text section with white background
          Expanded(
            flex: 2,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(12),
                  bottomRight: Radius.circular(12),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    price,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1976D2),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // SlipBox Sticker Printer
  Widget _buildSlipBoxStickerImage(bool isWhite) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Center(
        child: Container(
          width: 60,
          height: 50,
          decoration: BoxDecoration(
            color: isWhite ? Colors.white : Colors.black,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey[300]!),
          ),
          child: Stack(
            children: [
              // Printer body
              Center(
                child: Icon(
                  Icons.print,
                  size: 24,
                  color: isWhite ? Colors.black : Colors.white,
                ),
              ),
              // LED indicators
              Positioned(
                top: 4,
                right: 4,
                child: Container(
                  width: 6,
                  height: 6,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              Positioned(
                top: 4,
                right: 12,
                child: Container(
                  width: 6,
                  height: 6,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Slip Paper Rolls
  Widget _buildSlipPaperImage() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(3, (index) => Container(
          width: 20,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey[300]!),
          ),
          child: Center(
            child: Icon(
              Icons.circle,
              size: 16,
              color: Colors.grey[400],
            ),
          ),
        )),
      ),
    );
  }

  // Slip Sticker Rolls
  Widget _buildSlipStickerImage() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // Sticker rolls
          Container(
            width: 25,
            height: 45,
            decoration: BoxDecoration(
              color: Colors.green[100],
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.green[300]!),
            ),
          ),
          Container(
            width: 25,
            height: 45,
            decoration: BoxDecoration(
              color: Colors.blue[100],
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.blue[300]!),
            ),
          ),
          // Unrolled sticker
          Container(
            width: 20,
            height: 30,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: Colors.grey[300]!),
            ),
            child: Column(
              children: List.generate(3, (index) => Expanded(
                child: Container(
                  margin: EdgeInsets.all(1),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              )),
            ),
          ),
        ],
      ),
    );
  }

  // EVM Thermocol
  Widget _buildEVMThermocolImage() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Center(
        child: Container(
          width: 60,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: Colors.grey[400]!),
          ),
          child: Column(
            children: [
              // Top section with party symbols
              Expanded(
                child: Container(
                  margin: EdgeInsets.all(4),
                  child: Column(
                    children: List.generate(3, (index) => Expanded(
                      child: Row(
                        children: [
                          Container(
                            width: 12,
                            height: 12,
                            margin: EdgeInsets.all(1),
                            decoration: BoxDecoration(
                              color: Colors.blue[100],
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              height: 8,
                              margin: EdgeInsets.all(1),
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(1),
                              ),
                            ),
                          ),
                          Container(
                            width: 8,
                            height: 8,
                            margin: EdgeInsets.all(1),
                            decoration: BoxDecoration(
                              color: Colors.grey[400],
                              shape: BoxShape.circle,
                            ),
                          ),
                        ],
                      ),
                    )),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // EVM Plastic
  Widget _buildEVMPlasticImage() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Center(
        child: Container(
          width: 50,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.grey[800],
            borderRadius: BorderRadius.circular(4),
          ),
          child: Stack(
            children: [
              // Display screen
              Positioned(
                top: 4,
                left: 4,
                right: 4,
                child: Container(
                  height: 12,
                  decoration: BoxDecoration(
                    color: Colors.green[300],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              // Control buttons
              Positioned(
                bottom: 4,
                left: 4,
                right: 4,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(4, (index) => Container(
                    width: 6,
                    height: 6,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                  )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Bulk WhatsApp
  Widget _buildBulkWhatsAppImage() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Stack(
        children: [
          // Phone
          Center(
            child: Container(
              width: 40,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey[300]!),
              ),
              child: Center(
                child: Icon(
                  Icons.smartphone,
                  size: 24,
                  color: Colors.grey[600],
                ),
              ),
            ),
          ),
          // WhatsApp bubbles
          ...List.generate(5, (index) => Positioned(
            top: 10 + (index * 8.0),
            right: 10 + (index * 6.0),
            child: Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                color: Colors.green[400],
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Icon(
                  Icons.chat,
                  size: 8,
                  color: Colors.white,
                ),
              ),
            ),
          )),
        ],
      ),
    );
  }

  // Bulk Video Call
  Widget _buildBulkVideoCallImage() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Center(
        child: Container(
          width: 60,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.blue[100],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Stack(
            children: [
              // Person silhouette
              Center(
                child: Icon(
                  Icons.person,
                  size: 32,
                  color: Colors.blue[800],
                ),
              ),
              // Video call icon
              Positioned(
                bottom: 4,
                right: 4,
                child: Container(
                  padding: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.videocam,
                    size: 8,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Bulk Voice Call
  Widget _buildBulkVoiceCallImage() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Stack(
        children: [
          // Megaphone/Speaker
          Center(
            child: Icon(
              Icons.campaign,
              size: 40,
              color: Colors.grey[600],
            ),
          ),
          // Sound waves
          ...List.generate(3, (index) => Positioned(
            right: 8 + (index * 8.0),
            top: 20 + (index * 4.0),
            child: Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: Colors.blue[300],
                shape: BoxShape.circle,
              ),
            ),
          )),
        ],
      ),
    );
  }

  // Bulk SMS
  Widget _buildBulkSMSImage() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Stack(
        children: [
          // Phone
          Center(
            child: Container(
              width: 40,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.blue[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Icon(
                  Icons.smartphone,
                  size: 24,
                  color: Colors.blue[800],
                ),
              ),
            ),
          ),
          // Message envelopes
          Positioned(
            top: 8,
            right: 8,
            child: Container(
              width: 16,
              height: 12,
              decoration: BoxDecoration(
                color: Colors.yellow[600],
                borderRadius: BorderRadius.circular(2),
              ),
              child: Icon(
                Icons.mail,
                size: 8,
                color: Colors.white,
              ),
            ),
          ),
          Positioned(
            top: 18,
            right: 12,
            child: Container(
              width: 16,
              height: 12,
              decoration: BoxDecoration(
                color: Colors.orange[600],
                borderRadius: BorderRadius.circular(2),
              ),
              child: Icon(
                Icons.mail,
                size: 8,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Bulk RCS
  Widget _buildBulkRCSImage() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Stack(
        children: [
          // Central hub
          Center(
            child: Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                color: Colors.blue[600],
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.hub,
                size: 16,
                color: Colors.white,
              ),
            ),
          ),
          // Connected nodes
          ...List.generate(6, (index) {
            double angle = (index * 60) * (3.14159 / 180); // Convert to radians
            double radius = 25;
            double x = 30 + radius * cos(angle);
            double y = 30 + radius * sin(angle);
            return Positioned(
              left: x,
              top: y,
              child: Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: Colors.orange[400],
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Icon(
                    Icons.person,
                    size: 6,
                    color: Colors.white,
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  // AR Video
  Widget _buildARVideoImage() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Stack(
        children: [
          // Phone/tablet
          Center(
            child: Container(
              width: 50,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey[300]!),
              ),
              child: Center(
                child: Container(
                  width: 40,
                  height: 30,
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.qr_code,
                      size: 20,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
          ),
          // AR elements
          Positioned(
            top: 8,
            right: 8,
            child: Icon(
              Icons.visibility,
              size: 16,
              color: Colors.green[600],
            ),
          ),
        ],
      ),
    );
  }

  // Voter Slip PDF
  Widget _buildVoterSlipPDFImage() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          // Multiple slip documents
          Expanded(
            child: Stack(
              children: [
                // Background documents
                ...List.generate(4, (index) => Positioned(
                  left: index * 4.0,
                  top: index * 3.0,
                  child: Container(
                    width: 30,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(color: Colors.grey[300]!),
                    ),
                    child: Column(
                      children: [
                        // Header with colors
                        Container(
                          height: 8,
                          decoration: BoxDecoration(
                            color: index % 2 == 0 ? Colors.orange : Colors.blue,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(4),
                              topRight: Radius.circular(4),
                            ),
                          ),
                        ),
                        // Content lines
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(2),
                            child: Column(
                              children: List.generate(3, (lineIndex) => Container(
                                height: 2,
                                margin: EdgeInsets.symmetric(vertical: 1),
                                decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  borderRadius: BorderRadius.circular(1),
                                ),
                              )),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Family Slip PDF
  Widget _buildFamilySlipPDFImage() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Center(
        child: Container(
          width: 50,
          height: 60,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: Colors.grey[300]!),
          ),
          child: Column(
            children: [
              // Header with government logo area
              Container(
                height: 12,
                decoration: BoxDecoration(
                  color: Colors.green[100],
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(4),
                    topRight: Radius.circular(4),
                  ),
                ),
                child: Center(
                  child: Icon(
                    Icons.account_balance,
                    size: 8,
                    color: Colors.green[800],
                  ),
                ),
              ),
              // Content area with text lines
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(4),
                  child: Column(
                    children: [
                      // Title area
                      Container(
                        height: 6,
                        decoration: BoxDecoration(
                          color: Colors.grey[400],
                          borderRadius: BorderRadius.circular(1),
                        ),
                      ),
                      SizedBox(height: 2),
                      // Content lines
                      ...List.generate(6, (index) => Container(
                        height: 2,
                        margin: EdgeInsets.symmetric(vertical: 1),
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(1),
                        ),
                      )),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Cyber Security
  Widget _buildCyberSecurityImage() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Stack(
        children: [
          // Circuit board background
          Center(
            child: Container(
              width: 60,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.blue[900],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Stack(
                children: [
                  // Circuit lines
                  ...List.generate(3, (index) => Positioned(
                    left: 4 + (index * 16.0),
                    top: 4,
                    bottom: 4,
                    child: Container(
                      width: 2,
                      decoration: BoxDecoration(
                        color: Colors.cyan[300],
                        borderRadius: BorderRadius.circular(1),
                      ),
                    ),
                  )),
                  // Security shield
                  Center(
                    child: Icon(
                      Icons.security,
                      size: 28,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Cyber elements
          Positioned(
            top: 4,
            left: 4,
            child: Icon(
              Icons.lock,
              size: 12,
              color: Colors.green[600],
            ),
          ),
          Positioned(
            bottom: 4,
            right: 4,
            child: Icon(
              Icons.download,
              size: 12,
              color: Colors.blue[300],
            ),
          ),
        ],
      ),
    );
  }

  // Content Creation
  Widget _buildContentCreationImage() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Stack(
        children: [
          // Paper/canvas background
          Center(
            child: Container(
              width: 50,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.yellow[50],
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: Colors.grey[300]!),
              ),
            ),
          ),
          // Lightbulb (ideas)
          Positioned(
            top: 8,
            right: 8,
            child: Container(
              padding: EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: Colors.yellow[300],
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.lightbulb,
                size: 16,
                color: Colors.orange[800],
              ),
            ),
          ),
          // Creative elements
          Positioned(
            bottom: 8,
            left: 8,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.brush, size: 10, color: Colors.purple[600]),
                SizedBox(width: 2),
                Icon(Icons.color_lens, size: 10, color: Colors.green[600]),
              ],
            ),
          ),
          // "Think!" text bubble
          Positioned(
            top: 12,
            left: 12,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey[400]!),
              ),
              child: Text(
                'Think!',
                style: TextStyle(
                  fontSize: 6,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // FORM-20 Analyst
  Widget _buildForm20AnalystImage() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Stack(
        children: [
          // Monitor/screen
          Center(
            child: Container(
              width: 50,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.grey[800],
                borderRadius: BorderRadius.circular(4),
              ),
              child: Container(
                margin: EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(2),
                ),
                child: Column(
                  children: [
                    // Chart/graph area
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(2),
                        child: Row(
                          children: List.generate(4, (index) => Expanded(
                            child: Container(
                              margin: EdgeInsets.all(0.5),
                              decoration: BoxDecoration(
                                color: [Colors.blue, Colors.green, Colors.orange, Colors.red][index],
                                borderRadius: BorderRadius.circular(1),
                              ),
                              height: 8 + (index * 4.0),
                            ),
                          )),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // People analyzing
          Positioned(
            bottom: 4,
            left: 4,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(3, (index) => Container(
                width: 8,
                height: 12,
                margin: EdgeInsets.only(right: 2),
                decoration: BoxDecoration(
                  color: [Colors.blue[300], Colors.green[300], Colors.orange[300]][index],
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Icon(
                  Icons.person,
                  size: 6,
                  color: Colors.white,
                ),
              )),
            ),
          ),
        ],
      ),
    );
  }

}

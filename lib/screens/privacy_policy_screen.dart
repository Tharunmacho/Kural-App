import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Header with title and close button
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Row(
                children: [
                  // Title
                  Expanded(
                    child: Text(
                      'Privacy Policy',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1976D2),
                      ),
                    ),
                  ),
                  // Close button
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Icon(
                      Icons.close,
                      size: 24,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
            
            // Main content area
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Subtitle
                    Text(
                      'Privacy Policy for TEAM App SaaS Platform',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 20),
                    
                    // Introductory paragraph
                    Text(
                      'Welcome to TEAM (Thedal Election Analytics Manager), a Software-as-a-Service (SaaS) platform designed to empower organizations with secure and efficient tools for election campaign management. This Privacy Policy outlines how we, as a SaaS provider, handle data, ensuring transparency, security, and compliance with applicable laws.',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 20),
                    
                    // User agreement statement
                    Text(
                      'By using the TEAM App, you agree to the terms of this Privacy Policy. If you do not agree, please refrain from using the service.',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 30),
                    
                    // Section 1
                    Text(
                      '1. Scope of the Policy',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 12),
                    
                    Text(
                      'This Privacy Policy applies to all users of the TEAM App, including organizations and their authorized representatives. As a SaaS provider, we facilitate the secure storage, processing, and management of data on behalf of our clients, adhering to strict data protection and privacy standards.',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 30),
                    
                    // Section 2
                    Text(
                      '2. Information We Collect',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 12),
                    
                    Text(
                      'We collect information that you provide directly to us, such as when you create an account, use our services, or contact us for support. This may include personal information such as your name, email address, phone number, and organization details.',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 30),
                    
                    // Section 3
                    Text(
                      '3. How We Use Your Information',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 12),
                    
                    Text(
                      'We use the information we collect to provide, maintain, and improve our services, communicate with you, and ensure the security of our platform. We do not sell, trade, or otherwise transfer your personal information to third parties without your consent.',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 30),
                    
                    // Section 4
                    Text(
                      '4. Data Security',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 12),
                    
                    Text(
                      'We implement appropriate technical and organizational security measures to protect your personal information against unauthorized access, alteration, disclosure, or destruction. Our security practices are regularly reviewed and updated to maintain the highest standards of data protection.',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 30),
                    
                    // Section 5
                    Text(
                      '5. Contact Us',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 12),
                    
                    Text(
                      'If you have any questions about this Privacy Policy or our data practices, please contact us at privacy@teamapp.com. We are committed to addressing your concerns and ensuring transparency in our data handling practices.',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                        height: 1.5,
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
}

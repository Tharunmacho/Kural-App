import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

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
                      'Help',
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
                    // Contact Information Section
                    Text(
                      'Contact Information',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 20),
                    
                    // Website
                    _buildContactItem(
                      'Website: ',
                      'www.thedal.co.in',
                      'https://www.thedal.co.in',
                    ),
                    const SizedBox(height: 15),
                    
                    // Email
                    _buildContactItem(
                      'Email: ',
                      'contact@thedal.co.in',
                      'mailto:contact@thedal.co.in',
                    ),
                    const SizedBox(height: 15),
                    
                    // Mobile
                    _buildContactItem(
                      'Mobile: ',
                      '861-862-7199',
                      'tel:8618627199',
                    ),
                    const SizedBox(height: 15),
                    
                    // LinkedIn
                    _buildContactItem(
                      'LinkedIn: ',
                      'https://www.linkedin.com/company/thedalappind',
                      'https://www.linkedin.com/company/thedalappind',
                    ),
                    const SizedBox(height: 30),
                    
                    // App Description Section
                    Text(
                      'Thedal Election Analytics Manager (TEAM App)',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 20),
                    
                    // Description paragraphs
                    Text(
                      'India\'s first ElectionTech SaaS platform designed to revolutionize election campaign management through data-driven strategies and advanced digital tools.',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 20),
                    
                    Text(
                      'Whether you\'re a political candidate, party worker, strategist, or grassroots organizer, TEAM App provides comprehensive solutions to manage voter outreach, coordinate campaign teams, and optimize booth-level activities.',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 20),
                    
                    Text(
                      'Our platform offers digital voter lists, cadre tracking, geo-spatial insights, and real-time data analytics, ensuring every decision is backed by accurate information, making your campaign smarter and more effective.',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 20),
                    
                    Text(
                      'Built for efficiency, TEAM App enables seamless coordination between campaign teams, provides actionable insights through advanced analytics, and helps you connect with voters more effectively than ever before.',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 20),
                    
                    Text(
                      'Experience the future of election campaigning with TEAM App - where technology meets democracy to create more informed, efficient, and successful political campaigns.',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactItem(String label, String value, String url) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 16,
            color: Colors.black87,
            fontWeight: FontWeight.w500,
          ),
        ),
        Expanded(
          child: GestureDetector(
            onTap: () => _launchURL(url),
            child: Text(
              value,
              style: TextStyle(
                fontSize: 16,
                color: Color(0xFF1976D2),
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }
}

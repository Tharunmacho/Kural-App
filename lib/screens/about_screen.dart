import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

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
                      'About',
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
                    // About Thedal App Section
                    Text(
                      'About Thedal App',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 20),
                    
                    // Description paragraphs
                    Text(
                      'Thedal App is India\'s first comprehensive ElectionTech SaaS platform designed to simplify and supercharge election management.',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 20),
                    
                    Text(
                      'From booth-level voter mapping, volunteer management, to real-time data tracking and strategic insights, Team App empowers political candidates, parties, and organizations to manage campaigns digitally and efficiently.',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 20),
                    
                    Text(
                      'Whether you are contesting a local body election or a major assembly poll, Team App is your all-in-one toolkit to plan, execute, and win smartly.',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 25),
                    
                    // Key Highlights Section
                    Text(
                      'Key Highlights:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 15),
                    
                    // Numbered list of key highlights
                    _buildNumberedItem('1.', 'Booth-level voter visualization with geo-tagging'),
                    _buildNumberedItem('2.', 'Cadre and volunteer management tools'),
                    _buildNumberedItem('3.', 'Real-time voter data verification and analytics'),
                    _buildNumberedItem('4.', 'Customizable campaign dashboards'),
                    _buildNumberedItem('5.', 'Mobile-first and cloud-based accessibility'),
                    const SizedBox(height: 30),
                    
                    // About Section (from second image)
                    Text(
                      'empower candidates with cutting-edge technology, Thedal blends deep political insights with modern SaaS solutions to create a new era of smart campaigning. Our flagship product, Thedal App, is already creating waves across all parts of India and global, helping candidates build data-driven, organized, and winning campaigns.',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 25),
                    
                    // Our Mission Section
                    Text(
                      'Our Mission:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 15),
                    
                    // Numbered list of mission points
                    _buildNumberedItem('1.', 'Digitize the election management process'),
                    _buildNumberedItem('2.', 'Make political campaigns data-centric and efficient'),
                    _buildNumberedItem('3.', 'Empower leaders and aspirants with easy-to-use technology'),
                    _buildNumberedItem('4.', 'Create a level-playing field for new and emerging political faces'),
                    const SizedBox(height: 25),
                    
                    // Divider
                    Divider(
                      color: Colors.grey[300],
                      height: 30,
                    ),
                    
                    // Contact Information Section
                    _buildContactItem('Website: ', 'www.thedal.co.in', 'https://www.thedal.co.in'),
                    const SizedBox(height: 12),
                    _buildContactItem('Email : ', 'contact@thedal.co.in', 'mailto:contact@thedal.co.in'),
                    const SizedBox(height: 12),
                    _buildContactItem('Mobile : ', '861-862-7199', 'tel:8618627199'),
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

  Widget _buildNumberedItem(String number, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            number,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 16,
                color: Colors.black87,
                height: 1.4,
              ),
            ),
          ),
        ],
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

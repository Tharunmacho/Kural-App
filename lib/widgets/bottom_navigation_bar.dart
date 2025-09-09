import 'package:flutter/material.dart';
import '../screens/dashboard_screen.dart';
import '../screens/catalogue_screen.dart';
import '../screens/slip_box_screen.dart';
import '../screens/poll_day_screen.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  
  const CustomBottomNavigationBar({
    super.key,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(child: _buildBottomNavItem(context, 'Report', Icons.trending_up_outlined, 0)),
          Expanded(child: _buildBottomNavItem(context, 'Catalogue', Icons.list_alt_outlined, 1)),
          Expanded(
            child: Center(
              child: _buildHomeButton(context, 2),
            ),
          ),
          Expanded(child: _buildBottomNavItem(context, 'Slip', Icons.inventory_outlined, 3)),
          Expanded(child: _buildBottomNavItem(context, 'Poll', Icons.how_to_vote_outlined, 4)),
        ],
      ),
    );
  }

  Widget _buildBottomNavItem(BuildContext context, String title, IconData icon, int index) {
    bool isSelected = currentIndex == index;
    
    return GestureDetector(
      onTap: () => _navigateToPage(context, index),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 24,
              color: isSelected ? Color(0xFF1976D2) : Colors.black54,
            ),
            const SizedBox(height: 4),
            Text(
              title,
              style: TextStyle(
                fontSize: 10,
                color: isSelected ? Color(0xFF1976D2) : Colors.black54,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHomeButton(BuildContext context, int index) {
    bool isSelected = currentIndex == index;
    
    return GestureDetector(
      onTap: () => _navigateToPage(context, index),
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? Color(0xFF1976D2) : Color(0xFF1976D2),
          shape: BoxShape.circle,
        ),
        child: Icon(
          Icons.home,
          color: Colors.white,
          size: 28,
        ),
      ),
    );
  }

  void _navigateToPage(BuildContext context, int index) {
    switch (index) {
      case 0: // Report
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Report - Coming Soon!'),
            duration: Duration(seconds: 1),
          ),
        );
        break;
      case 1: // Catalogue
        if (currentIndex != 1) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => CatalogueScreen()),
          );
        }
        break;
      case 2: // Home
        if (currentIndex != 2) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => DashboardScreen()),
          );
        }
        break;
      case 3: // Slip
        if (currentIndex != 3) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => SlipBoxScreen()),
          );
        }
        break;
      case 4: // Poll
        if (currentIndex != 4) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => PollDayScreen()),
          );
        }
        break;
    }
  }
}

import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import 'app_banner_screen.dart';
import 'history_screen.dart';
import 'voter_category_screen.dart';
import 'voter_slip_screen.dart';
import 'parties_screen.dart';
import 'religions_screen.dart';
import 'caste_category_screen.dart';
import 'castes_screen.dart';
import 'sub_castes_screen.dart';
import 'voter_language_screen.dart';
import 'schemes_screen.dart';
import 'feedback_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String selectedElection = '119 - Thondamuthur';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
                    AppLocalizations.of(context)?.settings ?? 'Settings',
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
          
          // Main content area with settings grid
          Expanded(
            child: Container(
              color: Colors.white, // White background
              padding: const EdgeInsets.all(20),
              child: GridView.count(
                crossAxisCount: 3,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
                children: [
                  _buildSettingCard(AppLocalizations.of(context)?.setElection ?? 'Set Election', Icons.touch_app, () {
                    _showSetElectionModal();
                  }),
                  _buildSettingCard(AppLocalizations.of(context)?.appBanner ?? 'App Banner', Icons.desktop_windows, () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AppBannerScreen(),
                      ),
                    );
                  }),
                  _buildSettingCard(AppLocalizations.of(context)?.history ?? 'History', Icons.refresh, () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HistoryScreen(),
                      ),
                    );
                  }),
                  _buildSettingCard(AppLocalizations.of(context)?.category ?? 'Category', Icons.dashboard_customize, () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => VoterCategoryScreen(),
                      ),
                    );
                  }),
                  _buildSettingCard(AppLocalizations.of(context)?.voterSlip ?? 'Voter Slip', Icons.receipt_long, () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => VoterSlipScreen(),
                      ),
                    );
                  }),
                  _buildSettingCard(AppLocalizations.of(context)?.party ?? 'Party', Icons.flag, () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PartiesScreen(),
                      ),
                    );
                  }),
                  _buildSettingCard(AppLocalizations.of(context)?.religion ?? 'Religion', Icons.church, () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ReligionsScreen(),
                      ),
                    );
                  }),
                  _buildSettingCard(AppLocalizations.of(context)?.casteCategory ?? 'Caste Category', Icons.pie_chart, () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CasteCategoryScreen(),
                      ),
                    );
                  }),
                  _buildSettingCard(AppLocalizations.of(context)?.caste ?? 'Caste', Icons.pie_chart_outline, () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CastesScreen(),
                      ),
                    );
                  }),
                  _buildSettingCard(AppLocalizations.of(context)?.subCaste ?? 'Sub-Caste', Icons.people, () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SubCastesScreen(),
                      ),
                    );
                  }),
                  _buildSettingCard(AppLocalizations.of(context)?.language ?? 'Language', Icons.language, () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => VoterLanguageScreen(),
                      ),
                    );
                  }),
                  _buildSettingCard(AppLocalizations.of(context)?.schemes ?? 'Schemes', Icons.volunteer_activism, () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SchemesScreen(),
                      ),
                    );
                  }),
                  _buildSettingCard(AppLocalizations.of(context)?.feedback ?? 'Feedback', Icons.feedback, () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FeedbackScreen(),
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),
          
          // Bottom navigation bar
          Container(
            padding: const EdgeInsets.symmetric(vertical: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 4,
                  offset: Offset(0, -2),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildNavItem('Repor', Icons.trending_up_outlined, false),
                _buildNavItem('Catalogu', Icons.list_alt_outlined, false),
                _buildNavItem('Home', Icons.home, true),
                _buildNavItem('Slip', Icons.print_outlined, false),
                _buildNavItem('Poll', Icons.how_to_vote_outlined, false),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingCard(String title, IconData icon, VoidCallback onTap, {bool isDisabled = false}) {
    return GestureDetector(
      onTap: isDisabled ? null : () {
        onTap();
      },
      child: Container(
        decoration: BoxDecoration(
          color: isDisabled ? Colors.grey[100] : Colors.white,
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icon
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: isDisabled 
                    ? Colors.grey[300]!.withValues(alpha: 0.5)
                    : Color(0xFF1976D2).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(25),
              ),
              child: Icon(
                icon,
                size: 28,
                color: isDisabled ? Colors.grey[400] : Color(0xFF1976D2),
              ),
            ),
            const SizedBox(height: 12),
            // Title
            Text(
              title,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: isDisabled ? Colors.grey[400] : Colors.black87,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
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
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: isActive ? Color(0xFF1976D2) : Colors.transparent,
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            size: 24,
            color: isActive ? Colors.white : Colors.black54,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            color: isActive ? Color(0xFF1976D2) : Colors.black54,
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }

  void _showSetElectionModal() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isDismissible: true,
      enableDrag: true,
      builder: (BuildContext context) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Title
              Text(
                'Set Default Election',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 20),

              // Election selection container
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey[300]!),
                ),
                child: Text(
                  selectedElection,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),
              ),
              const SizedBox(height: 30),

              // Update button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Default election updated successfully'),
                        backgroundColor: Color(0xFF1976D2),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF1976D2),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'UPDATE',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),

              // Close button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: OutlinedButton(
                  onPressed: () => Navigator.pop(context),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.black87,
                    side: BorderSide(color: Colors.grey[300]!),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'CLOSE',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }
}

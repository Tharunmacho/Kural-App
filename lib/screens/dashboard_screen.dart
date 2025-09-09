import 'package:flutter/material.dart';
import 'dart:async';
import 'part_numbers_screen.dart';
import 'family_manager_screen.dart';
import 'survey_screen.dart';
import 'notifications_screen.dart';
import 'transgender_screen.dart';
import 'fatherless_screen.dart';
import 'new_voters_screen.dart';
import 'guardian_screen.dart';
import 'birthday_screen.dart';
import 'overseas_screen.dart';
import 'star_screen.dart';
import 'mobile_screen.dart';
import 'above80_screen.dart';
import 'my_cadre_screen.dart';
import 'part_map_screen.dart';
import 'voter_part_numbers_screen.dart';
import 'drawer_screen.dart';
import '../widgets/bottom_navigation_bar.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final TextEditingController _searchController = TextEditingController();
  final PageController _pageController = PageController();
  int _currentPage = 0;
  Timer? _autoSwipeTimer;
  
  // Election dropdown state
  String selectedElection = '119 - Thondamuthur';
  List<String> electionOptions = [
    '119 - Thondamuthur',
    '120 - Annur',
    '121 - Avinashi',
    '122 - Tirupur North',
    '123 - Tirupur South',
    '124 - Kangeyam',
    '125 - Perundurai',
    '126 - Bhavani',
    '127 - Anthiyur',
    '128 - Gobichettipalayam',
    '129 - Bhavanisagar',
    '130 - Erode East',
    '131 - Erode West',
    '132 - Modakurichi',
    '133 - Kavundampalayam',
    '134 - Erode North',
    '135 - Coimbatore North',
    '136 - Coimbatore South',
  ];
  
  // Advanced search controllers
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _partNoController = TextEditingController();
  final TextEditingController _serialNoController = TextEditingController();
  final TextEditingController _epicIdController = TextEditingController();
  final TextEditingController _voterFirstNameController = TextEditingController();
  final TextEditingController _voterLastNameController = TextEditingController();
  final TextEditingController _relationFirstNameController = TextEditingController();
  final TextEditingController _relationLastNameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _startAutoSwipe();
  }

  @override
  void dispose() {
    _autoSwipeTimer?.cancel();
    _pageController.dispose();
    _searchController.dispose();
    _mobileController.dispose();
    _partNoController.dispose();
    _serialNoController.dispose();
    _epicIdController.dispose();
    _voterFirstNameController.dispose();
    _voterLastNameController.dispose();
    _relationFirstNameController.dispose();
    _relationLastNameController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  void _startAutoSwipe() {
    _autoSwipeTimer = Timer.periodic(Duration(seconds: 3), (timer) {
      if (_pageController.hasClients && mounted) {
        int nextPage = (_currentPage + 1) % 2; // 2 pages in carousel
        _pageController.animateToPage(
          nextPage,
          duration: Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  void _resetAutoSwipe() {
    _autoSwipeTimer?.cancel();
    _startAutoSwipe();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F7FA),
      body: SafeArea(
        child: Column(
          children: [
            // Header and Manager cards section with blue background
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Color(0xFFE3F2FD), // Light blue background
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25),
                ),
              ),
              child: Column(
                children: [
                  // Header section
                  Container(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        // Menu icon
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DrawerScreen(),
                              ),
                            );
                          },
                          child: Icon(
                            Icons.menu,
                            size: 28,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(width: 16),
                        // Location dropdown
                        Expanded(
                          child: GestureDetector(
                            onTap: () => _showElectionModal(),
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: Colors.grey[300]!),
                              ),
                              child: Row(
                                children: [
                                  Text(
                                    selectedElection,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  Spacer(),
                                  Icon(
                                    Icons.keyboard_arrow_down,
                                    color: Colors.black54,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        // Notification icon
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => NotificationsScreen(),
                              ),
                            );
                          },
                          child: Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.black87,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Icon(
                              Icons.notifications_outlined,
                              color: Colors.white,
                              size: 24,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  // Manager cards section
                  Container(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 25),
                    child: Row(
                      children: [
                        _buildManagerCard('Cadre\nManager', 'assets/icons/cadre_manager.png'),
                        const SizedBox(width: 12),
                        _buildManagerCard('Voter\nManager', 'assets/icons/voter_manager.png'),
                        const SizedBox(width: 12),
                        _buildManagerCard('Family\nManager', 'assets/icons/family_manager.png'),
                        const SizedBox(width: 12),
                        _buildManagerCard('Survey\nManager', 'assets/icons/survey_manager.png'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            
            // Scrollable content
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    
                    const SizedBox(height: 20),
                    
                    // Search section - outside blue background
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        children: [
                          Expanded(
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
                                  hintText: 'Voter Id or Voter Name',
                                  hintStyle: TextStyle(
                                    color: Colors.grey[400],
                                    fontSize: 16,
                                  ),
                                  prefixIcon: Icon(
                                    Icons.search,
                                    color: Colors.grey[600],
                                    size: 24,
                                  ),
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                                ),
                                onTap: () => _showAdvancedSearch(),
                                readOnly: true,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          GestureDetector(
                            onTap: _showAdvancedSearch,
                            child: Container(
                              padding: EdgeInsets.all(12),
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
                              child: Icon(
                                Icons.tune,
                                color: Colors.grey[600],
                                size: 24,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 20),
                    

                    
                    // Category grid section
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: GridView.count(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        crossAxisCount: 4,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        childAspectRatio: 0.85,
                        children: [
                          _buildCategoryItem('Cadre', 'assets/icons/cadre.png', Color(0xFF2196F3)),
                          _buildCategoryItem('Part', 'assets/icons/part.png', Color(0xFFF44336)),
                          _buildCategoryItem('Voter', 'assets/icons/voter.png', Color(0xFFFF9800)),
                          _buildCategoryItem('New', 'assets/icons/New.png', Color(0xFF4CAF50)),
                          _buildCategoryItem('Transgender', 'assets/icons/transegender.png', Color(0xFFFFEB3B)),
                          _buildCategoryItem('Fatherless', 'assets/icons/fatherless.png', Color(0xFF9C27B0)),
                          _buildCategoryItem('Guardian', 'assets/icons/guardian.png', Color(0xFF00BCD4)),
                          _buildCategoryItem('Overseas', 'assets/icons/overseas.png', Color(0xFF607D8B)),
                          _buildCategoryItem('Birthday', 'assets/icons/birthday.png', Color(0xFFE91E63)),
                          _buildCategoryItem('Star', 'assets/icons/star.png', Color(0xFFFF5722)),
                          _buildCategoryItem('Mobile', 'assets/icons/Mobile.png', Color(0xFF3F51B5)),
                          _buildCategoryItem('80 Above', 'assets/icons/80 Above.png', Color(0xFF795548)),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 20),
                    
                    // Image carousel section
                    SizedBox(
                      height: 200,
                      child: PageView(
                        controller: _pageController,
                        onPageChanged: (index) {
                          setState(() {
                            _currentPage = index;
                          });
                          // Reset auto-swipe timer when user manually swipes
                          _resetAutoSwipe();
                        },
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 16),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  Color(0xFF1976D2),
                                  Color(0xFF42A5F5),
                                ],
                              ),
                            ),
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.campaign,
                                    size: 48,
                                    color: Colors.white,
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    'Political Meeting',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 16),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  Color(0xFF4CAF50),
                                  Color(0xFF66BB6A),
                                ],
                              ),
                            ),
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.people,
                                    size: 48,
                                    color: Colors.white,
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    'Community Event',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 12),
                    
                    // Page indicator
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _currentPage == 0 ? Color(0xFF1976D2) : Colors.grey[300],
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _currentPage == 1 ? Color(0xFF1976D2) : Colors.grey[300],
                          ),
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 20),
                    
                    // Cadre Overview section
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Cadre Overview',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Large Total Cadres card on the left
                              Expanded(
                                flex: 2,
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => MyCadreScreen()),
                                    );
                                  },
                                  child: _buildLargeStatCard(
                                    'Total\nCadres',
                                    '0',
                                    Color(0xFF1976D2),
                                    Icons.directions_walk,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              // 2x2 grid of smaller cards on the right
                              Expanded(
                                flex: 3,
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(builder: (context) => MyCadreScreen()),
                                              );
                                            },
                                            child: _buildStatCard(
                                              'Cadre\nActive',
                                              '0',
                                              Color(0xFF4CAF50),
                                              null,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 12),
                                        Expanded(
                                          child: GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(builder: (context) => MyCadreScreen()),
                                              );
                                            },
                                            child: _buildStatCard(
                                              'Cadre\nInActive',
                                              '0',
                                              Color(0xFFF44336),
                                              null,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 12),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: _buildStatCard(
                                            'Logged\nIn',
                                            '0',
                                            Color(0xFF4CAF50),
                                            null,
                                          ),
                                        ),
                                        const SizedBox(width: 12),
                                        Expanded(
                                          child: _buildStatCard(
                                            'Not\nLogged',
                                            '0',
                                            Color(0xFFF44336),
                                            null,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
            
            // Bottom navigation
            CustomBottomNavigationBar(currentIndex: 2), // 2 = Home index
          ],
        ),
      ),
    );
  }

  Widget _buildManagerCard(String title, String iconPath) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          if (title == 'Cadre\nManager') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MyCadreScreen()),
            );
          } else if (title == 'Voter\nManager') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PartNumbersScreen()),
            );
          } else if (title == 'Family\nManager') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => FamilyManagerScreen()),
            );
          } else if (title == 'Survey\nManager') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SurveyScreen()),
            );
          } else {
            // Show coming soon message for other managers
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('$title - Coming Soon!'),
                duration: Duration(seconds: 2),
              ),
            );
          }
        },
        child: Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Color(0xFF1976D2), width: 1.5),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                iconPath,
                width: 32,
                height: 32,
                color: Colors.black,
              ),
              const SizedBox(height: 6),
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                  height: 1.2,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryItem(String title, String iconPath, Color color) {
    return GestureDetector(
      onTap: () {
        // Handle navigation for different categories
        if (title == 'Cadre') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MyCadreScreen()),
          );
        } else if (title == 'Voter') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => VoterPartNumbersScreen()),
          );
        } else if (title == 'New') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => NewVotersScreen()),
          );
        } else if (title == 'Part') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PartMapScreen()),
          );
        } else if (title == 'Transgender') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => TransgenderScreen()),
          );
        } else if (title == 'Fatherless') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => FatherlessScreen()),
          );
        } else if (title == 'Guardian') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => GuardianScreen()),
          );
        } else if (title == 'Birthday') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => BirthdayScreen()),
          );
        } else if (title == 'Overseas') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => OverseasScreen()),
          );
        } else if (title == 'Star') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => StarScreen()),
          );
        } else if (title == 'Mobile') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MobileScreen()),
          );
        } else if (title == '80 Above') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Above80Screen()),
          );
        } else {
          // Show coming soon message for other categories
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('$title - Coming Soon!'),
              duration: Duration(seconds: 2),
            ),
          );
        }
      },
      child: Column(
        children: [
          Image.asset(
            iconPath,
            width: 60,
            height: 60,
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) {
              return Icon(
                Icons.image_not_supported,
                size: 60,
                color: color,
              );
            },
          ),
          const SizedBox(height: 8),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, Color color, IconData? icon) {
    return Container(
      constraints: BoxConstraints(
        minHeight: 100,
        maxHeight: 130,
      ),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null)
            Icon(
              icon,
              size: 24,
              color: color,
            )
          else
            SizedBox(height: 24), // Consistent spacing for cards without icons
          
          Flexible(
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 11,
                color: Colors.black54,
                fontWeight: FontWeight.w500,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Center(
              child: Text(
                value,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLargeStatCard(String title, String value, Color color, IconData? icon) {
    return Container(
      height: 220, // Taller to match the 2x2 grid height
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (icon != null) ...[
            Icon(
              icon,
              size: 48,
              color: color,
            ),
            const SizedBox(height: 16),
          ],
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: Colors.black54,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text(
                value,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }


  void _showElectionModal() {
    String tempSelectedElection = selectedElection;
    
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isDismissible: false,
      enableDrag: false,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setModalState) => Container(
            height: MediaQuery.of(context).size.height * 0.7,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            padding: EdgeInsets.all(24),
            child: Column(
              children: [
                Text(
                  'Set Default Election',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 30),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey[300]!),
                  ),
                  child: DropdownButtonFormField<String>(
                    value: tempSelectedElection,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                    ),
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black87,
                    ),
                    icon: Icon(
                      Icons.keyboard_arrow_down,
                      color: Colors.black54,
                    ),
                    items: electionOptions.map((String election) {
                      return DropdownMenuItem<String>(
                        value: election,
                        child: Text(
                          election,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black87,
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setModalState(() {
                        tempSelectedElection = newValue!;
                      });
                    },
                  ),
                ),
                const SizedBox(height: 30),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        selectedElection = tempSelectedElection;
                      });
                      Navigator.pop(context);
                      _showMessage('Election updated to $tempSelectedElection');
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
                      'UPDATE',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.black87,
                      side: BorderSide(color: Colors.grey[300]!),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'CLOSE',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 2),
        backgroundColor: Color(0xFF1976D2),
      ),
    );
  }



  void _showAdvancedSearch() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.8,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'Advance Search',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Icon(Icons.close, size: 24),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              _buildSearchField('Mobile No', _mobileController),
              const SizedBox(height: 16),
              _buildSearchField('PartNo', _partNoController),
              const SizedBox(height: 16),
              _buildSearchField('Serial No', _serialNoController),
              const SizedBox(height: 16),
              _buildSearchField('EPIC Id', _epicIdController),
              const SizedBox(height: 16),
              _buildSearchField('Voter First Name', _voterFirstNameController),
              const SizedBox(height: 16),
              _buildSearchField('Voter Last Name', _voterLastNameController),
              const SizedBox(height: 16),
              _buildSearchField('Relation First Name', _relationFirstNameController),
              const SizedBox(height: 16),
              _buildSearchField('Relation Last Name', _relationLastNameController),
              const SizedBox(height: 16),
              _buildSearchField('Age', _ageController),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.grey[700],
                        side: BorderSide(color: Colors.grey[300]!),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text('Cancel'),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Search functionality implemented!')),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF1976D2),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text('Search'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchField(String label, TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Color(0xFF1976D2)),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
    );
  }

}

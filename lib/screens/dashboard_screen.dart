import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../l10n/app_localizations.dart';
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
  List<String> _bannerImages = [];
  bool _isLoadingBanners = true;
  
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
    _loadBannerImages();
    _startAutoSwipe();
  }

  Future<void> _loadBannerImages() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final bannerImagesJson = prefs.getString('banner_images') ?? '[]';
      final List<dynamic> bannerImagesList = json.decode(bannerImagesJson);
      
      setState(() {
        _bannerImages = bannerImagesList.cast<String>();
        _isLoadingBanners = false;
      });
      // Restart auto swipe with new banner count
      _resetAutoSwipe();
    } catch (e) {
      debugPrint('Error loading banner images: $e');
      setState(() {
        _isLoadingBanners = false;
      });
    }
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
      if (_pageController.hasClients && mounted && !_isLoadingBanners) {
        int totalPages = _bannerImages.isNotEmpty ? _bannerImages.length : 2; // Fallback to 2 default pages
        int nextPage = (_currentPage + 1) % totalPages;
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
                    padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.04),
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
                            size: MediaQuery.of(context).size.width * 0.07,
                            color: Colors.black87,
                          ),
                        ),
                        SizedBox(width: MediaQuery.of(context).size.width * 0.04),
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
                        SizedBox(width: MediaQuery.of(context).size.width * 0.04),
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
                            padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
                            decoration: BoxDecoration(
                              color: Colors.black87,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Icon(
                              Icons.notifications_outlined,
                              color: Colors.white,
                              size: MediaQuery.of(context).size.width * 0.06,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  // Manager cards section
                  Container(
                    padding: EdgeInsets.fromLTRB(
                      MediaQuery.of(context).size.width * 0.04,
                      0,
                      MediaQuery.of(context).size.width * 0.04,
                      MediaQuery.of(context).size.height * 0.03,
                    ),
                    child: IntrinsicHeight(
                      child: Row(
                        children: [
                          _buildManagerCard(AppLocalizations.of(context)?.cadreManager ?? 'Cadre\nManager', 'assets/icons/cadre_manager.png', 'cadre'),
                          SizedBox(width: MediaQuery.of(context).size.width * 0.03),
                          _buildManagerCard(AppLocalizations.of(context)?.voterManager ?? 'Voter\nManager', 'assets/icons/voter_manager.png', 'voter'),
                          SizedBox(width: MediaQuery.of(context).size.width * 0.03),
                          _buildManagerCard(AppLocalizations.of(context)?.familyManager ?? 'Family\nManager', 'assets/icons/family_manager.png', 'family'),
                          SizedBox(width: MediaQuery.of(context).size.width * 0.03),
                          _buildManagerCard(AppLocalizations.of(context)?.surveyManager ?? 'Survey\nManager', 'assets/icons/survey_manager.png', 'survey'),
                        ],
                      ),
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
                    
                    SizedBox(height: MediaQuery.of(context).size.height * 0.025),
                    
                    // Search section - outside blue background
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.04,
                      ),
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
                                  hintText: AppLocalizations.of(context)?.searchPlaceholder ?? 'Voter Id or Voter Name',
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
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: MediaQuery.of(context).size.width * 0.05,
                                    vertical: MediaQuery.of(context).size.height * 0.018,
                                  ),
                                ),
                                onTap: () => _showAdvancedSearch(),
                                readOnly: true,
                              ),
                            ),
                          ),
                                        SizedBox(width: MediaQuery.of(context).size.width * 0.02),
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
                    
                    SizedBox(height: MediaQuery.of(context).size.height * 0.025),
                    

                    
                    // Category grid section
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.04,
                      ),
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          double screenWidth = constraints.maxWidth;
                          int crossAxisCount = screenWidth > 600 ? 6 : 4;
                          double spacing = screenWidth * 0.02;
                          double aspectRatio = screenWidth > 600 ? 0.9 : 0.85;
                          
                          return GridView.count(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            crossAxisCount: crossAxisCount,
                            crossAxisSpacing: spacing,
                            mainAxisSpacing: spacing,
                            childAspectRatio: aspectRatio,
                        children: [
                          _buildCategoryItem(AppLocalizations.of(context)?.cadre ?? 'Cadre', 'assets/icons/cadre.png', Color(0xFF2196F3), 'cadre'),
                          _buildCategoryItem(AppLocalizations.of(context)?.part ?? 'Part', 'assets/icons/part.png', Color(0xFFF44336), 'part'),
                          _buildCategoryItem(AppLocalizations.of(context)?.voter ?? 'Voter', 'assets/icons/voter.png', Color(0xFFFF9800), 'voter'),
                          _buildCategoryItem(AppLocalizations.of(context)?.newVoters ?? 'New', 'assets/icons/New.png', Color(0xFF4CAF50), 'new'),
                          _buildCategoryItem(AppLocalizations.of(context)?.transgender ?? 'Transgender', 'assets/icons/transegender.png', Color(0xFFFFEB3B), 'transgender'),
                          _buildCategoryItem(AppLocalizations.of(context)?.fatherless ?? 'Fatherless', 'assets/icons/fatherless.png', Color(0xFF9C27B0), 'fatherless'),
                          _buildCategoryItem(AppLocalizations.of(context)?.guardian ?? 'Guardian', 'assets/icons/guardian.png', Color(0xFF00BCD4), 'guardian'),
                          _buildCategoryItem(AppLocalizations.of(context)?.overseas ?? 'Overseas', 'assets/icons/overseas.png', Color(0xFF607D8B), 'overseas'),
                          _buildCategoryItem(AppLocalizations.of(context)?.birthday ?? 'Birthday', 'assets/icons/birthday.png', Color(0xFFE91E63), 'birthday'),
                          _buildCategoryItem(AppLocalizations.of(context)?.star ?? 'Star', 'assets/icons/star.png', Color(0xFFFF5722), 'star'),
                          _buildCategoryItem(AppLocalizations.of(context)?.mobile ?? 'Mobile', 'assets/icons/Mobile.png', Color(0xFF3F51B5), 'mobile'),
                          _buildCategoryItem(AppLocalizations.of(context)?.above80 ?? '80 Above', 'assets/icons/80 Above.png', Color(0xFF795548), 'above80'),
                            ],
                          );
                        },
                      ),
                    ),
                    
                    SizedBox(height: MediaQuery.of(context).size.height * 0.025),
                    
                    // Image carousel section
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.25,
                      child: _isLoadingBanners
                          ? Center(
                              child: CircularProgressIndicator(
                                color: Color(0xFF1976D2),
                              ),
                            )
                          : PageView(
                              controller: _pageController,
                              onPageChanged: (index) {
                                setState(() {
                                  _currentPage = index;
                                });
                                // Reset auto-swipe timer when user manually swipes
                                _resetAutoSwipe();
                              },
                              children: _bannerImages.isNotEmpty
                                  ? _bannerImages.map((imagePath) {
                                      return Container(
                                        margin: EdgeInsets.symmetric(
                                          horizontal: MediaQuery.of(context).size.width * 0.04,
                                        ),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(12),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black.withValues(alpha: 0.1),
                                              blurRadius: 8,
                                              offset: Offset(0, 2),
                                            ),
                                          ],
                                        ),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(12),
                                          child: Image.file(
                                            File(imagePath),
                                            fit: BoxFit.cover,
                                            width: double.infinity,
                                            errorBuilder: (context, error, stackTrace) {
                                              return Container(
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(12),
                                                  gradient: LinearGradient(
                                                    begin: Alignment.topLeft,
                                                    end: Alignment.bottomRight,
                                                    colors: [
                                                      Color(0xFFE57373),
                                                      Color(0xFFEF5350),
                                                    ],
                                                  ),
                                                ),
                                                child: Center(
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      Icon(
                                                        Icons.broken_image,
                                                        size: MediaQuery.of(context).size.width * 0.1,
                                                        color: Colors.white,
                                                      ),
                                                      SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                                                      Text(
                                                        'Image not found',
                                                        style: TextStyle(
                                                          fontSize: MediaQuery.of(context).size.width * 0.04,
                                                          fontWeight: FontWeight.bold,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      );
                                    }).toList()
                                  : [
                                      // Default banners when no images are uploaded
                                      Container(
                                        margin: EdgeInsets.symmetric(
                                          horizontal: MediaQuery.of(context).size.width * 0.04,
                                        ),
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
                                                size: MediaQuery.of(context).size.width * 0.12,
                                                color: Colors.white,
                                              ),
                                              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                                              Text(
                                                AppLocalizations.of(context)?.politicalMeeting ?? 'Political Meeting',
                                                style: TextStyle(
                                                  fontSize: MediaQuery.of(context).size.width * 0.045,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.symmetric(
                                          horizontal: MediaQuery.of(context).size.width * 0.04,
                                        ),
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
                                                size: MediaQuery.of(context).size.width * 0.12,
                                                color: Colors.white,
                                              ),
                                              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                                              Text(
                                                'Community Event',
                                                style: TextStyle(
                                                  fontSize: MediaQuery.of(context).size.width * 0.045,
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
                    if (!_isLoadingBanners)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          _bannerImages.isNotEmpty ? _bannerImages.length : 2,
                          (index) => Container(
                            margin: EdgeInsets.symmetric(horizontal: 4),
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: _currentPage == index ? Color(0xFF1976D2) : Colors.grey[300],
                            ),
                          ),
                        ),
                      ),
                    
                    SizedBox(height: MediaQuery.of(context).size.height * 0.025),
                    
                    // Cadre Overview section
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.04,
                        vertical: MediaQuery.of(context).size.height * 0.01,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppLocalizations.of(context)?.cadreOverview ?? 'Cadre Overview',
                            style: TextStyle(
                              fontSize: MediaQuery.of(context).size.width * 0.055,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          SizedBox(height: MediaQuery.of(context).size.height * 0.018),
                          IntrinsicHeight(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                // Large Total Cadres card on the left
                                Expanded(
                                  flex: 1,
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => MyCadreScreen()),
                                      );
                                    },
                                    child: _buildTotalCadresCard(
                                      AppLocalizations.of(context)?.totalCadres ?? 'Total\nCadres',
                                      '0',
                                      Color(0xFF1976D2),
                                      Icons.directions_walk,
                                    ),
                                  ),
                                ),
                                SizedBox(width: MediaQuery.of(context).size.width * 0.03),
                                // 2x2 grid of smaller cards on the right
                                Expanded(
                                  flex: 2,
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
                                                AppLocalizations.of(context)?.cadreActive ?? 'Cadre\nActive',
                                                '0',
                                                Color(0xFF4CAF50),
                                                null,
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: MediaQuery.of(context).size.width * 0.02),
                                          Expanded(
                                            child: GestureDetector(
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(builder: (context) => MyCadreScreen()),
                                                );
                                              },
                                              child: _buildStatCard(
                                                AppLocalizations.of(context)?.cadreInActive ?? 'Cadre\nInActive',
                                                '0',
                                                Color(0xFFF44336),
                                                null,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: _buildStatCard(
                                              AppLocalizations.of(context)?.loggedIn ?? 'Logged\nIn',
                                              '0',
                                              Color(0xFF4CAF50),
                                              null,
                                            ),
                                          ),
                                          SizedBox(width: MediaQuery.of(context).size.width * 0.02),
                                          Expanded(
                                            child: _buildStatCard(
                                              AppLocalizations.of(context)?.notLogged ?? 'Not\nLogged',
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
                          ),
                        ],
                      ),
                    ),
                    
                    SizedBox(height: MediaQuery.of(context).size.height * 0.025),
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

  Widget _buildManagerCard(String title, String iconPath, String managerId) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          switch (managerId) {
            case 'cadre':
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyCadreScreen()),
              );
              break;
            case 'voter':
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PartNumbersScreen()),
              );
              break;
            case 'family':
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FamilyManagerScreen()),
              );
              break;
            case 'survey':
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SurveyScreen()),
              );
              break;
            default:
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
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height * 0.1,
            maxHeight: MediaQuery.of(context).size.height * 0.12,
          ),
          padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.03),
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
                width: MediaQuery.of(context).size.width * 0.08,
                height: MediaQuery.of(context).size.width * 0.08,
                color: Colors.black,
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              Flexible(
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.028,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                    height: 1.2,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryItem(String title, String iconPath, Color color, String categoryId) {
    return GestureDetector(
      onTap: () {
        // Handle navigation for different categories using ID
        switch (categoryId) {
          case 'cadre':
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MyCadreScreen()),
            );
            break;
          case 'voter':
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => VoterPartNumbersScreen()),
            );
            break;
          case 'new':
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NewVotersScreen()),
            );
            break;
          case 'part':
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PartMapScreen()),
            );
            break;
          case 'transgender':
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => TransgenderScreen()),
            );
            break;
          case 'fatherless':
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => FatherlessScreen()),
            );
            break;
          case 'guardian':
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => GuardianScreen()),
            );
            break;
          case 'birthday':
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => BirthdayScreen()),
            );
            break;
          case 'overseas':
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => OverseasScreen()),
            );
            break;
          case 'star':
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => StarScreen()),
            );
            break;
          case 'mobile':
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MobileScreen()),
            );
            break;
          case 'above80':
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Above80Screen()),
            );
            break;
          default:
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
          const SizedBox(height: 6),
          Flexible(
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
                height: 1.1,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, Color color, IconData? icon) {
    return Container(
      constraints: BoxConstraints(
        minHeight: MediaQuery.of(context).size.height * 0.09,
        maxHeight: MediaQuery.of(context).size.height * 0.11,
      ),
      padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
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
          // Remove icon space for these cards since they don't have icons
          if (icon != null)
            Icon(
              icon,
              size: MediaQuery.of(context).size.width * 0.05,
              color: color,
            )
          else
            SizedBox(height: MediaQuery.of(context).size.height * 0.005), // Minimal spacing
          
          Flexible(
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width * 0.028,
                color: Colors.black54,
                fontWeight: FontWeight.w500,
                height: 1.1,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          
          SizedBox(height: MediaQuery.of(context).size.height * 0.005),
          
          Container(
            width: MediaQuery.of(context).size.width * 0.07,
            height: MediaQuery.of(context).size.width * 0.07,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Center(
              child: Text(
                value,
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.035,
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

  Widget _buildTotalCadresCard(String title, String value, Color color, IconData? icon) {
    return Container(
      padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.04),
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
              size: MediaQuery.of(context).size.width * 0.08,
              color: color,
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.01),
          ],
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.width * 0.035,
              color: Colors.black54,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.015),
          Container(
            width: MediaQuery.of(context).size.width * 0.12,
            height: MediaQuery.of(context).size.width * 0.12,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text(
                value,
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.05,
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
                  AppLocalizations.of(context)?.setDefaultElection ?? 'Set Default Election',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.035),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey[300]!),
                  ),
                  child: DropdownButtonFormField<String>(
                    initialValue: tempSelectedElection,
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
                SizedBox(height: MediaQuery.of(context).size.height * 0.035),
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
                      AppLocalizations.of(context)?.update ?? 'UPDATE',
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
                      AppLocalizations.of(context)?.close ?? 'CLOSE',
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
          padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Fixed header
              Row(
                children: [
                  Text(
                    'Advance Search',
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.045,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Icon(
                      Icons.close, 
                      size: MediaQuery.of(context).size.width * 0.06,
                    ),
                  ),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              
              // Scrollable content
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      _buildSearchField('Mobile No', _mobileController),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.015),
                      _buildSearchField('PartNo', _partNoController),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.015),
                      _buildSearchField('Serial No', _serialNoController),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.015),
                      _buildSearchField('EPIC Id', _epicIdController),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.015),
                      _buildSearchField('Voter First Name', _voterFirstNameController),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.015),
                      _buildSearchField('Voter Last Name', _voterLastNameController),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.015),
                      _buildSearchField('Relation First Name', _relationFirstNameController),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.015),
                      _buildSearchField('Relation Last Name', _relationLastNameController),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.015),
                      _buildSearchField('Age', _ageController),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                    ],
                  ),
                ),
              ),
              
              // Fixed bottom buttons
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
                        padding: EdgeInsets.symmetric(
                          vertical: MediaQuery.of(context).size.height * 0.018,
                        ),
                      ),
                      child: Text('Cancel'),
                    ),
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.04),
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
                        padding: EdgeInsets.symmetric(
                          vertical: MediaQuery.of(context).size.height * 0.018,
                        ),
                      ),
                      child: Text(AppLocalizations.of(context)?.search ?? 'Search'),
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
        contentPadding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.04,
          vertical: MediaQuery.of(context).size.height * 0.015,
        ),
      ),
    );
  }

}

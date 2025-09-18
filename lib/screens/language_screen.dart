import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/language_provider.dart';
import '../l10n/app_localizations.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  String selectedLanguage = 'Englis';

  @override
  void initState() {
    super.initState();
    // Initialize with current language from provider
    WidgetsBinding.instance.addPostFrameCallback((_) {
      try {
        final languageProvider = Provider.of<LanguageProvider>(context, listen: false);
        setState(() {
          selectedLanguage = languageProvider.getCurrentLanguageName();
        });
        debugPrint('Language screen initialized with: $selectedLanguage');
      } catch (e) {
        debugPrint('Error initializing language screen: $e');
      }
    });
  }

  final List<Map<String, String>> languages = [
    {'name': 'Englis', 'character': 'A'},
    {'name': 'Hind', 'character': 'क'},
    {'name': 'Tami', 'character': 'அ'},
    {'name': 'Telug', 'character': 'ల'},
    {'name': 'Kannad', 'character': 'ಹ'},
    {'name': 'Malayala', 'character': 'സ'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Header with logo
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 30),
              child: Column(
                children: [
                  // Login Logo
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: ClipOval(
                      child: Image.asset(
                        'assets/icons/Login_sign.png',
                        width: 120,
                        height: 120,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          debugPrint('Error loading Login_sign.png: $error');
                          return Container(
                            width: 120,
                            height: 120,
                            decoration: BoxDecoration(
                              color: Color(0xFF1976D2),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.language,
                              size: 60,
                              color: Colors.white,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  // Title
                  Text(
                    AppLocalizations.of(context)?.chooseLanguage ?? 'Choose Language',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
            
            // Language selection grid
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                    childAspectRatio: 1.0,
                  ),
                  itemCount: languages.length,
                  itemBuilder: (context, index) {
                    final language = languages[index];
                    final isSelected = selectedLanguage == language['name'];
                    
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedLanguage = language['name']!;
                        });
                        debugPrint('Language selected: ${language['name']}');
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: isSelected ? Colors.green : Color(0xFF1976D2).withValues(alpha: 0.3),
                            width: isSelected ? 3 : 2,
                          ),
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
                            // Language character
                            Text(
                              language['character']!,
                              style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[700],
                              ),
                            ),
                            SizedBox(height: 8),
                            // Language name
                            Text(
                              language['name']!,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            
            // Submit button
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(30),
              child: ElevatedButton(
                onPressed: () async {
                  debugPrint('Submit button pressed with selectedLanguage: $selectedLanguage');
                  
                  // Handle language selection
                  final languageProvider = Provider.of<LanguageProvider>(context, listen: false);
                  final navigator = Navigator.of(context);
                  final scaffoldMessenger = ScaffoldMessenger.of(context);
                  
                  debugPrint('Current locale before change: ${languageProvider.currentLocale}');
                  await languageProvider.changeLanguage(selectedLanguage);
                  debugPrint('Current locale after change: ${languageProvider.currentLocale}');
                  
                  // Show a confirmation snackbar
                  if (mounted) {
                    scaffoldMessenger.showSnackBar(
                      SnackBar(
                        content: Text('Language changed successfully!'),
                        backgroundColor: Colors.green,
                        duration: Duration(seconds: 2),
                      ),
                    );
                  }
                  
                  navigator.pop(selectedLanguage);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  AppLocalizations.of(context)?.submit ?? 'Submit',
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
    );
  }
}

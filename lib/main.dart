import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'providers/language_provider.dart';
import 'screens/login_screen.dart';
import 'screens/dashboard_screen.dart';
import 'l10n/app_localizations.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // Configure Firestore settings for better connectivity
  FirebaseFirestore.instance.settings = const Settings(
    persistenceEnabled: true,
    cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED,
  );

  // App verification is enabled for real OTP functionality

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LanguageProvider()..initialize(),
      child: Consumer<LanguageProvider>(
        builder: (context, languageProvider, child) {
          debugPrint('Consumer builder called with locale: ${languageProvider.currentLocale}');
          return MaterialApp(
            title: 'Thedal Election Analytics Manager',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(
                seedColor: const Color(0xFF1A237E),
                primary: const Color(0xFF1A237E),
              ),
              useMaterial3: true,
            ),
            // Localization configuration
            localizationsDelegates: [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: LanguageProvider.getSupportedLocales(),
            locale: languageProvider.currentLocale,
            home: const RootRouter(),
            routes: {
              '/login': (context) => const LoginScreen(),
            },
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}

class RootRouter extends StatelessWidget {
  const RootRouter({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        // While Firebase restores the auth state on app start
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final user = snapshot.data;
        if (user != null) {
          // User is signed in; go straight to Dashboard and keep it as root
          return const DashboardScreen();
        }
        // Not signed in; show Login
        return const LoginScreen();
      },
    );
  }
}

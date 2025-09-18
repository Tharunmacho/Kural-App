import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_hi.dart';
import 'app_localizations_kn.dart';
import 'app_localizations_ml.dart';
import 'app_localizations_ta.dart';
import 'app_localizations_te.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('hi'),
    Locale('kn'),
    Locale('ml'),
    Locale('ta'),
    Locale('te'),
  ];

  /// Language selection screen title
  ///
  /// In en, this message translates to:
  /// **'Choose Language'**
  String get chooseLanguage;

  /// Submit button
  ///
  /// In en, this message translates to:
  /// **'Submit'**
  String get submit;

  /// Dashboard screen title
  ///
  /// In en, this message translates to:
  /// **'Dashboard'**
  String get dashboard;

  /// Profile screen title
  ///
  /// In en, this message translates to:
  /// **'My Profile'**
  String get profile;

  /// Election screen title
  ///
  /// In en, this message translates to:
  /// **'Election'**
  String get election;

  /// Election management title
  ///
  /// In en, this message translates to:
  /// **'Election Management'**
  String get electionManagement;

  /// View election screen title
  ///
  /// In en, this message translates to:
  /// **'View Election'**
  String get viewElection;

  /// Settings title
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// Sign out button text
  ///
  /// In en, this message translates to:
  /// **'Sign Out'**
  String get signOut;

  /// Save button
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// Edit button text
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// First Name field label
  ///
  /// In en, this message translates to:
  /// **'First Name'**
  String get firstName;

  /// Last Name field label
  ///
  /// In en, this message translates to:
  /// **'Last Name'**
  String get lastName;

  /// Email field label
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// Mobile Number field label
  ///
  /// In en, this message translates to:
  /// **'Mobile Number'**
  String get mobileNumber;

  /// Role field label
  ///
  /// In en, this message translates to:
  /// **'Role'**
  String get role;

  /// App Language menu item
  ///
  /// In en, this message translates to:
  /// **'App Language'**
  String get appLanguage;

  /// Change password menu item
  ///
  /// In en, this message translates to:
  /// **'Change Password'**
  String get changePassword;

  /// Privacy policy menu item
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyPolicy;

  /// Help title
  ///
  /// In en, this message translates to:
  /// **'Help'**
  String get help;

  /// Cadre Manager title
  ///
  /// In en, this message translates to:
  /// **'Cadre Manager'**
  String get cadreManager;

  /// Voter Manager title
  ///
  /// In en, this message translates to:
  /// **'Voter Manager'**
  String get voterManager;

  /// Family Manager title
  ///
  /// In en, this message translates to:
  /// **'Family Manager'**
  String get familyManager;

  /// Survey Manager title
  ///
  /// In en, this message translates to:
  /// **'Survey Manager'**
  String get surveyManager;

  /// Search input placeholder text
  ///
  /// In en, this message translates to:
  /// **'Voter Id or Voter Name'**
  String get searchPlaceholder;

  /// Cadre category
  ///
  /// In en, this message translates to:
  /// **'Cadre'**
  String get cadre;

  /// Part label
  ///
  /// In en, this message translates to:
  /// **'Part'**
  String get part;

  /// Voter category
  ///
  /// In en, this message translates to:
  /// **'Voter'**
  String get voter;

  /// New label
  ///
  /// In en, this message translates to:
  /// **'New'**
  String get newVoters;

  /// Transgender category
  ///
  /// In en, this message translates to:
  /// **'Transgender'**
  String get transgender;

  /// Fatherless category
  ///
  /// In en, this message translates to:
  /// **'Fatherless'**
  String get fatherless;

  /// Guardian category
  ///
  /// In en, this message translates to:
  /// **'Guardian'**
  String get guardian;

  /// Overseas category
  ///
  /// In en, this message translates to:
  /// **'Overseas'**
  String get overseas;

  /// Birthday category
  ///
  /// In en, this message translates to:
  /// **'Birthday'**
  String get birthday;

  /// Star category
  ///
  /// In en, this message translates to:
  /// **'Star'**
  String get star;

  /// Mobile category
  ///
  /// In en, this message translates to:
  /// **'Mobile'**
  String get mobile;

  /// Above 80 category
  ///
  /// In en, this message translates to:
  /// **'Above 80'**
  String get above80;

  /// Report tab
  ///
  /// In en, this message translates to:
  /// **'Report'**
  String get report;

  /// Catalogue title
  ///
  /// In en, this message translates to:
  /// **'Catalogue'**
  String get catalogue;

  /// Home bottom nav
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// Slip tab
  ///
  /// In en, this message translates to:
  /// **'Slip'**
  String get slip;

  /// Poll tab
  ///
  /// In en, this message translates to:
  /// **'Poll'**
  String get poll;

  /// Search
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// Loading text
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get loading;

  /// Error text
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get error;

  /// Success text
  ///
  /// In en, this message translates to:
  /// **'Success'**
  String get success;

  /// Cancel button
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// Confirm button
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirm;

  /// Delete button
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// Back button
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// Next button
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// Done button
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get done;

  /// Yes button
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get yes;

  /// No button
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get no;

  /// OK button
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get ok;

  /// Close button
  ///
  /// In en, this message translates to:
  /// **'CLOSE'**
  String get close;

  /// Notifications title
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications;

  /// About title
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get about;

  /// Logout button
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// Login button
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// Password field
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// Username field
  ///
  /// In en, this message translates to:
  /// **'Username'**
  String get username;

  /// Name field
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name;

  /// Address field
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get address;

  /// Phone field
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get phone;

  /// Date field
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get date;

  /// Time field
  ///
  /// In en, this message translates to:
  /// **'Time'**
  String get time;

  /// Total text
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get total;

  /// Active status
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get active;

  /// Inactive status
  ///
  /// In en, this message translates to:
  /// **'Inactive'**
  String get inactive;

  /// Male gender
  ///
  /// In en, this message translates to:
  /// **'Male'**
  String get male;

  /// Female gender
  ///
  /// In en, this message translates to:
  /// **'Female'**
  String get female;

  /// Coming soon message
  ///
  /// In en, this message translates to:
  /// **'Coming Soon!'**
  String get comingSoon;

  /// Profile update success message
  ///
  /// In en, this message translates to:
  /// **'Profile updated successfully!'**
  String get profileUpdatedSuccessfully;

  /// Profile saved offline message
  ///
  /// In en, this message translates to:
  /// **'Profile saved locally. Will sync when online.'**
  String get profileSavedLocally;

  /// Profile save error message
  ///
  /// In en, this message translates to:
  /// **'Error saving profile'**
  String get errorSavingProfile;

  /// Mobile number readonly message
  ///
  /// In en, this message translates to:
  /// **'Mobile number cannot be changed'**
  String get mobileNumberCannotBeChanged;

  /// Your Elections menu item
  ///
  /// In en, this message translates to:
  /// **'Your Elections'**
  String get yourElections;

  /// Terms and Conditions menu item
  ///
  /// In en, this message translates to:
  /// **'Terms & Conditions'**
  String get termsConditions;

  /// Logout confirmation message
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to logout?'**
  String get logoutConfirmation;

  /// Logout success message
  ///
  /// In en, this message translates to:
  /// **'Logged out successfully'**
  String get loggedOutSuccessfully;

  /// Search placeholder text
  ///
  /// In en, this message translates to:
  /// **'Search by EPIC number or name'**
  String get searchByEpicOrName;

  /// No friends found message
  ///
  /// In en, this message translates to:
  /// **'No friends Found'**
  String get noFriendsFound;

  /// Friends label
  ///
  /// In en, this message translates to:
  /// **'Friends'**
  String get friends;

  /// Mother relationship
  ///
  /// In en, this message translates to:
  /// **'Mother'**
  String get mother;

  /// Door number label
  ///
  /// In en, this message translates to:
  /// **'Door No'**
  String get doorNo;

  /// Voter name field
  ///
  /// In en, this message translates to:
  /// **'Voter Name'**
  String get voterName;

  /// Age field
  ///
  /// In en, this message translates to:
  /// **'Age'**
  String get age;

  /// Gender field
  ///
  /// In en, this message translates to:
  /// **'Gender'**
  String get gender;

  /// Relation field
  ///
  /// In en, this message translates to:
  /// **'Relation'**
  String get relation;

  /// EPIC ID field label
  ///
  /// In en, this message translates to:
  /// **'EPIC Id'**
  String get epicId;

  /// Part number field label
  ///
  /// In en, this message translates to:
  /// **'Part No'**
  String get partNo;

  /// Serial number field label
  ///
  /// In en, this message translates to:
  /// **'Serial No'**
  String get serialNo;

  /// Voter ID field
  ///
  /// In en, this message translates to:
  /// **'Voter ID'**
  String get voterId;

  /// Mobile number field
  ///
  /// In en, this message translates to:
  /// **'Mobile No'**
  String get mobileNo;

  /// Clear button text
  ///
  /// In en, this message translates to:
  /// **'Clear'**
  String get clear;

  /// Filter button
  ///
  /// In en, this message translates to:
  /// **'Filter'**
  String get filter;

  /// Basic tab
  ///
  /// In en, this message translates to:
  /// **'Basic'**
  String get basic;

  /// Family tab
  ///
  /// In en, this message translates to:
  /// **'Family'**
  String get family;

  /// Share tab
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get share;

  /// Voter first name field label
  ///
  /// In en, this message translates to:
  /// **'Voter First Name'**
  String get voterFirstName;

  /// Voter last name field label
  ///
  /// In en, this message translates to:
  /// **'Voter Last Name'**
  String get voterLastName;

  /// Relation first name field label
  ///
  /// In en, this message translates to:
  /// **'Relation First Name'**
  String get relationFirstName;

  /// Relation last name field
  ///
  /// In en, this message translates to:
  /// **'Relation Last Name'**
  String get relationLastName;

  /// Create Cadre title
  ///
  /// In en, this message translates to:
  /// **'Create Cadre'**
  String get createCadre;

  /// Elections title
  ///
  /// In en, this message translates to:
  /// **'Elections'**
  String get elections;

  /// History
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get history;

  /// Slip Box title
  ///
  /// In en, this message translates to:
  /// **'Slip Box'**
  String get slipBox;

  /// Poll Day title
  ///
  /// In en, this message translates to:
  /// **'Poll Day'**
  String get pollDay;

  /// Survey title
  ///
  /// In en, this message translates to:
  /// **'Survey'**
  String get survey;

  /// No Family category
  ///
  /// In en, this message translates to:
  /// **'No Family'**
  String get noFamily;

  /// Schemes
  ///
  /// In en, this message translates to:
  /// **'Schemes'**
  String get schemes;

  /// Parties category
  ///
  /// In en, this message translates to:
  /// **'Parties'**
  String get parties;

  /// Religions category
  ///
  /// In en, this message translates to:
  /// **'Religions'**
  String get religions;

  /// Castes category
  ///
  /// In en, this message translates to:
  /// **'Castes'**
  String get castes;

  /// Sub Castes category
  ///
  /// In en, this message translates to:
  /// **'Sub Castes'**
  String get subCastes;

  /// Caste Category title
  ///
  /// In en, this message translates to:
  /// **'Caste Category'**
  String get casteCategory;

  /// Voter Slip
  ///
  /// In en, this message translates to:
  /// **'Voter Slip'**
  String get voterSlip;

  /// Phone Call title
  ///
  /// In en, this message translates to:
  /// **'Phone Call'**
  String get phoneCall;

  /// Feedback title
  ///
  /// In en, this message translates to:
  /// **'Feedback'**
  String get feedback;

  /// App Banner
  ///
  /// In en, this message translates to:
  /// **'App Banner'**
  String get appBanner;

  /// Part Details title
  ///
  /// In en, this message translates to:
  /// **'Part Details'**
  String get partDetails;

  /// Family Details title
  ///
  /// In en, this message translates to:
  /// **'Family Details'**
  String get familyDetails;

  /// Part Numbers title
  ///
  /// In en, this message translates to:
  /// **'Part Numbers'**
  String get partNumbers;

  /// Voter Category title
  ///
  /// In en, this message translates to:
  /// **'Voter Category'**
  String get voterCategory;

  /// Voter Language title
  ///
  /// In en, this message translates to:
  /// **'Voter Language'**
  String get voterLanguage;

  /// Voter Part Numbers title
  ///
  /// In en, this message translates to:
  /// **'Voter Part Numbers'**
  String get voterPartNumbers;

  /// Voter List title
  ///
  /// In en, this message translates to:
  /// **'Voter List'**
  String get voterList;

  /// My Cadre title
  ///
  /// In en, this message translates to:
  /// **'My Cadre'**
  String get myCadre;

  /// Part Map title
  ///
  /// In en, this message translates to:
  /// **'Part Map'**
  String get partMap;

  /// Recover Password title
  ///
  /// In en, this message translates to:
  /// **'Recover Password'**
  String get recoverPassword;

  /// OTP Screen title
  ///
  /// In en, this message translates to:
  /// **'OTP Screen'**
  String get otpScreen;

  /// No Family Detected message
  ///
  /// In en, this message translates to:
  /// **'No Family Detected'**
  String get noFamilyDetected;

  /// Expected Voters
  ///
  /// In en, this message translates to:
  /// **'Expected Voters'**
  String get expectedVoters;

  /// Actual Voters
  ///
  /// In en, this message translates to:
  /// **'Actual Voters'**
  String get actualVoters;

  /// Missing Voters
  ///
  /// In en, this message translates to:
  /// **'Missing Voters'**
  String get missingVoters;

  /// Unexpected Voters
  ///
  /// In en, this message translates to:
  /// **'Unexpected Voters'**
  String get unexpectedVoters;

  /// Analysis Completed
  ///
  /// In en, this message translates to:
  /// **'Analysis Completed'**
  String get analysisCompleted;

  /// Political Meeting
  ///
  /// In en, this message translates to:
  /// **'Political Meeting'**
  String get politicalMeeting;

  /// Cadre Overview
  ///
  /// In en, this message translates to:
  /// **'Cadre Overview'**
  String get cadreOverview;

  /// Total Cadres
  ///
  /// In en, this message translates to:
  /// **'Total Cadres'**
  String get totalCadres;

  /// Cadre Active
  ///
  /// In en, this message translates to:
  /// **'Cadre Active'**
  String get cadreActive;

  /// Cadre InActive
  ///
  /// In en, this message translates to:
  /// **'Cadre InActive'**
  String get cadreInActive;

  /// Logged In
  ///
  /// In en, this message translates to:
  /// **'Logged In'**
  String get loggedIn;

  /// Not Logged
  ///
  /// In en, this message translates to:
  /// **'Not Logged'**
  String get notLogged;

  /// Set Election
  ///
  /// In en, this message translates to:
  /// **'Set Election'**
  String get setElection;

  /// Category
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get category;

  /// Party
  ///
  /// In en, this message translates to:
  /// **'Party'**
  String get party;

  /// Religion
  ///
  /// In en, this message translates to:
  /// **'Religion'**
  String get religion;

  /// Caste
  ///
  /// In en, this message translates to:
  /// **'Caste'**
  String get caste;

  /// Sub-Caste
  ///
  /// In en, this message translates to:
  /// **'Sub-Caste'**
  String get subCaste;

  /// Language
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// Set Default Election
  ///
  /// In en, this message translates to:
  /// **'Set Default Election'**
  String get setDefaultElection;

  /// Update button
  ///
  /// In en, this message translates to:
  /// **'UPDATE'**
  String get update;

  /// Advanced search title
  ///
  /// In en, this message translates to:
  /// **'Advance Search'**
  String get advanceSearch;

  /// Volunteer tracking screen title
  ///
  /// In en, this message translates to:
  /// **'Volunteers Tracking'**
  String get volunteerTracking;

  /// Search placeholder for cadre manager
  ///
  /// In en, this message translates to:
  /// **'Search by name or mobile number...'**
  String get searchByNameOrMobile;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
    'en',
    'hi',
    'kn',
    'ml',
    'ta',
    'te',
  ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'hi':
      return AppLocalizationsHi();
    case 'kn':
      return AppLocalizationsKn();
    case 'ml':
      return AppLocalizationsMl();
    case 'ta':
      return AppLocalizationsTa();
    case 'te':
      return AppLocalizationsTe();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}

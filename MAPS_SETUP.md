# Google Maps Integration Setup

## Overview
The app now includes a live location map feature that shows when clicking the "Part" button on the dashboard. This feature requires Google Maps API key configuration.

## Current Status
✅ **DUMMY API KEY CONFIGURED** - The app is currently configured with a test API key for development purposes:
- Android: `AIzaSyDummy123456789TestKeyForDevelopment`
- iOS: `AIzaSyDummy123456789TestKeyForDevelopment`

⚠️ **Note**: The dummy API key will allow the app to build and run, but **map tiles may not load properly**. For full functionality, you'll need a real Google Maps API key.

## Setup Instructions

### 1. For Testing (Current Setup)
The app is ready to build and test with the dummy API key:
- Maps will initialize but may show blank tiles
- Location services will work
- UI and navigation will function properly

### 2. Get Real Google Maps API Key
1. Go to [Google Cloud Console](https://console.cloud.google.com/)
2. Create a new project or select existing project
3. Enable the following APIs:
   - Maps SDK for Android
   - Maps SDK for iOS
   - Places API (optional, for future features)
4. Create credentials (API Key)
5. Restrict the API key to your app's bundle ID for security

### 3. Configure Android
The API key is configured in `android/app/src/main/AndroidManifest.xml`:
```xml
<meta-data android:name="com.google.android.geo.API_KEY"
           android:value="AIzaSyDummy123456789TestKeyForDevelopment"/>
```
Replace the dummy key with your actual Google Maps API key.

### 4. Configure iOS
The API key is already configured in `ios/Runner/AppDelegate.swift`:
```swift
import GoogleMaps

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GMSServices.provideAPIKey("AIzaSyDummy123456789TestKeyForDevelopment")
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
```
Replace the dummy key with your actual Google Maps API key.

### 4. Install Dependencies
Run the following command to install the required packages:
```bash
flutter pub get
```

## Features Implemented

### Map Screen (`part_map_screen.dart`)
- **Live Location**: Shows user's current location with a red marker
- **Interactive Map**: Google Maps with zoom, pan, and satellite view
- **Reload Button**: Refreshes the map and gets current location
- **Clear Cache Button**: Clears map cache and resets view
- **Zoom Controls**: Custom + and - buttons for zooming
- **Location Permissions**: Handles Android and iOS location permissions

### Navigation Integration
- Dashboard "Part" button now navigates to the map screen
- Matches the UI design shown in your image with Chennai area focus

### Permissions Configured
- **Android**: Location permissions added to AndroidManifest.xml
- **iOS**: Location usage descriptions added to Info.plist

## Usage
1. Click the "Part" button on the dashboard
2. Allow location permissions when prompted
3. The map will show your current location
4. Use "Reload" to refresh location
5. Use "Clear Cache" to reset the map view
6. Use zoom controls to zoom in/out

## Troubleshooting
- If map doesn't load: Check API key configuration
- If location not showing: Ensure location permissions are granted
- If app crashes: Verify all dependencies are installed with `flutter pub get`

## Security Note
Remember to restrict your API key in Google Cloud Console to prevent unauthorized usage.

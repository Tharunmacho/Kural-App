import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../l10n/app_localizations.dart';

class AppBannerScreen extends StatefulWidget {
  const AppBannerScreen({super.key});

  @override
  State<AppBannerScreen> createState() => _AppBannerScreenState();
}

class _AppBannerScreenState extends State<AppBannerScreen> {
  final ImagePicker _picker = ImagePicker();
  List<String> _bannerImages = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadBannerImages();
  }

  Future<void> _loadBannerImages() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final bannerImagesJson = prefs.getString('banner_images') ?? '[]';
      final List<dynamic> bannerImagesList = json.decode(bannerImagesJson);
      
      setState(() {
        _bannerImages = bannerImagesList.cast<String>();
        _isLoading = false;
      });
    } catch (e) {
      debugPrint('Error loading banner images: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _saveBannerImages() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final bannerImagesJson = json.encode(_bannerImages);
      await prefs.setString('banner_images', bannerImagesJson);
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context)?.success ?? 'Banner images saved successfully!'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      debugPrint('Error saving banner images: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context)?.error ?? 'Error saving banner images'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _pickImage() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1920,
        maxHeight: 1080,
        imageQuality: 80,
      );
      
      if (image != null) {
        setState(() {
          _bannerImages.add(image.path);
        });
        await _saveBannerImages();
      }
    } catch (e) {
      debugPrint('Error picking image: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context)?.error ?? 'Error picking image'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _removeImage(int index) async {
    setState(() {
      _bannerImages.removeAt(index);
    });
    await _saveBannerImages();
  }

  void _showRemoveDialog(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(AppLocalizations.of(context)?.delete ?? 'Delete'),
        content: Text(AppLocalizations.of(context)?.confirm ?? 'Are you sure you want to remove this banner image?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(AppLocalizations.of(context)?.cancel ?? 'Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _removeImage(index);
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: Text(AppLocalizations.of(context)?.delete ?? 'Delete'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F7FA),
      appBar: AppBar(
        backgroundColor: Color(0xFF1976D2),
        foregroundColor: Colors.white,
        title: Text(
          AppLocalizations.of(context)?.appBanner ?? 'App Banner',
          style: TextStyle(
            fontSize: MediaQuery.of(context).size.width * 0.045,
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.add_photo_alternate),
            onPressed: _pickImage,
            tooltip: 'Add Banner Image',
          ),
        ],
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(
                color: Color(0xFF1976D2),
              ),
            )
          : Column(
              children: [
                // Header section
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.04),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        blurRadius: 8,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Manage Banner Images',
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.05,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                      Text(
                        'Add images that will be displayed as swipeable banners on the dashboard',
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.035,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
                
                // Banner images list
                Expanded(
                  child: _bannerImages.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.photo_library_outlined,
                                size: MediaQuery.of(context).size.width * 0.15,
                                color: Colors.grey[400],
                              ),
                              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                              Text(
                                'No banner images added',
                                style: TextStyle(
                                  fontSize: MediaQuery.of(context).size.width * 0.04,
                                  color: Colors.grey[600],
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                              Text(
                                'Tap the + icon to add banner images',
                                style: TextStyle(
                                  fontSize: MediaQuery.of(context).size.width * 0.035,
                                  color: Colors.grey[500],
                                ),
                              ),
                            ],
                          ),
                        )
                      : ListView.builder(
                          padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.04),
                          itemCount: _bannerImages.length,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: EdgeInsets.only(
                                bottom: MediaQuery.of(context).size.height * 0.02,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: 0.05),
                                    blurRadius: 8,
                                    offset: Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Image
                                  ClipRRect(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(12),
                                      topRight: Radius.circular(12),
                                    ),
                                    child: SizedBox(
                                      width: double.infinity,
                                      height: MediaQuery.of(context).size.height * 0.2,
                                      child: Image.file(
                                        File(_bannerImages[index]),
                                        fit: BoxFit.cover,
                                        errorBuilder: (context, error, stackTrace) {
                                          return Container(
                                            color: Colors.grey[200],
                                            child: Center(
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    Icons.broken_image,
                                                    size: MediaQuery.of(context).size.width * 0.08,
                                                    color: Colors.grey[400],
                                                  ),
                                                  SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                                                  Text(
                                                    'Image not found',
                                                    style: TextStyle(
                                                      fontSize: MediaQuery.of(context).size.width * 0.03,
                                                      color: Colors.grey[500],
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
                                  
                                  // Controls
                                  Padding(
                                    padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.04),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            'Banner ${index + 1}',
                                            style: TextStyle(
                                              fontSize: MediaQuery.of(context).size.width * 0.04,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black87,
                                            ),
                                          ),
                                        ),
                                        IconButton(
                                          onPressed: () => _showRemoveDialog(index),
                                          icon: Icon(
                                            Icons.delete_outline,
                                            color: Colors.red[600],
                                            size: MediaQuery.of(context).size.width * 0.06,
                                          ),
                                          tooltip: 'Remove banner',
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                ),
              ],
            ),
      
      // Floating action button
      floatingActionButton: FloatingActionButton(
        onPressed: _pickImage,
        backgroundColor: Color(0xFF1976D2),
        tooltip: 'Add Banner Image',
        child: Icon(
          Icons.add_photo_alternate,
          color: Colors.white,
        ),
      ),
    );
  }
}
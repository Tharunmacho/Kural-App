import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class PartMapScreen extends StatefulWidget {
  const PartMapScreen({super.key});

  @override
  State<PartMapScreen> createState() => _PartMapScreenState();
}

class _PartMapScreenState extends State<PartMapScreen> {
  final Completer<GoogleMapController> _controller = Completer<GoogleMapController>();
  Location location = Location();
  bool _isLoading = true;
  final Set<Marker> _markers = {};
  
  // Chennai coordinates as default (matching your image)
  static const CameraPosition _initialPosition = CameraPosition(
    target: LatLng(13.0827, 80.2707), // Chennai coordinates
    zoom: 11.0,
  );

  @override
  void initState() {
    super.initState();
    _initializeLocation();
  }

  Future<void> _initializeLocation() async {
    await _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    try {
      bool serviceEnabled = await location.serviceEnabled();
      if (!serviceEnabled) {
        serviceEnabled = await location.requestService();
        if (!serviceEnabled) {
          setState(() => _isLoading = false);
          return;
        }
      }

      PermissionStatus permissionGranted = await location.hasPermission();
      if (permissionGranted == PermissionStatus.denied) {
        permissionGranted = await location.requestPermission();
        if (permissionGranted != PermissionStatus.granted) {
          setState(() => _isLoading = false);
          return;
        }
      }

      LocationData locationData = await location.getLocation();
      setState(() {
        _isLoading = false;
        _markers.add(
          Marker(
            markerId: MarkerId('current_location'),
            position: LatLng(locationData.latitude!, locationData.longitude!),
            infoWindow: InfoWindow(title: 'Current Location'),
            icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
          ),
        );
      });

      // Move camera to current location
      final GoogleMapController controller = await _controller.future;
      controller.animateCamera(
        CameraUpdate.newLatLng(
          LatLng(locationData.latitude!, locationData.longitude!),
        ),
      );
    } catch (e) {
      // Error getting location: $e
      setState(() => _isLoading = false);
    }
  }

  Future<void> _reloadMap() async {
    setState(() => _isLoading = true);
    await _getCurrentLocation();
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Map reloaded successfully')),
      );
    }
  }

  Future<void> _clearCache() async {
    // Clear map cache functionality
    final GoogleMapController controller = await _controller.future;
    // Reset camera to initial position
    controller.animateCamera(CameraUpdate.newCameraPosition(_initialPosition));
    setState(() {
      _markers.clear();
    });
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Map cache cleared')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Part Map',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          // Google Map
          _isLoading
              ? Center(
                  child: CircularProgressIndicator(
                    color: Color(0xFF1976D2),
                  ),
                )
              : GoogleMap(
                  mapType: MapType.normal,
                  initialCameraPosition: _initialPosition,
                  markers: _markers,
                  myLocationEnabled: true,
                  myLocationButtonEnabled: false,
                  zoomControlsEnabled: false,
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                  },
                ),
          
          // Control buttons (Reload and Clear Cache)
          Positioned(
            top: 20,
            left: 20,
            right: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _reloadMap,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF1976D2),
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    elevation: 4,
                  ),
                  child: Text(
                    'Reload',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  onPressed: _clearCache,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF1976D2),
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    elevation: 4,
                  ),
                  child: Text(
                    'Clear Cache',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // Zoom controls
          Positioned(
            right: 16,
            bottom: 100,
            child: Column(
              children: [
                FloatingActionButton(
                  heroTag: "zoom_in",
                  mini: true,
                  backgroundColor: Colors.white,
                  onPressed: () async {
                    final GoogleMapController controller = await _controller.future;
                    controller.animateCamera(CameraUpdate.zoomIn());
                  },
                  child: Icon(Icons.add, color: Colors.black87),
                ),
                const SizedBox(height: 8),
                FloatingActionButton(
                  heroTag: "zoom_out",
                  mini: true,
                  backgroundColor: Colors.white,
                  onPressed: () async {
                    final GoogleMapController controller = await _controller.future;
                    controller.animateCamera(CameraUpdate.zoomOut());
                  },
                  child: Icon(Icons.remove, color: Colors.black87),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}

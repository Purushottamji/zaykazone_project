import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';

class MapPickerScreen extends StatefulWidget {
  const MapPickerScreen({super.key});

  @override
  State<MapPickerScreen> createState() => _MapPickerScreenState();
}

class _MapPickerScreenState extends State<MapPickerScreen> {
  LatLng selectedLatLng = const LatLng(28.6139, 77.2090); // Default Delhi
  GoogleMapController? mapController;
  String pickedAddress = "";

  Future<void> _getAddress(LatLng latLng) async {
    final placemarks =
    await placemarkFromCoordinates(latLng.latitude, latLng.longitude);

    if (placemarks.isNotEmpty) {
      final p = placemarks.first;
      setState(() {
        pickedAddress =
        "${p.street}, ${p.locality}, ${p.administrativeArea}, ${p.postalCode}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: selectedLatLng,
              zoom: 15,
            ),
            onMapCreated: (controller) => mapController = controller,
            onCameraMove: (position) {
              selectedLatLng = position.target;
            },
            onCameraIdle: () => _getAddress(selectedLatLng),
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
          ),

          /// 📍 Center marker
          const Center(
            child: Icon(Icons.location_pin,
                size: 45, color: Color(0xffFF620D)),
          ),

          /// 🧊 Glass Top Bar
          Positioned(
            top: 40,
            left: 16,
            right: 16,
            child: ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Text(
                    pickedAddress.isEmpty
                        ? "Move map to select location"
                        : pickedAddress,
                    style: const TextStyle(
                        color: Colors.white, fontSize: 14),
                  ),
                ),
              ),
            ),
          ),

          /// ✅ Confirm Button
          Positioned(
            bottom: 30,
            left: 20,
            right: 20,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xffFF620D),
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14)),
              ),
              onPressed: () {
                Navigator.pop(context, pickedAddress);
              },
              child: const Text(
                "Confirm Location",
                style:
                TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

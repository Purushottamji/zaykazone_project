// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
//
// class LiveLocation extends StatefulWidget {
//   const LiveLocation({super.key});
//
//   @override
//   State<LiveLocation> createState() => _LiveLocationState();
// }
//
// class _LiveLocationState extends State<LiveLocation> {
//
//   Future<void> getCurrentLocation() async {
//
//     // Check permission
//     LocationPermission permission = await Geolocator.checkPermission();
//
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//     }
//
//     if (permission == LocationPermission.deniedForever) {
//       print("Location permission permanently denied");
//       return;
//     }
//
//     // Get current position
//     Position position = await Geolocator.getCurrentPosition(
//       desiredAccuracy: LocationAccuracy.high,
//     );
//
//     print("Latitude:  ${position.latitude}");
//     print("Longitude: ${position.longitude}");
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Live Location"),
//         centerTitle: true,
//       ),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: getCurrentLocation,
//           child: const Text("Get Live Location"),
//         ),
//       ),
//     );
//   }
// }

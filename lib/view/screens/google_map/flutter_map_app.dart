import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';

class FlutterMapApp extends StatefulWidget {
  const FlutterMapApp({super.key});

  @override
  State<FlutterMapApp> createState() => _FlutterMapAppState();
}

class _FlutterMapAppState extends State<FlutterMapApp> {
  LatLng? currentLocation;
  List<Marker> markers = [];
  List<LatLng> routePoints = [];

  TextEditingController searchController = TextEditingController();
  List<dynamic> searchResults = [];

  final MapController _mapController = MapController();

  // ============================
  // 1️⃣ Get Current Location
  // ============================
  Future<void> _getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return;

    LocationPermission permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) return;

    Position pos = await Geolocator.getCurrentPosition();
    LatLng loc = LatLng(pos.latitude, pos.longitude);

    setState(() => currentLocation = loc);

    _mapController.move(loc, 15);

    markers.add(
      Marker(
        point: loc,
        width: 40,
        height: 40,
        child: const Icon(Icons.my_location, color: Colors.blue, size: 40),
      ),
    );
  }

  // ============================
  // 2️⃣ SEARCH PLACE (Nominatim)
  // ============================
  Future<void> _searchPlace(String query) async {
    if (query.isEmpty) {
      setState(() => searchResults = []);
      return;
    }

    final url =
        "https://nominatim.openstreetmap.org/search?q=$query&format=json&limit=5";

    final response = await http.get(Uri.parse(url));
    final List data = jsonDecode(response.body);

    setState(() => searchResults = data);
  }

  // ============================
  // 3️⃣ SELECT SEARCH RESULT
  // ============================
  void _selectSearchResult(dynamic item) {
    double lat = double.parse(item["lat"]);
    double lon = double.parse(item["lon"]);
    LatLng location = LatLng(lat, lon);

    markers.add(
      Marker(
        point: location,
        width: 40,
        height: 40,
        child: const Icon(Icons.location_pin, color: Colors.red, size: 40),
      ),
    );

    _mapController.move(location, 15);

    setState(() {
      searchResults = [];
      searchController.clear();
    });
  }

  // ============================
  // 4️⃣ Draw route between 2 points (OSRM)
  // ============================
  Future<void> drawRoute(LatLng start, LatLng end) async {
    final url =
        "http://router.project-osrm.org/route/v1/driving/${start.longitude},${start.latitude};${end.longitude},${end.latitude}?overview=full&geometries=geojson";

    final response = await http.get(Uri.parse(url));
    final data = jsonDecode(response.body);

    List coords = data["routes"][0]["geometry"]["coordinates"];

    routePoints = coords
        .map((coord) => LatLng(coord[1].toDouble(), coord[0].toDouble()))
        .toList();

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter Map Full App"),
      ),

      body: Stack(
        children: [
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              initialCenter: const LatLng(28.6139, 77.2090), // Delhi
              initialZoom: 12,
              cameraConstraint: CameraConstraint.unconstrained(), // important
              onTap: (tapPosition, point) {
                markers.add(
                  Marker(
                    point: point,
                    width: 40,
                    height: 40,
                    child: const Icon(
                      Icons.location_on,
                      color: Colors.green,
                      size: 40,
                    ),
                  ),
                );
                setState(() {});
              },
            ),

            children: [
              TileLayer(
                urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
              ),

              MarkerLayer(markers: markers),

              // SAFE: Render only when routePoints is not empty
              if (routePoints.isNotEmpty)
                PolylineLayer(
                  polylines: [
                    Polyline(
                      points: routePoints,
                      strokeWidth: 4,
                      color: Colors.blue,
                    ),
                  ],
                ),
            ],
          ),

          // ============================
          // SEARCH BOX UI
          // ============================
          Positioned(
            top: 10,
            left: 12,
            right: 12,
            child: Column(
              children: [
                Material(
                  elevation: 4,
                  borderRadius: BorderRadius.circular(10),
                  child: TextField(
                    controller: searchController,
                    onChanged: _searchPlace,
                    decoration: InputDecoration(
                      hintText: "Search place…",
                      contentPadding: const EdgeInsets.all(12),
                      border: InputBorder.none,
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          searchController.clear();
                          setState(() => searchResults = []);
                        },
                      ),
                    ),
                  ),
                ),

                if (searchResults.isNotEmpty)
                  Container(
                    height: 200,
                    margin: const EdgeInsets.only(top: 5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: ListView.builder(
                      itemCount: searchResults.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(searchResults[index]["display_name"]),
                          onTap: () =>
                              _selectSearchResult(searchResults[index]),
                        );
                      },
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.alt_route),
        onPressed: () {
          if (markers.length >= 2) {
            LatLng start = markers[markers.length - 2].point;
            LatLng end = markers.last.point;
            drawRoute(start, end);
          }
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../controller/restaurant_details_provider/restaurant_provider.dart';
import 'dart:ui';

class AddRestaurantScreen extends StatelessWidget {
  const AddRestaurantScreen({super.key});

  void openBottomSheet(BuildContext context) {
    final restProvider =
    Provider.of<RestaurantProvider>(context, listen: false);

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) {
        return ClipRRect(
          borderRadius:
          const BorderRadius.vertical(top: Radius.circular(25)),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.18),
                borderRadius:
                const BorderRadius.vertical(top: Radius.circular(25)),
                border: Border.all(
                    color: Colors.white.withOpacity(0.3)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 12),
                  _sheetTile(
                    Icons.photo_library,
                    "Pick From Gallery",
                        () {
                      restProvider.pickFromGallery();
                      Navigator.pop(context);
                    },
                  ),
                  _sheetTile(
                    Icons.camera_alt,
                    "Pick From Camera",
                        () {
                      restProvider.pickFromCamera();
                      Navigator.pop(context);
                    },
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final restProvider = Provider.of<RestaurantProvider>(context);
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xff1A1A1A),
              Color(0xff2A2A2A),
              Color(0xffFF620D),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              /// 🧊 Glass AppBar
              _glassAppBar(context),

              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      const SizedBox(height: 20),

                      /// 🖼 Image Picker
                      GestureDetector(
                        onTap: () => openBottomSheet(context),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: BackdropFilter(
                            filter:
                            ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                            child: Container(
                              height: height * 0.28,
                              width: width * 0.75,
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.18),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: Colors.white.withOpacity(0.3),
                                ),
                              ),
                              child: restProvider.imageFile == null
                                  ? const Icon(Icons.store,
                                  size: 90,
                                  color: Colors.white70)
                                  : Image.file(
                                restProvider.imageFile!,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 30),

                      _glassField(
                          icon: Icons.store,
                          label: "Restaurant Name",
                          hint: "Enter restaurant name"),
                      _glassField(
                          icon: Icons.description,
                          label: "Description",
                          hint: "Enter description"),
                      _glassField(
                          icon: Icons.food_bank,
                          label: "Food Details",
                          hint: "Enter food items"),
                      _glassField(
                          icon: Icons.location_on,
                          label: "Address",
                          hint: "Enter address"),

                      const SizedBox(height: 30),

                      /// ✅ Submit Button
                      SizedBox(
                        width: double.infinity,
                        height: 52,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                            const Color(0xffFF620D),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                          onPressed: () {},
                          child: const Text(
                            "SUBMIT",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// 🔶 Glass AppBar
  Widget _glassAppBar(BuildContext context) {
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
        child: Container(
          padding:
          const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.18),
            border: Border(
              bottom: BorderSide(
                color: Colors.white.withOpacity(0.25),
              ),
            ),
          ),
          child: Row(
            children: [
              _glassIcon(
                Icons.arrow_back_ios_new,
                    () => Navigator.pop(context),
              ),
              const SizedBox(width: 16),
              const Text(
                "Add Restaurant",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// 🧊 Glass Input
  Widget _glassField({
    required IconData icon,
    required String label,
    required String hint,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(14),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
          child: TextFormField(
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              labelText: label,
              hintText: hint,
              labelStyle: const TextStyle(color: Colors.white70),
              hintStyle: const TextStyle(color: Colors.white54),
              prefixIcon: Icon(icon, color: Colors.white70),
              filled: true,
              fillColor: Colors.white.withOpacity(0.2),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// 🔘 Glass Icon
  Widget _glassIcon(IconData icon, VoidCallback onTap) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
        child: InkWell(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.35),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: Colors.black),
          ),
        ),
      ),
    );
  }

  /// 📄 Bottom Sheet Tile
  Widget _sheetTile(
      IconData icon, String text, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xffFF620D)),
      title:
      Text(text, style: const TextStyle(color: Colors.white)),
      onTap: onTap,
    );
  }
}


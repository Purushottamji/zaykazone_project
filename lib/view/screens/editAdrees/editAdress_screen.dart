import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../controller/user_address_provider/user_address_provider.dart';
import '../../../model/user_address_model/user_address_model.dart';
import 'dart:ui';

class EditAddressScreen extends StatefulWidget {
  final UserAddressModel? existingAddress;

  const EditAddressScreen({super.key, this.existingAddress});

  @override
  State<EditAddressScreen> createState() => _EditAddressScreenState();
}

class _EditAddressScreenState extends State<EditAddressScreen> {
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    final provider =
    Provider.of<UserAddressProvider>(context, listen: false);

    if (widget.existingAddress != null) {
      provider.setAddressData(widget.existingAddress!);
      selectedIndex =
          provider.getIndexFromLabel(widget.existingAddress!.labelAs);
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<UserAddressProvider>();
    final w = MediaQuery.of(context).size.width;

    double fieldWidth = (w - 50) / 2;

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
        child: Column(
          children: [
            _glassAppBar(),

            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: w * 0.05),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),

                    _glassField(
                      controller: provider.addressController,
                      label: "Full Address",
                      icon: Icons.location_on_outlined,
                    ),

                    const SizedBox(height: 15),

                    Row(
                      children: [
                        SizedBox(
                          width: fieldWidth,
                          child: _glassField(
                            controller: provider.streetController,
                            label: "Street",
                          ),
                        ),
                        const SizedBox(width: 10),
                        SizedBox(
                          width: fieldWidth,
                          child: _glassField(
                            controller: provider.pinController,
                            label: "Pin Code",
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 15),

                    Row(
                      children: [
                        SizedBox(
                          width: fieldWidth,
                          child: _glassField(
                            controller: provider.buildingNoController,
                            label: "Building No",
                          ),
                        ),
                        const SizedBox(width: 10),
                        SizedBox(
                          width: fieldWidth,
                          child: _glassField(
                            controller: provider.flatNoController,
                            label: "Apartment / Flat",
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 25),

                    const Text(
                      "Label as",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),

                    const SizedBox(height: 12),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _glassLabel("Home", 0),
                        _glassLabel("Work", 1),
                        _glassLabel("Other", 2),
                      ],
                    ),

                    const SizedBox(height: 40),

                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                          const Color(0xffFF620D),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        onPressed: () async {
                          String label = provider
                              .getLabelFromIndex(selectedIndex);

                          bool success;
                          if (widget.existingAddress == null) {
                            success =
                            await provider.saveAddress(label);
                          } else {
                            success = await provider.updateAddress(
                                widget.existingAddress!.addId,
                                label);
                          }

                          if (success) Navigator.pop(context);
                        },
                        child: Text(
                          widget.existingAddress == null
                              ? "Save Address"
                              : "Update Address",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
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
    );
  }

  Widget _glassAppBar() {
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
        child: Container(height: kToolbarHeight + MediaQuery.of(context).padding.top,
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top,
          left: 16,
          right: 16,),
          decoration: BoxDecoration(
            color: Color(0xffFF620D).withOpacity(0.60),
            border: Border(
              bottom:
              BorderSide(color: Colors.white.withOpacity(0.2)),
            ),
          ),
          child: Row(
            children: [
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: _glassIcon(Icons.arrow_back_ios_new),
              ),
              const SizedBox(width: 16),
              const Text(
                "Address",
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

  Widget _glassField({
    required TextEditingController controller,
    required String label,
    IconData? icon,
  }) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(14),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: TextFormField(
          controller: controller,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            labelText: label,
            labelStyle: const TextStyle(color: Colors.white70),
            prefixIcon: icon != null
                ? Icon(icon, color: const Color(0xffFF620D))
                : null,
            filled: true,
            fillColor: Colors.white.withOpacity(0.15),
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }

  Widget _glassLabel(String title, int index) {
    final isSelected = selectedIndex == index;

    return GestureDetector(
      onTap: () => setState(() => selectedIndex = index),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
          child: Container(
            height: 45,
            width: 100,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: isSelected
                  ? const Color(0xffFF620D).withOpacity(0.8)
                  : Colors.white.withOpacity(0.15),
              border: Border.all(
                color: isSelected
                    ? const Color(0xffFF620D)
                    : Colors.white30,
              ),
            ),
            child: Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _glassIcon(IconData icon) {
    return ClipOval(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
        child: Container(
          padding: const EdgeInsets.all(8),
          color: Colors.white.withOpacity(0.4),
          child: Icon(icon,
              color: const Color(0xffffffff), size: 20),
        ),
      ),
    );
  }
}

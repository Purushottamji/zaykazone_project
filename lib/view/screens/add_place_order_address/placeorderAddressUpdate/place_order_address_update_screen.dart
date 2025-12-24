import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zaykazone/controller/user_auth_provider/login_provider/from_user_data/login_provider.dart';
import 'package:zaykazone/services/place_order_address_api/place_order_address_api.dart';

import '../../../../controller/place_order_address_provider/place_order_address_provider.dart';

class PlaceOrderAddressUpdateScreen extends StatefulWidget {
  final int? id;

  const PlaceOrderAddressUpdateScreen({super.key, this.id});

  @override
  State<PlaceOrderAddressUpdateScreen> createState() =>
      _PlaceOrderAddressUpdateScreenState();
}

class _PlaceOrderAddressUpdateScreenState
    extends State<PlaceOrderAddressUpdateScreen> {
  final _formKey = GlobalKey<FormState>();
  static const accentColor = Color(0xffFF620D);
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      if(widget.id!=null){
        final provider = Provider.of<PlaceOrderAddressProvider>(context, listen: false);
        final model = provider.addressList.firstWhere((e) => e.id == widget.id);
        provider.setTextControllers(model);
      }
    },);
  }

  InputDecoration _glassInput(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: Colors.white54),
      filled: true,
      fillColor: Colors.white.withOpacity(0.12),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide.none,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PlaceOrderAddressProvider>(context);
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text("Update Address"),
        centerTitle: true,
        backgroundColor: accentColor.withOpacity(0.75),
        elevation: 0,
        foregroundColor: Colors.white,
      ),
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
          child: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(
              size.width * 0.06,
              kToolbarHeight + 20,
              size.width * 0.06,
              120, // keyboard + floating nav safe
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(22),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(22),
                    border: Border.all(color: Colors.white24),
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        _field(
                          controller: provider.landMarkController,
                          hint: "Enter Landmark",
                          validator: (v) =>
                              v!.isEmpty ? "Landmark required" : null,
                        ),
                        const SizedBox(height: 14),
                        _field(
                          controller: provider.stateController,
                          hint: "Enter State",
                          validator: (v) =>
                              v!.isEmpty ? "State required" : null,
                        ),
                        const SizedBox(height: 14),
                        _field(
                          controller: provider.pinCodeController,
                          hint: "Enter Pincode",
                          keyboardType: TextInputType.number,
                          validator: (v) {
                            if (v!.isEmpty) return "Pincode required";
                            if (v.length != 6) {
                              return "Enter valid 6-digit pincode";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 14),
                        _field(
                          controller: provider.districtController,
                          hint: "Enter District",
                          validator: (v) =>
                              v!.isEmpty ? "District required" : null,
                        ),
                        const SizedBox(height: 14),
                        _field(
                          controller: provider.mobileNumberController,
                          hint: "Enter Mobile Number",
                          keyboardType: TextInputType.phone,
                          validator: (v) {
                            if (v!.isEmpty) {
                              return "Mobile Number required";
                            }
                            if (v.length != 10) {
                              return "Enter valid 10-digit number";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 14),
                        _field(
                          controller: provider.fullAddressController,
                          hint: "Enter Full Address",
                          maxLines: 3,
                          validator: (v) =>
                              v!.isEmpty ? "Full Address required" : null,
                        ),
                        const SizedBox(height: 26),
                        SizedBox(
                          width: double.infinity,
                          height: 52,
                          child: ElevatedButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                if (widget.id == null) {
                                  print("add OrderAddress :${PlaceOrderAddressApi.storeId}");
                                  await provider.addAddress(context, PlaceOrderAddressApi.storeId);
                                  Navigator.pop(context);
                                } else {
                                  await provider.updateAddress(
                                      context, widget.id!);
                                  Navigator.pop(context);
                                }
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: accentColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                              elevation: 10,
                            ),
                            child: Text(widget.id ==null ?"Add Address":
                              "Update Address",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _field({
    required TextEditingController controller,
    required String hint,
    int maxLines = 1,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      cursorColor: Color(0xffff620d),

      keyboardType: keyboardType,
      style: const TextStyle(color: Colors.white),
      decoration: _glassInput(hint),
      validator: validator,
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// import '../../../controller/place_order_address_provider/place_order_address_provider.dart';
//
//
// class PlaceOrderAddressAdd extends StatefulWidget {
//   final int id;
//
//   const PlaceOrderAddressAdd({super.key, required this.id});
//
//   @override
//   State<PlaceOrderAddressAdd> createState() =>
//       _PlaceOrderAddressAddState();
// }
//
// class _PlaceOrderAddressAddState
//     extends State<PlaceOrderAddressAdd> {
//   final _formKey = GlobalKey<FormState>();
//
//   @override
//   void initState() {
//     super.initState();
//
//     final provider =
//     Provider.of<PlaceOrderAddressProvider>(context, listen: false);
//
//     var model = provider.addressList.firstWhere((e) => e.id == widget.id);
//
//     provider.setTextControllers(model);
//   }
//
//   InputDecoration myInputDecoration(String hint) {
//     return InputDecoration(
//       hintText: hint,
//       border: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(12),
//       ),
//       enabledBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(12),
//         borderSide: BorderSide(color: Colors.grey),
//       ),
//       focusedBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(12),
//         borderSide: BorderSide(color: Colors.black, width: 1.4),
//       ),
//       contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     var provider = Provider.of<PlaceOrderAddressProvider>(context);
//
//     return Scaffold(
//       appBar: AppBar(title: Text("Update Address")),
//       body: Padding(
//         padding: const EdgeInsets.all(12),
//         child: Form(
//           key: _formKey,
//           child: provider.addressList.isEmpty ?
//           ListView(
//             children: [
//               TextFormField(
//                 controller: provider.landMarkController,
//                 decoration: myInputDecoration("Enter Landmark"),
//                 validator: (value) =>
//                 value!.isEmpty ? "Landmark required" : null,
//               ),
//               SizedBox(height: 15),
//               TextFormField(
//                 controller: provider.stateController,
//                 decoration: myInputDecoration("Enter State"),
//                 validator: (value) => value!.isEmpty ? "State required" : null,
//               ),
//               SizedBox(height: 15),
//               TextFormField(
//                 controller: provider.pinCodeController,
//                 keyboardType: TextInputType.number,
//                 decoration: myInputDecoration("Enter Pincode"),
//                 validator: (value) {
//                   if (value!.isEmpty) return "Pincode required";
//                   if (value.length != 6) return "Enter valid 6-digit pincode";
//                   return null;
//                 },
//               ),
//               SizedBox(height: 15),
//               TextFormField(
//                 controller: provider.districtController,
//                 decoration: myInputDecoration("Enter District"),
//                 validator: (value) =>
//                 value!.isEmpty ? "District required" : null,
//               ),
//               SizedBox(height: 15),
//               TextFormField(
//                 controller: provider.mobileNumberController,
//                 keyboardType: TextInputType.phone,
//                 decoration: myInputDecoration("Enter Mobile Number"),
//                 validator: (value) {
//                   if (value!.isEmpty) return "Mobile Number required";
//                   if (value.length != 10) {
//                     return "Enter valid 10-digit mobile number";
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(height: 15),
//               TextFormField(
//                 controller: provider.fullAddressController,
//                 maxLines: 3,
//                 decoration: myInputDecoration("Enter Full Address"),
//                 validator: (value) =>
//                 value!.isEmpty ? "Full Address required" : null,
//               ),
//               SizedBox(height: 25),
//               SizedBox(
//                   height: 50,
//                   child: ElevatedButton(
//                     onPressed: () async {
//                       if (_formKey.currentState!.validate()) {
//                         await provider.updateAddress(context, widget.id);
//                         Navigator.pop(context);
//                       }
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Color(0xffFF620D),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                     ),
//                     child: Text(
//                       "Add Address",
//                       style: TextStyle(fontSize: 16, color: Colors.white),
//                     ),
//                   )),
//             ],
//           ):
//           ListView(
//             children: [
//               TextFormField(
//                 controller: provider.landMarkController,
//                 decoration: myInputDecoration("Enter Landmark"),
//                 validator: (value) =>
//                 value!.isEmpty ? "Landmark required" : null,
//               ),
//               SizedBox(height: 15),
//               TextFormField(
//                 controller: provider.stateController,
//                 decoration: myInputDecoration("Enter State"),
//                 validator: (value) => value!.isEmpty ? "State required" : null,
//               ),
//               SizedBox(height: 15),
//               TextFormField(
//                 controller: provider.pinCodeController,
//                 keyboardType: TextInputType.number,
//                 decoration: myInputDecoration("Enter Pincode"),
//                 validator: (value) {
//                   if (value!.isEmpty) return "Pincode required";
//                   if (value.length != 6) return "Enter valid 6-digit pincode";
//                   return null;
//                 },
//               ),
//               SizedBox(height: 15),
//               TextFormField(
//                 controller: provider.districtController,
//                 decoration: myInputDecoration("Enter District"),
//                 validator: (value) =>
//                 value!.isEmpty ? "District required" : null,
//               ),
//               SizedBox(height: 15),
//               TextFormField(
//                 controller: provider.mobileNumberController,
//                 keyboardType: TextInputType.phone,
//                 decoration: myInputDecoration("Enter Mobile Number"),
//                 validator: (value) {
//                   if (value!.isEmpty) return "Mobile Number required";
//                   if (value.length != 10) {
//                     return "Enter valid 10-digit mobile number";
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(height: 15),
//               TextFormField(
//                 controller: provider.fullAddressController,
//                 maxLines: 3,
//                 decoration: myInputDecoration("Enter Full Address"),
//                 validator: (value) =>
//                 value!.isEmpty ? "Full Address required" : null,
//               ),
//               SizedBox(height: 25),
//               SizedBox(
//                   height: 50,
//                   child: ElevatedButton(
//                     onPressed: () async {
//                       if (_formKey.currentState!.validate()) {
//                         await provider.updateAddress(context, widget.id);
//                         Navigator.pop(context);
//                       }
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Color(0xffFF620D),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                     ),
//                     child: Text(
//                       "Update Address",
//                       style: TextStyle(fontSize: 16, color: Colors.white),
//                     ),
//                   )),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

class PlaceOrderAddressAdd extends StatefulWidget {
  const PlaceOrderAddressAdd({super.key});

  @override
  State<PlaceOrderAddressAdd> createState() => _PlaceOrderAddressAddState();
}

class _PlaceOrderAddressAddState extends State<PlaceOrderAddressAdd> {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}


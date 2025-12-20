// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:zaykazone/controller/place_order_address_provider/place_order_address_provider.dart';
// import 'package:zaykazone/services/placeorderAddressUpdate/place_order_address_update_screen.dart';
// class PlaceOrderAddress extends StatefulWidget {
//   const PlaceOrderAddress({super.key});
//
//   @override
//   State<PlaceOrderAddress> createState() => _PlaceOrderAddressState();
// }
// class _PlaceOrderAddressState extends State<PlaceOrderAddress> {
//
//   @override
//   void initState() {
//     super.initState();
//     Provider.of<PlaceOrderAddressProvider>(context, listen: false).addressGet(context);
//   }
//   @override
//   Widget build(BuildContext context) {
//     var provider = Provider.of<PlaceOrderAddressProvider>(context);
//     return SafeArea(
//       child: Scaffold(
//         appBar: AppBar(title: Text("PlaceOrderAddress")),
//         body: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: ListView.builder(
//             itemCount: provider.addressList.length,
//             itemBuilder: (context, index) {
//               var item = provider.addressList[index];
//
//               return Card(
//                 child: Padding(
//                   padding: const EdgeInsets.all(12),
//                   child: Row(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Column(crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                         Text("User Id: ${item.userId}",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
//                         Text("Land Mark: ${item.landMark}",style: TextStyle(fontSize: 16),),
//                         Text("State: ${item.state}",style: TextStyle(fontSize: 16),),
//                         Text("Pin Code: ${item.pinCode}",style: TextStyle(fontSize: 16),),
//                         Text("District: ${item.district}",style: TextStyle(fontSize: 16),),
//                         Text("Mobile: ${item.mobileNumber}",style: TextStyle(fontSize: 16),),
//                         Text("Full Address: ${item.fullAddress}",style: TextStyle(fontSize: 16),),
//
//                       ],),
//                       Flexible(
//                         child: IconButton(onPressed: () {
//
//                           Navigator.push(context,
//                               MaterialPageRoute(builder: (context) =>PlaceOrderAddressUpdateScreen(id: item.id) ,));
//
//                         }, icon: Icon(Icons.edit)),
//                       )
//
//                     ],
//                   ),
//                 ),
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }
//
//

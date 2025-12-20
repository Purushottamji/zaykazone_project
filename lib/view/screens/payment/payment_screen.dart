// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:zaykazone/view/screens/payment/add_new_card_screen.dart';
// import '../../../controller/cart_provider/cart_provider.dart';
// import '../../../controller/place_order_address_provider/place_order_address_provider.dart';
//
// class PaymentScreen extends StatefulWidget {
//   const PaymentScreen({super.key});
//
//   @override
//   State<PaymentScreen> createState() => _PaymentScreenState();
// }
//
// class _PaymentScreenState extends State<PaymentScreen> {
//   int selectedPayment = 0;
//
//   final List<Map<String, dynamic>> paymentMethods = [
//     {"icon": Icons.payments_rounded, "title": "Cash"},
//     {"icon": Icons.book_online_outlined, "title": "UPI"},
//     {"icon": Icons.credit_card_rounded, "title": "Visa"},
//     {"icon": Icons.account_balance_wallet, "title": "Wallet"},
//   ];
//
//
//   // @override
//   // void initState() {
//   //   super.initState();
//   //   Provider.of<PlaceOrderAddressProvider>(context,listen: false).addressGet(context);
//   // }
//
//
//   @override
//   void initState() {
//
//     super.initState();
//     var addressProvider=Provider.of<PlaceOrderAddressProvider>(context,listen: false).addressGet(context);
//   }
//   @override
//   Widget build(BuildContext context) {
//     final width = MediaQuery.of(context).size.width;
//     final height = MediaQuery.of(context).size.height;
//
//     var provider = Provider.of<CartProvider>(context);
//     var addressProvider = Provider.of<PlaceOrderAddressProvider>(context);
//
//     return SafeArea(
//       child: Scaffold(
//         resizeToAvoidBottomInset: false,
//
//         appBar: AppBar(
//           title: const Text("Payment"),
//           centerTitle: true,
//           backgroundColor: const Color(0xffFF620D),
//           foregroundColor: Colors.white,
//         ),
//
//         body: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//           child: ListView(
//             children: [
//               SizedBox(
//                 height: height * 0.15,
//                 child: ListView.separated(
//                   scrollDirection: Axis.horizontal,
//                   itemCount: paymentMethods.length,
//                   separatorBuilder: (_, __) => const SizedBox(width: 12),
//                   itemBuilder: (context, index) {
//                     return GestureDetector(
//                       onTap: () {
//                         setState(() {
//                           selectedPayment = index;
//                         });
//                       },
//                       child: Column(
//                         children: [
//                           AnimatedContainer(
//                             duration: const Duration(milliseconds: 300),
//                             width: width * 0.23,
//                             height: height * 0.10,
//                             decoration: BoxDecoration(
//                               color: selectedPayment == index
//                                   ? const Color(0xffFFEEE2)
//                                   : const Color(0xffECEDEF),
//                               borderRadius: BorderRadius.circular(12),
//                               border: Border.all(
//                                 color: selectedPayment == index
//                                     ? const Color(0xffFF620D)
//                                     : const Color(0xffFFEEE2),
//                                 width: 1.5,
//                               ),
//                             ),
//                             child: Icon(
//                               paymentMethods[index]["icon"],
//                               color:Color(0xffFF620D),
//                               size: 28,
//                             ),
//                           ),
//                           const SizedBox(height: 5),
//                           Text(paymentMethods[index]["title"],
//                               style: const TextStyle(
//                                   fontWeight: FontWeight.w600, fontSize: 14)),
//                         ],
//                       ),
//                     );
//                   },
//                 ),
//               ),
//               const SizedBox(height: 25),
//               Container(
//                 padding: const EdgeInsets.all(18),
//                 decoration: BoxDecoration(
//                     color: Color(0xffECEDEF),
//                     borderRadius: BorderRadius.circular(14)),
//                 child: Column(
//                   children: [
//                     Image.asset(
//                       "assets/images/img_3.png",
//                       width: width * 0.35,
//                       height: height * 0.08,
//                     ),
//                     const SizedBox(height: 12),
//                     Text(
//                       "No Mastercard Added\nAdd a new card & save it for later",
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                           color: Colors.grey.shade700,
//                           fontSize: 14,
//                           height: 1.4),
//                     ),
//                     SizedBox(height: 10),
//                     ElevatedButton(
//                       onPressed: () {
//                         Navigator.push(context, MaterialPageRoute(builder: (context) => AddNewCardScreen(),));
//                       },
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.white,
//                         shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(10)),
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: 30, vertical: 12),
//                       ),
//                       child: const Text(
//                         "+ ADD NEW CARD",
//                         style: TextStyle(color: Color(0xffFF620D)),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//
//
//               // SizedBox(
//               //   height: height * 0.45,
//               //   child: Column(
//               //     crossAxisAlignment: CrossAxisAlignment.start,
//               //     children: [
//               //
//               //
//               //       Align(
//               //         alignment: Alignment.centerRight,
//               //         child: ElevatedButton(
//               //           onPressed: () {
//               //             // Navigator.push(
//               //             //   context,
//               //             //   MaterialPageRoute(
//               //             //     builder: (_) => PlaceOrderAddressAdd(id: 0),
//               //             //   ),
//               //             // );
//               //           },
//               //           style: ElevatedButton.styleFrom(
//               //             backgroundColor: const Color(0xffFF620D),
//               //
//               //           ),
//               //           child: const Text(
//               //             "Add Address",
//               //             style: TextStyle(color: Colors.white),
//               //           ),
//               //         ),
//               //       ),
//               //
//               //       //const SizedBox(height: 10),
//               //
//               //
//               //       // Expanded(
//               //       //   child: pro.addressList.isEmpty
//               //       //       ? const Center(
//               //       //     child: Text(
//               //       //       "No address added yet",
//               //       //       style: TextStyle(fontSize: 16),
//               //       //     ),
//               //       //   )
//               //       //       : ListView.builder(
//               //       //     itemCount: pro.addressList.length,
//               //       //     itemBuilder: (context, index) {
//               //       //       final items = pro.addressList[index];
//               //       //
//               //       //       return Card(
//               //       //         color: Colors.orange.shade200,
//               //       //         margin:
//               //       //         const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
//               //       //         child: Padding(
//               //       //           padding: const EdgeInsets.all(12),
//               //       //           child: Row(
//               //       //             crossAxisAlignment: CrossAxisAlignment.start,
//               //       //             children: [
//               //       //               Expanded(
//               //       //                 child: Column(
//               //       //                   crossAxisAlignment: CrossAxisAlignment.start,
//               //       //                   children: [
//               //       //                     Text("Land Mark: ${items.landMark}"),
//               //       //                     Text("State: ${items.state}"),
//               //       //                     Text("Pin Code: ${items.pinCode}"),
//               //       //                     Text("District: ${items.district}"),
//               //       //                     Text("Mobile: ${items.mobileNumber}"),
//               //       //                     Text(
//               //       //                       "Full Address: ${items.fullAddress}",
//               //       //                       maxLines: 2,
//               //       //                       overflow: TextOverflow.ellipsis,
//               //       //                     ),
//               //       //                   ],
//               //       //                 ),
//               //       //               ),
//               //       //
//               //       //
//               //       //               IconButton(
//               //       //                 icon: const Icon(Icons.edit),
//               //       //                 onPressed: () {
//               //       //                   // Navigator.push(
//               //       //                   //   context,
//               //       //                   //   MaterialPageRoute(
//               //       //                   //     builder: (_) =>
//               //       //                   //         PlaceOrderAddressAdd(id: items.id),
//               //       //                   //   ),
//               //       //                   // );
//               //       //                 },
//               //       //               ),
//               //       //
//               //       //               // 🗑 Delete
//               //       //               IconButton(
//               //       //                 icon: const Icon(Icons.delete, color: Colors.red),
//               //       //                 onPressed: () {
//               //       //                   showDialog(
//               //       //                     context: context,
//               //       //                     builder: (_) => AlertDialog(
//               //       //                       title: const Text("Delete Address"),
//               //       //                       content: const Text(
//               //       //                           "Are you sure you want to delete this address?"),
//               //       //                       actions: [
//               //       //                         TextButton(
//               //       //                           onPressed: () =>
//               //       //                               Navigator.pop(context),
//               //       //                           child: const Text("Cancel"),
//               //       //                         ),
//               //       //                         TextButton(
//               //       //                           onPressed: () async {
//               //       //                             Navigator.pop(context);
//               //       //
//               //       //                           },
//               //       //                           child: const Text(
//               //       //                             "Delete",
//               //       //                             style: TextStyle(color: Colors.red),
//               //       //                           ),
//               //       //                         ),
//               //       //                       ],
//               //       //                     ),
//               //       //                   );
//               //       //                 },
//               //       //               ),
//               //       //             ],
//               //       //           ),
//               //       //         ),
//               //       //       );
//               //       //     },
//               //       //   ),
//               //       // ),
//               //     ],
//               //   ),
//               // ),
//
//
//             // SizedBox(
//             //   height: height * 0.45,
//             //   child: Column(
//             //     crossAxisAlignment: CrossAxisAlignment.start,
//             //     children: [
//             //
//             //       // if (pro.addressList.isEmpty)
//             //         // Expanded(
//             //         //   child: Center(
//             //         //     child: ElevatedButton(
//             //         //       onPressed: () {
//             //         //        Navigator.push(context, MaterialPageRoute(builder: (context) => PlaceOrderAddressAdd(id: id),));
//             //         //       },
//             //         //
//             //         //       style: ElevatedButton.styleFrom(
//             //         //
//             //         //         backgroundColor: const Color(0xffFF620D),
//             //         //       ),
//             //         //       child: const Text(
//             //         //         "Add Address",
//             //         //         style: TextStyle(color: Colors.white, fontSize: 15),
//             //         //       ),
//             //         //     ),
//             //         //   ),
//             //         // )
//             //
//             //
//             //       // else
//             //         Expanded(
//             //           child: ListView.builder(
//             //             itemCount: pro.addressList.length,
//             //             itemBuilder: (context, index) {
//             //               final items = pro.addressList[index];
//             //
//             //               return Card(
//             //                 color: Colors.orange.shade200,
//             //                 margin: const EdgeInsets.symmetric(
//             //                   horizontal: 8,
//             //                   vertical: 6,
//             //                 ),
//             //                 child: Padding(
//             //                   padding: const EdgeInsets.all(12),
//             //                   child: Row(
//             //                     crossAxisAlignment: CrossAxisAlignment.start,
//             //                     children: [
//             //                       // Address fields (unchanged)
//             //                       Expanded(
//             //                         child: Column(
//             //                           crossAxisAlignment: CrossAxisAlignment.start,
//             //                           children: [
//             //                             Text("Land Mark: ${items.landMark}",
//             //                                 style:TextStyle(fontSize: 16)),
//             //                             Text("State: ${items.state}",
//             //                                 style:TextStyle(fontSize: 16)),
//             //                             Text("Pin Code: ${items.pinCode}",
//             //                                 style:TextStyle(fontSize: 16)),
//             //                             Text("District: ${items.district}",
//             //                                 style:TextStyle(fontSize: 16)),
//             //                             Text("Mobile: ${items.mobileNumber}",
//             //                                 style:TextStyle(fontSize: 16)),
//             //                             Text(
//             //                               "Full Address: ${items.fullAddress}",
//             //                               maxLines: 2,
//             //                               overflow: TextOverflow.ellipsis,
//             //                               style: const TextStyle(fontSize: 16),
//             //                             ),
//             //                           ],
//             //                         ),
//             //                       ),
//             //
//             //                       // Edit button
//             //                       // IconButton(
//             //                       //   icon: const Icon(Icons.edit),
//             //                       //   onPressed: () {
//             //                       //     Navigator.push(
//             //                       //       context,
//             //                       //       MaterialPageRoute(
//             //                       //         builder: (_) =>
//             //                       //             PlaceOrderAddressUpdateScreen(
//             //                       //               id: items.id,
//             //                       //             ),
//             //                       //       ),
//             //                       //     );
//             //                       //   },
//             //                       // ),
//             //
//             //                       // Delete button
//             //                       IconButton(
//             //                         icon: const Icon(
//             //                           Icons.delete,
//             //                           color: Colors.red,
//             //                         ),
//             //                         onPressed: () {
//             //                           // delete logic
//             //                         },
//             //                       ),
//             //                     ],
//             //                   ),
//             //                 ),
//             //               );
//             //             },
//             //           ),
//             //         ),
//             //     ],
//             //   ),
//             // ),
//               ListView.builder(shrinkWrap: true,
//                 physics: NeverScrollableScrollPhysics(),
//                 itemCount: addressProvider.addressList.length,
//                 itemBuilder: (context, index) {
//                 var item=addressProvider.addressList[index];
//                 return Card(child:
//                   Column(children: [
//                     Text("LandMark:${item.landMark}"),
//                     Text("District:${item.district}"),
//                   ],),);
//
//               },),
//
//             SizedBox(height: 35),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   const Text("TOTAL:",
//                       style:
//                       TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//                   Text("₹${provider.totalAmount.toInt()}",
//                       style:
//                       const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//                 ],
//               ),
//               const SizedBox(height: 20),
//               SizedBox(
//                 width: double.infinity,
//                 height: 55,
//                 child:
//                 ElevatedButton(
//                   onPressed: () {
//                     var provider = Provider.of<CartProvider>(context, listen: false);
//                     if (selectedPayment == 0) {
//                       // Navigator.push(context,
//                       //     MaterialPageRoute(builder: (_) => CaseOrderSummaryScreen(cartItems: provider.cartList)));
//                     }
//                     else if (selectedPayment == 1) {
//                       // Navigator.push(
//                       //   context,
//                       //   MaterialPageRoute(
//                       //     builder: (_) => OrderSummeryScreen(cartItems: provider.cartList),
//                       //   ),
//                       // );
//                     }
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: const Color(0xffFF620D),
//                     shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(12)),
//                   ),
//                   child: const Text("PAY & CONFIRM", style: TextStyle(color: Colors.white, fontSize: 17)),
//                 ),
//               ),
//
//
//               const SizedBox(height: 20),
//
//
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zaykazone/view/screens/payment/add_new_card_screen.dart';

import '../../../controller/cart_provider/cart_provider.dart';
import '../../../controller/place_order_address_provider/place_order_address_provider.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  int selectedPayment = 0;

  final List<Map<String, dynamic>> paymentMethods = [
    {"icon": Icons.payments_rounded, "title": "Cash"},
    {"icon": Icons.book_online_outlined, "title": "UPI"},
    {"icon": Icons.credit_card_rounded, "title": "Visa"},
    {"icon": Icons.account_balance_wallet, "title": "Wallet"},
  ];

  @override
  void initState() {
    super.initState();
    Provider.of<PlaceOrderAddressProvider>(
      context,
      listen: false,
    ).addressGet(context);
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    final cartProvider = Provider.of<CartProvider>(context);
    final addressProvider = Provider.of<PlaceOrderAddressProvider>(context);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Payment"),
          centerTitle: true,
          backgroundColor: const Color(0xffFF620D),
          foregroundColor: Colors.white,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: ListView(
            children: [

              SizedBox(
                height: height * 0.15,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: paymentMethods.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 12),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () => setState(() => selectedPayment = index),
                      child: Column(
                        children: [
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            width: width * 0.23,
                            height: height * 0.10,
                            decoration: BoxDecoration(
                              color: selectedPayment == index
                                  ? const Color(0xffFFEEE2)
                                  : const Color(0xffECEDEF),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: selectedPayment == index
                                    ? const Color(0xffFF620D)
                                    : const Color(0xffFFEEE2),
                                width: 1.5,
                              ),
                            ),
                            child: Icon(
                              paymentMethods[index]["icon"],
                              color: const Color(0xffFF620D),
                              size: 28,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            paymentMethods[index]["title"],
                            style: const TextStyle(
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 25),

              /// ================= CARD SECTION =================
              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: const Color(0xffECEDEF),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Column(
                  children: [
                    Image.asset(
                      "assets/images/img_3.png",
                      width: width * 0.35,
                      height: height * 0.08,
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      "No Mastercard Added\nAdd a new card & save it for later",
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const AddNewCardScreen(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                      ),
                      child: const Text(
                        "+ ADD NEW CARD",
                        style: TextStyle(color: Color(0xffFF620D)),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),
              addressProvider.addressList.isEmpty
                  ? Center(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Text("No address found"),
                ),
              )
                  : ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: addressProvider.addressList.length,
                itemBuilder: (context, index) {
                  var item = addressProvider.addressList[index];
                  return Text(item.landMark);

                  // return Card(
                  //   child: Padding(
                  //     padding: const EdgeInsets.all(12),
                  //     child: Column(
                  //       crossAxisAlignment:
                  //       CrossAxisAlignment.start,
                  //       children: [
                  //         Text("Landmark: ${item.landMark}"),
                  //         Text("District: ${item.district}"),
                  //         Text("PinCode: ${item.pinCode}"),
                  //         Text("Mobile: ${item.mobileNumber}"),
                  //       ],
                  //     ),
                  //   ),
                  // );
                },
              ),

              const SizedBox(height: 30),


              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "TOTAL:",
                    style:
                    TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "₹${cartProvider.totalAmount.toInt()}",
                    style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              /// ================= PAY BUTTON =================
              SizedBox(
                height: 55,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xffFF620D),
                  ),
                  child: const Text(
                    "PAY & CONFIRM",
                    style: TextStyle(color: Colors.white, fontSize: 17),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:shimmer/shimmer.dart';
//
// class MyCartScreen extends StatefulWidget {
//   const MyCartScreen({super.key});
//
//   @override
//   State<MyCartScreen> createState() => _MyCartScreenState();
// }
//
// class _MyCartScreenState extends State<MyCartScreen> {
//   bool isLoading = true;
//
//   List<CartItem> cartItems = [
//     CartItem(
//         title: "pizza",
//         price: 120,
//         quantity: 1,
//         image:
//         "https://dynamic-media-cdn.tripadvisor.com/media/photo-o/2a/ba/f5/c6/the-best-pizza-we-ever.jpg?w=900&h=-1&s=1"
//     ),
//     // CartItem(
//     //     title: "Banana",
//     //     price: 60,
//     //     quantity: 2,
//     //     image:
//     //     "https://images.pexels.com/photos/4198027/pexels-photo-4198027.jpeg"),
//   ];
//
//   @override
//   void initState() {
//     super.initState();
//     Future.delayed(const Duration(seconds: 1), () {
//       setState(() {
//         isLoading = false;
//       });
//     });
//   }
//
//   void updateQuantity(int index, int change) {
//     setState(() {
//       cartItems[index].quantity += change;
//       if (cartItems[index].quantity < 1) {
//         cartItems[index].quantity = 1;
//       }
//     });
//   }
//
//   void removeItem(int index) {
//     setState(() {
//       cartItems.removeAt(index);
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFF5F6FA),
//       appBar: AppBar(
//         title: const Text("My Cart"),
//         backgroundColor: Colors.white,
//         elevation: 0,
//         centerTitle: true,
//         foregroundColor: Colors.black,
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: isLoading
//                 ? ListView.builder(
//               itemCount: 6,
//               padding: const EdgeInsets.all(16),
//               itemBuilder: (context, index) {
//                 return Shimmer.fromColors(
//                   baseColor: Colors.grey.shade300,
//                   highlightColor: Colors.grey.shade100,
//                   child: Container(
//                     height: 120,
//                     margin: const EdgeInsets.only(bottom: 16),
//                     decoration: BoxDecoration(
//                       color: Colors.grey,
//                       borderRadius: BorderRadius.circular(16),
//                     ),
//                   ),
//                 );
//               },
//             )
//                 : cartItems.isEmpty
//                 ? const Center(
//               child: Text(
//                 "Your cart is empty",
//                 style: TextStyle(fontSize: 18),
//               ),
//             )
//                 : ListView.builder(
//               padding: const EdgeInsets.all(16),
//               itemCount: cartItems.length,
//               itemBuilder: (context, index) {
//                 final item = cartItems[index];
//                 return Container(
//                   margin: const EdgeInsets.only(bottom: 16),
//                   padding: const EdgeInsets.all(12),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(16),
//                     boxShadow: const [
//                       BoxShadow(
//                         color: Colors.black12,
//                         blurRadius: 6,
//                         offset: Offset(0, 3),
//                       ),
//                     ],
//                     border: Border.all(color: Colors.deepOrange),
//                   ),
//                   child: Row(
//                     children: [
//                       ClipRRect(
//                         borderRadius: BorderRadius.circular(12),
//                         child: Image.network(
//                           item.image,
//                           height: 85,
//                           width: 80,
//                           fit: BoxFit.cover,
//                         ),
//                       ),
//                       const SizedBox(width: 12),
//                       Expanded(
//                         child: Column(
//                           crossAxisAlignment:
//                           CrossAxisAlignment.start,
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Text(
//                               item.title,
//                               maxLines: 2,
//                               style: const TextStyle(
//                                   fontWeight: FontWeight.w600,
//                                   fontSize: 16),
//                             ),
//                             const SizedBox(height: 4),
//                             Text(
//                               "₹${item.price}",
//                               style: const TextStyle(
//                                   color: Colors.black),
//                             ),
//                           ],
//                         ),
//                       ),
//                       Column(
//                         children: [
//                           Container(
//                             height: 45,
//                             decoration: BoxDecoration(
//                               color: Colors.orange.shade50,
//                               borderRadius: BorderRadius.circular(10),
//                             ),
//                             child: Row(
//                               children: [
//                                 IconButton(
//                                   icon: const Icon(
//                                     Icons.remove_circle_outline,
//                                     color: Colors.deepOrange,
//                                   ),
//                                   onPressed: () {
//                                     updateQuantity(index, -1);
//                                   },
//                                 ),
//                                 Text(
//                                   "${item.quantity}",
//                                   style: const TextStyle(
//                                       fontWeight: FontWeight.bold,
//                                       color: Colors.deepOrange),
//                                 ),
//                                 IconButton(
//                                   icon: const Icon(
//                                     Icons.add_circle_outline,
//                                     color: Colors.deepOrange,
//                                   ),
//                                   onPressed: () {
//                                     updateQuantity(index, 1);
//                                   },
//                                 ),
//                               ],
//                             ),
//                           ),
//                           const SizedBox(height: 8),
//                           IconButton(
//                             icon: const Icon(
//                               Icons.delete_outline,
//                               color: Colors.deepOrange,
//                               size: 28,
//                             ),
//                             onPressed: () {
//                               removeItem(index);
//                             },
//                           ),
//                         ],
//                       )
//                     ],
//                   ),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//
//
//
//       Container(
//         height: 120,
//         padding:
//         const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//         decoration: BoxDecoration(
//           boxShadow: [BoxShadow(blurRadius: 3, color: Colors.black26)],
//           borderRadius: const BorderRadius.only(
//               topRight: Radius.circular(30),
//               topLeft: Radius.circular(30)),
//           color: Colors.white,
//           border: Border.all(width: 1, color: Colors.green),
//         ),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const Text(
//                   "Total Price",
//                   style: TextStyle(fontSize: 14, color: Colors.grey),
//                 ),
//                 const SizedBox(height: 4),
//                 const Text(
//                   "Free Delivery",
//                   style: TextStyle(fontSize: 14, color: Colors.grey),
//                 ),
//                 const SizedBox(height: 4),
//                 // Text(
//                 //   "₹${totalAmount().toInt()}",
//                 //   style: const TextStyle(
//                 //     fontSize: 18,
//                 //     fontWeight: FontWeight.bold,
//                 //   ),
//                 // ),
//               ],
//             ),
//             ElevatedButton(
//               onPressed: () async {
//                 // var amountInRupees = totalAmount();
//                 // var amountInPaisa = (amountInRupees.toInt() * 100).toInt();
//                 // var orderID=await RazorpayApiId.ApiRazorPayIdRequest(amountInPaisa);
//
//                 // if (orderID == null) {
//                 //   ScaffoldMessenger.of(context).showSnackBar(
//                 //       const SnackBar(
//                 //           content: Text("Failed to generate order ID"))
//                 //   );
//                 //   return;
//                 // }
//                 // var options = {
//                 //   'key': 'rzp_test_RD1pZKGIvZI1eu',
//                 //   'amount': amountInPaisa,
//                 //   "order_id": orderID,
//                 //   'name': 'Acme Corp.',
//                 //   'description': 'Fine T-Shirt',
//                 //   'prefill': {
//                 //     'contact': '8888888888',
//                 //     'email': 'test@razorpay.com'
//                 //   }
//               },
//                 // _razorpay?.open(options);
//
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.green,
//                 padding: const EdgeInsets.symmetric(
//                     horizontal: 24, vertical: 12),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//               ),
//               child: const Text(
//                 "Checkout",
//                 style: TextStyle(color: Colors.white),
//               ),
//             ),
//           ],
//         ),
//       ),
//       ];
//
//     );
//   }
// }
//
// class CartItem {
//   String title;
//   int price;
//   int quantity;
//   String image;
//
//   CartItem(
//       {required this.title,
//         required this.price,
//         required this.quantity,
//         required this.image});
// }


import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class MyCartScreen extends StatefulWidget {
  const MyCartScreen({super.key});

  @override
  State<MyCartScreen> createState() => _MyCartScreenState();
}

class _MyCartScreenState extends State<MyCartScreen> {
  bool isLoading = true;

  List<CartItem> cartItems = [
    CartItem(
      title: "Pizza",
      price: 120,
      quantity: 1,
      image:
      "https://dynamic-media-cdn.tripadvisor.com/media/photo-o/2a/ba/f5/c6/the-best-pizza-we-ever.jpg?w=900&h=-1&s=1",
    ),
  ];

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        isLoading = false;
      });
    });
  }

  void updateQuantity(int index, int change) {
    setState(() {
      cartItems[index].quantity += change;
      if (cartItems[index].quantity < 1) {
        cartItems[index].quantity = 1;
      }
    });
  }

  void removeItem(int index) {
    setState(() {
      cartItems.removeAt(index);
    });
  }

  double totalAmount() {
    double total = 0;
    for (var item in cartItems) {
      total += item.price * item.quantity;
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),

      appBar: AppBar(
        title: const Text("My Cart"),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        foregroundColor: Colors.black,
      ),


      body: Column(
        children: [
          Expanded(
            child: isLoading
                ? ListView.builder(
              itemCount: 6,
              padding: const EdgeInsets.all(16),
              itemBuilder: (context, index) {
                return Shimmer.fromColors(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade100,
                  child: Container(
                    height: 120,
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                );
              },
            )
                : cartItems.isEmpty
                ? const Center(
              child: Text(
                "Your cart is empty",
                style: TextStyle(fontSize: 18),
              ),
            )
                : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                final item = cartItems[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 6,
                        offset: Offset(0, 3),
                      ),
                    ],
                    border: Border.all(color: Colors.deepOrange),
                  ),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                          item.image,
                          height: 85,
                          width: 80,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 12),


                      Expanded(
                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              item.title,
                              maxLines: 2,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "₹${item.price}",
                              style: const TextStyle(
                                  color: Colors.black),
                            ),
                          ],
                        ),
                      ),


                      Column(
                        children: [
                          Container(
                            height: 45,
                            decoration: BoxDecoration(
                              color: Colors.orange.shade50,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              children: [
                                IconButton(
                                  icon: const Icon(
                                    Icons.remove_circle_outline,
                                    color: Colors.deepOrange,
                                  ),
                                  onPressed: () =>
                                      updateQuantity(index, -1),
                                ),
                                Text(
                                  "${item.quantity}",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.deepOrange),
                                ),
                                IconButton(
                                  icon: const Icon(
                                    Icons.add_circle_outline,
                                    color: Colors.deepOrange,
                                  ),
                                  onPressed: () =>
                                      updateQuantity(index, 1),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 8),
                          IconButton(
                            icon: const Icon(
                              Icons.delete_outline,
                              color: Colors.deepOrange,
                              size: 28,
                            ),
                            onPressed: () => removeItem(index),
                          ),
                        ],
                      )
                    ],
                  ),
                );
              },
            ),
          ),

          Container(
            height: 140,
            padding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              boxShadow: const [BoxShadow(blurRadius: 3, color: Colors.black26)],
              borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(12),
                  topLeft: Radius.circular(12)),
              color: Colors.white,
              border: Border.all(width: 1, color: Colors.deepOrange),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Total Price",
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      "Free Delivery",
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),

                    const SizedBox(height: 4),
                    Text(
                      "₹${totalAmount().toInt()}",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),

                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepOrange,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  child: const Text(
                    "Checkout",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CartItem {
  String title;
  int price;
  int quantity;
  String image;

  CartItem(
      {required this.title,
        required this.price,
        required this.quantity,
        required this.image});
}

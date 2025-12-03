import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shimmer/shimmer.dart';

import '../../../controller/cart_provider.dart';
import '../../../razorpay/raz_api.dart';

class MyCartScreen extends StatefulWidget {
  const MyCartScreen({super.key});

  @override
  State<MyCartScreen> createState() => _MyCartScreenState();
}

class _MyCartScreenState extends State<MyCartScreen> {
  bool isLoading = true;
  Razorpay? razorpay;
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(milliseconds: 800), () {
      setState(() => isLoading = false);
    });


    razorpay = Razorpay();
    razorpay?.on(Razorpay.EVENT_PAYMENT_SUCCESS, (PaymentSuccessResponse success){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Payment Successfully ${success.paymentId}")));
    });
    razorpay?.on(Razorpay.EVENT_PAYMENT_ERROR, (PaymentFailureResponse error){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Payment failed")));
    });
    razorpay?.on(Razorpay.EVENT_EXTERNAL_WALLET, (ExternalWalletResponse wallet)=>{
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Payment Wallet")))
    });
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<CartProvider>(context);

    return Scaffold(
      // backgroundColor: const Color(0xFFF5F6FA),

      appBar: AppBar(
        title:  Padding(
          padding: const EdgeInsets.only(right: 49),
          child: Text("My Cart"),
        ),
        foregroundColor: Colors.white
      ),

      body: Column(
        children: [
          Expanded(
            child: isLoading
                ? shimmerEffect()
                : provider.cartList.isEmpty
                ? const Center(
              child: Text("My cart is empty", style: TextStyle(fontSize: 18)),
            )
                : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: provider.cartList.length,
              itemBuilder: (context, index) {
                final item = provider.cartList[index];
                return cartItemCard(provider, item);
              },
            ),
          ),

          bottomCheckoutBar(provider),
        ],
      ),
    );
  }

  Widget shimmerEffect() {
    return ListView.builder(
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
    );
  }

  Widget cartItemCard(CartProvider provider, item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.deepOrange),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                    child:item.image.startsWith('assets') ? Image.asset(
                      item.image,
                      height:80,
                      width:80,
                      fit:BoxFit.cover,
                      errorBuilder:(context, error, stackTrace) {
                        return Container(
                          color:Colors.grey.shade300,
                          height:80,
                          width:80,
                          child:Icon(Icons.broken_image,color:Colors.grey),
                        );
                      },
                    ) : Image.network(
                        item.image,
                        height:80,
                        width:80,
                       fit:BoxFit.cover,
                      errorBuilder:(context, error, stackTrace) {
                        return Container(
                          color:Colors.grey.shade300,
                          height:80,
                          width:80,
                          child:Icon(Icons.broken_image,color:Colors.grey),
                        );
                      },
                    ),
                ),
                Text(item.title,
                    maxLines: 2,
                    style: const TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 16)),
                const SizedBox(height: 4),
                Text("₹${item.price}",
                    style: const TextStyle(color: Colors.black)),
              ],
            ),
          ),

          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 65,left: 70),
                child: CircleAvatar(
                  radius: 16,
                  backgroundColor: Colors.orange,
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    icon: const Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 16,
                    ),
                    onPressed: () => provider.removeItem(item.id!),
                  ),
                ),
              ),

              Container(
                  height: 45,
                  decoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove_circle_outline,
                            color: Colors.white),
                        onPressed: () {
                          if (item.quantity > 1) {
                            provider.updateQuantity(item.id!, item.quantity - 1);
                          }
                        },
                      ),
                      Text("${item.quantity}",
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                      IconButton(
                        icon: const Icon(Icons.add_circle_outline,
                            color: Colors.white),
                        onPressed: () {
                          provider.updateQuantity(item.id!, item.quantity + 1);
                        },
                      ),
                    ],
                  ),
                ),


            ],
          ),
        ],
      ),
    );
  }

  Widget bottomCheckoutBar(CartProvider provider) {
    return Container(
      height: 140,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        borderRadius:
        const BorderRadius.only(topRight: Radius.circular(12), topLeft: Radius.circular(12)),
        color: Colors.white,
        border: Border.all(width: 1, color: Colors.deepOrange),
        boxShadow: const [BoxShadow(blurRadius: 3, color: Colors.black26)],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Total Price",
                  style: TextStyle(fontSize: 14, color: Colors.grey)),
              Text("₹${provider.totalAmount.toInt()}",
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold)),
            ],
          ),
          ElevatedButton(
            onPressed: () async{
              var orderId=await ApiHelper.CreateId(provider.totalAmount.toInt());
              var amount = (provider.totalAmount * 100).toInt();

              var option={
                'key': 'rzp_test_RD0BiIvkAPO6jt',
                'amount': "$amount",
                'name': 'Acme Corp.',
                'order_id': orderId,
                'description': 'Fine T-Shirt',
                'prefill': {
                  'contact': '8888888888',
                  'email': 'test@razorpay.com'
                }
              };
              razorpay?.open(option);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.deepOrange,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              "Checkout",
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
    );
  }
}

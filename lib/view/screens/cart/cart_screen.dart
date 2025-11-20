import 'package:flutter/material.dart';
import 'package:zaykazone/view/screens/payment/payment_screen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      appBar: AppBar(
        title: const Text("Cart"),
        backgroundColor: const Color(0xffFF620D),
        elevation: 0,
        foregroundColor: Colors.white,
      ),

      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [

          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 3,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () => _openBottomSheet(context, width, height),
                child: Container(
                  margin: const EdgeInsets.only(bottom: 15),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    boxShadow: [BoxShadow(color: Colors.black38,offset: Offset(3, 3),blurRadius: 5,spreadRadius: 2)],
                    color: const Color(0xffffffff),
                    borderRadius: BorderRadius.circular(12),
                  ),

                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          "assets/images/pizza1.jpg",
                          width: width * 0.18,
                          height: width * 0.18,
                          fit: BoxFit.cover,
                        ),
                      ),

                      SizedBox(width: width * 0.04),

                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Pizza Calzone\nEuropean",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold),
                            ),

                            const SizedBox(height: 5),

                            const Text(
                              "₹64",
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
                            ),

                            const SizedBox(height: 12),

                            Row(
                              children: [
                                const Text("14",
                                    style: TextStyle(color: Colors.black54)),

                                const Spacer(),

                                _qtyBtn(Icons.remove),
                                SizedBox(width: width * 0.03),
                                _qtyBtn(Icons.add),
                              ],
                            ),
                          ],
                        ),
                      ),

                      SizedBox(width: width * 0.02),

                      InkWell(
                        onTap: () {},
                        child: Container(
                          width: 35,
                          height: 35,
                          decoration: BoxDecoration(
                              color: const Color(0xffFF620D),
                              borderRadius: BorderRadius.circular(30)),
                          child: const Icon(Icons.close,
                              size: 20, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),

        ],
      ),
    );
  }

  Widget _qtyBtn(IconData icon) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: const Color(0xff41414F),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Icon(icon, color: Colors.white, size: 18),
    );
  }

  void _openBottomSheet(context, width, height) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),

      builder: (_) {
        return Container(
          height: height * 0.30,
          padding: const EdgeInsets.all(20),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Row(
                children: const [
                  Text("DELIVERY ADDRESS",
                      style:
                      TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  Spacer(),
                  Text("EDIT", style: TextStyle(color: Color(0xffFF620D))),
                ],
              ),

              const SizedBox(height: 15),

              TextFormField(
                decoration: InputDecoration(
                  hintText: "Delivery Address",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
              ),

              const SizedBox(height: 25),

              Row(
                children: const [
                  Text("TOTAL: ₹96",
                      style:
                      TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  Spacer(),
                  Text("Breakdown >",
                      style: TextStyle(color: Color(0xffFF620D))),
                ],
              ),

             SizedBox(height: 15,),

              Center(
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xffFF620D),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      padding: const EdgeInsets.symmetric(vertical: 15),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const PaymentScreen()));
                    },
                    child: const Text("PLACE ORDER",
                        style: TextStyle(color: Colors.white, fontSize: 16)),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zaykazone/controller/user_provider/restaurant_details_provider.dart';

class R extends StatefulWidget {
  const R({super.key});

  @override
  State<R> createState() => _RState();
}

class _RState extends State<R> {
  @override
  void initState() {
    super.initState();
    Provider.of<RestaurantDetailsProvider>(context,listen: false).getProduct();
  }
  @override

  Widget build(BuildContext context) {
    var provider=Provider.of<RestaurantDetailsProvider>(context);
    return SafeArea(child: Scaffold(appBar: AppBar(title: Text("R"),),

    body: ListView.builder(itemCount: provider.listProduct.length,
      itemBuilder: (context, index) {
      var data=provider.listProduct[index];
      return Column(crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            "http://192.168.93.62:3000/uploads/${data.image_url}",
            fit: BoxFit.cover,
          ),

          Text("Name:${data.name}"),
        Text("Description:${data.description}"),

      ],);

    },),

    ));
  }
}

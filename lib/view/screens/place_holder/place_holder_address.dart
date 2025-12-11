import 'package:flutter/material.dart';
class PlaceHolderAddress extends StatefulWidget {
  const PlaceHolderAddress({super.key});

  @override
  State<PlaceHolderAddress> createState() => _PlaceHolderAddressState();
}

class _PlaceHolderAddressState extends State<PlaceHolderAddress> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(appBar: AppBar(title: Text("PlaceHolderAddress"),),
    body: ListView(children: [

    ],),));
  }
}

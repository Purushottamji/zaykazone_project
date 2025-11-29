
import 'package:flutter/material.dart';

import '../../view/screens/editAdrees/editAdress_screen.dart';

class UserAddressProvider with ChangeNotifier{

  final addressController=TextEditingController();
  final streetController=TextEditingController();
  final flatController=TextEditingController();
  final pinController=TextEditingController();

  List<Map<String,dynamic>> address=[
    {
      "label":"HOME",
      "icon":Icons.home,
      "address":"Amnour",
      "street":"Amnour jan",
      "pin_code":"841405",
      "flat_no":"302"
    },
    {
      "label":"WORK",
      "icon":Icons.work,
      "address":"Patna",
      "street":"Kurji Mod",
      "pin_code":"841401",
      "flat_no":"233"
    },
  ];

  editAddress(int index,BuildContext context){
    addressController.text=address[index]["address"];
    streetController.text=address[index]["street"];
    flatController.text=address[index]["flat_no"];
    pinController.text=address[index]["pin_code"];
    notifyListeners();
    Navigator.push(context, MaterialPageRoute(builder: (context) => EditAddressScreen(),));
  }

  Future removeAddress(int index,BuildContext context){
   return showDialog(context: context, builder: (context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        title: Row(children: [Icon(Icons.delete,color: Colors.red,),SizedBox(width: 10,),Text("Address",style: TextStyle(color: Colors.red),)],),
        content: Text("Are you sure you want to delete your ${address[index]["label"]} address ?"),
        actions: [
          TextButton(onPressed: () {
            Navigator.pop(context);
          }, child: Text("No")),
          TextButton(onPressed: () {
            address.removeAt(index);
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("${address[index]["label"]} address deleted")));
            Navigator.pop(context);
            notifyListeners();
          }, child: Text("Yes",style: TextStyle(color: Colors.blue),)),
        ],
      );
    },);
  }
}
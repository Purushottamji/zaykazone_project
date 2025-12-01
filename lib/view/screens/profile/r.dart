void main(){
  var name=[{"p":""},{"p":""},{"p":""}];
  List<Map<String,dynamic>> address=[
    {
      "label":"HOME",
      "address":"Amnour",
      "street":"Amnour jan",
      "pin_code":"841405",
      "flat_no":"302"
    },
    {
      "label":"WORK",
      "address":"Patna",
      "street":"Kurji Mod",
      "pin_code":"841401",
      "flat_no":"233"
    },
  ];
 print(address.indexOf(address[0]));
}
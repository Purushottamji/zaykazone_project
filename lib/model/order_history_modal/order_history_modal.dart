class OrderHistoryModal {
 int? id;
 int? user_id;
 int? p_o_a_id;
 int? res_id;
 int? food_id;
 String? food_name;
 String? quantity;
 String? total_price;

 OrderHistoryModal(
     this.id,
     this.user_id,
     this.p_o_a_id,
     this.res_id,
     this.food_id,
     this.food_name,
     this.quantity,
     this.total_price);

static OrderHistoryModal orderModal(Map<String,dynamic> data){
   return OrderHistoryModal(
       data["id"],
       data["user_id"],
       data["p_o_a_id"],
       data["res_id"],
       data["food_id"],
       data ["food_name"],
       data["quantity"],
       data["total_price"]);

 }
 Map<String,dynamic> toJson(){
  return{
    'id': id,
    'user_id': user_id,
    'p_o_a_id': p_o_a_id,
    'res_id': res_id,
    'food_id': food_id,
    'food_name': food_name,
    'quantity': quantity,
    'total_price': total_price,

  };

 }



}




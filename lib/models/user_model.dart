class UserModel{
  int id;
  String name;
  String email;
  String phone;
  int orderCount;

  UserModel({
    required this.id,
    required this.name,
    required this.phone,
    required this.orderCount,
    required this.email,
  });

  factory UserModel.fromJson(Map<String, dynamic> json){
    return UserModel(
      id: json['id'],
      name: json['f_name'],
      email: json['email'],
      phone: json['phone'],
      orderCount: json['order_count'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    //data['id'] = this.id;
    data['f_name'] = this.name;
    data['email'] = this.email;
   // data['image'] = this.image;
    data['phone'] = this.phone;
    //data['password'] = this.password;
    data['order_count'] = this.orderCount;
    //data['member_since_days'] = this.memberSinceDays;
    return data;
  }
}
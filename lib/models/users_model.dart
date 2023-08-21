class UserModel {
  String? name;
  String? age;
  int? id;
  String? phone;

  UserModel({this.id, this.phone, this.name, this.age});


  Map<String, dynamic> toJson() => {
    'id': id,
    'age':age,
    'name':name,
    'phone':phone,
  };

  factory UserModel.fromJson(Map<String,dynamic> json) => UserModel(
    id: json['id'],
    phone: json['phone'],
    name: json['name'],
    age: json['age']
  );
}

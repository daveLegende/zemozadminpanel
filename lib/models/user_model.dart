import 'dart:convert';

class UserModel {
  String? id;
  String username;
  String email;
  String password;
  String phone;
  String solde;

  UserModel({
    this.id,
    required this.username,
    required this.email,
    required this.password,
    required this.phone,
    required this.solde,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['_id'],
      username: json['username'] ?? '',
      email: json['email'] ?? '',
      password: json['password'] ?? '',
      phone: json['phone'] ?? '',
      solde: json['solde'].toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      // 'id': id,
      'username': username,
      'email': email,
      'password': password,
      'phone': phone,
      'solde': solde.toString(),
    };
  }
}

// list des users
List<UserModel> usersListFromJson(String jsonString) {
  var data = json.decode(jsonString);
  return List<UserModel>.from(
    data.map((items) => UserModel.fromJson(items)),
  );
}

UserModel default_user = UserModel(
  username: "",
  email: "",
  password: "",
  phone: "",
  solde: "",
);

import 'dart:convert';

class Admin {
  String? id;
  String email;
  String password;

  Admin({
    this.id,
    required this.email,
    required this.password,
  });

  factory Admin.fromJson(Map<String, dynamic> json) {
    return Admin(
      id: json['_id'],
      email: json['email'] ?? '',
      password: json['password'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      // 'id': id,
      'email': email,
      'password': password,
    };
  }
}


// list des admins
List<Admin> adminListFromJson(String jsonString) {
  var data = json.decode(jsonString);
  return List<Admin>.from(
    data.map((items) => Admin.fromJson(items)),
  );
}
// get current admin
  Admin adminFromJson(String jsonString) {
    var data = json.decode(jsonString);
    return Admin.fromJson(data);
  }

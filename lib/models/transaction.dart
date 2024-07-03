import 'dart:convert';

import 'package:admin/models/admin.dart';
import 'package:admin/models/user_model.dart';

class TransactionModel {
  String? id;
  String amount;
  String type;
  String date;
  Admin admin;
  UserModel user;

  TransactionModel({
    this.id,
    required this.amount,
    required this.type,
    required this.date,
    required this.admin,
    required this.user,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      id: json["_id"].toString(),
      amount: json["amount"] ?? '',
      type: json["type"] ?? '',
      date: json["date"] ?? '',
      admin: Admin.fromJson(json["admin"]),
      user: UserModel.fromJson(json["user"]),
    );
  }
}


// list des transactions
List<TransactionModel> transacListFromJson(String jsonString) {
  var data = json.decode(jsonString);
  return List<TransactionModel>.from(
    data.map((items) => TransactionModel.fromJson(items)),
  );
}
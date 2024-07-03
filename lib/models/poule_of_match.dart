import 'dart:convert';

// import 'package:zemoz/models/equipe.dart';

class POM {
  String? id;
  String nom;
  POM({
    this.id,
    required this.nom,
  });

  factory POM.fromJson(Map<String, dynamic> json) {
    return POM(
      id: json['_id'],
      nom: json['nom'],
    );
  }
}

// list des matchs
List<POM> pomListFromJson(String jsonString) {
  var data = json.decode(jsonString);
  return List<POM>.from(
    data.map((items) => POM.fromJson(items)),
  );
}
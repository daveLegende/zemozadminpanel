import 'dart:convert';

import 'package:admin/models/equipe.dart';

class PouleModel {
  String? id;
  String nom;
  List<EquipeModel> equipes;
  PouleModel({
    this.id,
    required this.nom,
    required this.equipes,
  });

  factory PouleModel.fromJson(Map<String, dynamic> json) {
    List<EquipeModel> equipesList = List<EquipeModel>.from(
        json['equipes']?.map((e) => EquipeModel.fromJson(e)) ?? []);
    return PouleModel(
      id: json['_id'],
      nom: json['nom'],
      equipes: equipesList,
    );
  }

  // Méthode pour calculer le classement des équipes dans la poule
  List<EquipeModel> calculerClassement() {
    equipes.sort((a, b) {
      // Trie par points décroissant
      if (a.points != b.points) {
        return b.points.compareTo(a.points);
      }
      // Trie par différence de buts décroissante
      int diffButsA = a.nombreButsMarques - a.nombreButsConcedes;
      int diffButsB = b.nombreButsMarques - b.nombreButsConcedes;
      if (diffButsA != diffButsB) {
        return diffButsB.compareTo(diffButsA);
      }
      // Trie par nombre de buts marqués décroissant
      if (a.nombreButsMarques != b.nombreButsMarques) {
        return b.nombreButsMarques.compareTo(a.nombreButsMarques);
      }
      // Trie par nombre de matchs joués croissant
      return a.nombreMatchsJoues.compareTo(b.nombreMatchsJoues);
    });

    // Mettre à jour les positions
    for (int i = 0; i < equipes.length; i++) {
      equipes[i].position = i + 1;
    }

    return equipes;
  }
}

// list des matchs
List<PouleModel> pouleListFromJson(String jsonString) {
  var data = json.decode(jsonString);
  return List<PouleModel>.from(
    data.map((items) => PouleModel.fromJson(items)),
  );
}

final PouleModel constantPoule = PouleModel(
  nom: "nom",
  equipes: [],
);

// List<PouleModel> poules = [
//   PouleModel(
//     nom: "Poule A",
//     equipes: [],
//   ),
//   PouleModel(
//     nom: "Poule B",
//     equipes: [],
//   ),
//   PouleModel(
//     nom: "Poule C",
//     equipes: [],
//   ),
//   PouleModel(
//     nom: "Poule D",
//     equipes: [],
//   ),
//   PouleModel(
//     nom: "Poule E",
//     equipes: [],
//   ),
//   PouleModel(
//     nom: "Poule F",
//     equipes: [],
//   ),
//   PouleModel(
//     nom: "Poule H",
//     equipes: [],
//   ),
// ];

import 'dart:convert';

class EquipeModel {
  String? id;
  String nom;
  String logo;
  String coach;
  List<String> joueurs;
  int nombreMatchsJoues;
  int nombreButsMarques;
  int nombreButsConcedes;
  String commune;
  int position;
  int points;

  EquipeModel({
    this.id,
    required this.nom,
    required this.logo,
    required this.coach,
    required this.joueurs,
    this.nombreButsMarques = 0,
    this.nombreMatchsJoues = 0,
    this.nombreButsConcedes = 0,
    this.points = 0,
    this.position = 0,
    required this.commune,
  });

  factory EquipeModel.fromJson(Map<String, dynamic> json) {
    // Convertir la liste d'objets "joueurs" en liste de chaînes
    List<String> joueursList = List<String>.from(json['joueurs'] ?? []);
    return EquipeModel(
      id: json['_id'],
      nom: json['nom'] ?? '',
      logo: json['logo'] ?? '',
      coach: json['coach'] ?? '',
      joueurs: joueursList,
      nombreMatchsJoues: json['nombreMatchsJoues'] ?? 0,
      nombreButsMarques: json['nombreButsMarques'] ?? 0,
      nombreButsConcedes: json['nombreButsConcedes'] ?? 0,
      commune: json['commune'],
      points: json['points'] ?? 0,
      position: json['positions'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      // 'id': id,
      'nom': nom,
      'logo': logo,
      'coach': coach,
      'joueurs': joueurs.toString(),
      // 'nombreMatchsJoues': nombreMatchsJoues.toString(),
      // 'nombreButsMarques': nombreButsMarques.toString(),
      'commune': commune,
    };
  }

  // // Méthode pour calculer le classement des équipes dans la poule
  // List<EquipeModel> calculerClassement(List) {
  //   this.equipes.sort((a, b) {
  //     // Trie par points décroissant
  //     if (a.points != b.points) {
  //       return b.points.compareTo(a.points);
  //     }
  //     // Trie par différence de buts décroissante
  //     int diffButsA = a.nombreButsMarques - a.nombreButsConcedes;
  //     int diffButsB = b.nombreButsMarques - b.nombreButsConcedes;
  //     if (diffButsA != diffButsB) {
  //       return diffButsB.compareTo(diffButsA);
  //     }
  //     // Trie par nombre de buts marqués décroissant
  //     if (a.nombreButsMarques != b.nombreButsMarques) {
  //       return b.nombreButsMarques.compareTo(a.nombreButsMarques);
  //     }
  //     // Trie par nombre de matchs joués croissant
  //     return a.nombreMatchsJoues.compareTo(b.nombreMatchsJoues);
  //   });

  //   // Mettre à jour les positions
  //   for (int i = 0; i < equipes.length; i++) {
  //     equipes[i].position = i + 1;
  //   }

  //   return equipes;
  // }
}

EquipeModel constantTeam = EquipeModel(
  nom: "",
  logo: "logo",
  coach: "coach",
  joueurs: [],
  commune: "commune",
);

// list des matchs
List<EquipeModel> equipeListFromJson(String jsonString) {
  var data = json.decode(jsonString);
  return List<EquipeModel>.from(
    data.map((items) => EquipeModel.fromJson(items)),
  );
}

// List<EquipeModel> equipes = [
//   EquipeModel(
//     nom: "ANGES FC",
//     logo: "assets/logos/fb.jpg",
//     coach: "",
//     joueurs: [],
//     nombreMatchsJoues: 0,
//     nombreButsMarques: 0,
//     commune: "Golfe",
//   ),
//   EquipeModel(
//     nom: "AS Master Builder",
//     logo: "assets/logos/requin.jpg",
//     coach: "",
//     joueurs: [],
//     nombreMatchsJoues: 0,
//     nombreButsMarques: 0,
//     commune: "Golfe",
//   ),
//   EquipeModel(
//     nom: "AC ADEWUI",
//     logo: "assets/logos/unknow.jpg",
//     coach: "",
//     joueurs: [],
//     nombreMatchsJoues: 0,
//     nombreButsMarques: 0,
//     commune: "Golfe",
//   ),
//   EquipeModel(
//     nom: "AVENIR FC",
//     logo: "assets/logos/lorem.jpg",
//     coach: "",
//     joueurs: [],
//     nombreMatchsJoues: 0,
//     nombreButsMarques: 0,
//     commune: "Golfe",
//   ),
//   EquipeModel(
//     nom: "COQ D'OR FC",
//     logo: "assets/logos/requin.jpg",
//     coach: "",
//     joueurs: [],
//     nombreMatchsJoues: 0,
//     nombreButsMarques: 0,
//     commune: "Golfe",
//   ),
//   EquipeModel(
//     nom: "DEPORTIVO CALI",
//     logo: "assets/logos/soccer.jpg",
//     coach: "",
//     joueurs: [],
//     nombreMatchsJoues: 0,
//     nombreButsMarques: 0,
//     commune: "Golfe",
//   ),
//   EquipeModel(
//     nom: "DREAM TEAM FC",
//     logo: "assets/logos/unknow.jpg",
//     coach: "",
//     joueurs: [],
//     nombreMatchsJoues: 0,
//     nombreButsMarques: 0,
//     commune: "Golfe",
//   ),
//   EquipeModel(
//     nom: "DUEL FC",
//     logo: "assets/logos/off.jpg",
//     coach: "",
//     joueurs: [],
//     nombreMatchsJoues: 0,
//     nombreButsMarques: 0,
//     commune: "Golfe",
//   ),
//   EquipeModel(
//     nom: "EA FC",
//     logo: "assets/logos/fb.jpg",
//     coach: "",
//     joueurs: [],
//     nombreMatchsJoues: 0,
//     nombreButsMarques: 0,
//     commune: "Golfe",
//   ),
//   EquipeModel(
//     nom: "EMERAUDE FC",
//     logo: "assets/logos/lorem.jpg",
//     coach: "",
//     joueurs: [],
//     nombreMatchsJoues: 0,
//     nombreButsMarques: 0,
//     commune: "Golfe",
//   ),
//   EquipeModel(
//     nom: "EMPR1TE FC",
//     logo: "assets/logos/soccer.jpg",
//     coach: "",
//     joueurs: [],
//     nombreMatchsJoues: 0,
//     nombreButsMarques: 0,
//     commune: "Golfe",
//   ),
//   EquipeModel(
//     nom: "ESPERANCE FC",
//     logo: "assets/logos/off.jpg",
//     coach: "",
//     joueurs: [],
//     nombreMatchsJoues: 0,
//     nombreButsMarques: 0,
//     commune: "Golfe",
//   ),
//   EquipeModel(
//     nom: "ESPOIR FC",
//     logo: "assets/logos/fb.jpg",
//     coach: "",
//     joueurs: [],
//     nombreMatchsJoues: 0,
//     nombreButsMarques: 0,
//     commune: "Golfe",
//   ),
//   EquipeModel(
//     nom: "JAMBE DE FER",
//     logo: "assets/logos/lorem.jpg",
//     coach: "",
//     joueurs: [],
//     nombreMatchsJoues: 0,
//     nombreButsMarques: 0,
//     commune: "Golfe",
//   ),
//   EquipeModel(
//     nom: "L'ALBICELESTE",
//     logo: "assets/logos/soccer.jpg",
//     coach: "",
//     joueurs: [],
//     nombreMatchsJoues: 0,
//     nombreButsMarques: 0,
//     commune: "Golfe",
//   ),
//   EquipeModel(
//     nom: "LIBRO FC",
//     logo: "assets/logos/off.jpg",
//     coach: "",
//     joueurs: [],
//     nombreMatchsJoues: 0,
//     nombreButsMarques: 0,
//     commune: "Golfe",
//   ),
//   EquipeModel(
//     nom: "NEW REVELATION",
//     logo: "assets/logos/fb.jpg",
//     coach: "",
//     joueurs: [],
//     nombreMatchsJoues: 0,
//     nombreButsMarques: 0,
//     commune: "Golfe",
//   ),
//   EquipeModel(
//     nom: "OLYMPIQUE FC",
//     logo: "assets/logos/lorem.jpg",
//     coach: "",
//     joueurs: [],
//     nombreMatchsJoues: 0,
//     nombreButsMarques: 0,
//     commune: "Golfe",
//   ),
//   EquipeModel(
//     nom: "PETIT GENIE FC",
//     logo: "assets/logos/soccer.jpg",
//     coach: "",
//     joueurs: [],
//     nombreMatchsJoues: 0,
//     nombreButsMarques: 0,
//     commune: "Golfe",
//   ),
//   EquipeModel(
//     nom: "ROI SOLEIL",
//     logo: "assets/logos/off.jpg",
//     coach: "",
//     joueurs: [],
//     nombreMatchsJoues: 0,
//     nombreButsMarques: 0,
//     commune: "Golfe",
//   ),
//   EquipeModel(
//     nom: "SAKPAKOUGNATRI",
//     logo: "assets/logos/fb.jpg",
//     coach: "",
//     joueurs: [],
//     nombreMatchsJoues: 0,
//     nombreButsMarques: 0,
//     commune: "Golfe",
//   ),
//   EquipeModel(
//     nom: "SANS SUCIS FC",
//     logo: "assets/logos/lorem.jpg",
//     coach: "",
//     joueurs: [],
//     nombreMatchsJoues: 0,
//     nombreButsMarques: 0,
//     commune: "Golfe",
//   ),
//   EquipeModel(
//     nom: "SUCCES PRO",
//     logo: "assets/logos/soccer.jpg",
//     coach: "",
//     joueurs: [],
//     nombreMatchsJoues: 0,
//     nombreButsMarques: 0,
//     commune: "Golfe",
//   ),
//   EquipeModel(
//     nom: "ZENITH FC",
//     logo: "assets/logos/off.jpg",
//     coach: "",
//     joueurs: [],
//     nombreMatchsJoues: 0,
//     nombreButsMarques: 0,
//     commune: "Golfe",
//   ),
// ];

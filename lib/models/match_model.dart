import 'dart:convert';

import 'equipe.dart';
import 'poule_of_match.dart';

class MatchModel {
  String? id;
  EquipeModel home; // ID de l'équipe à domicile
  EquipeModel away; // ID de l'équipe à l'extérieur
  DateTime date; // Date du match
  String lieu; // Lieu du match
  String type; // Type de match
  Map<String, dynamic> scores; // Scores du match
  List<EventMatch>? events;
  String? etat; // État du match (A_VENIR, EN_COURS, TERMINÉ)
  String? link;
  int? journee; // Numéro de la journée
  POM? poule;

  MatchModel({
    this.id,
    required this.home,
    required this.away,
    required this.date,
    required this.lieu,
    required this.type,
    required this.scores,
    this.events,
    this.etat,
    this.journee,
    this.link,
    this.poule,
  });

  factory MatchModel.fromJson(Map<String, dynamic> json) {
    List<EventMatch> eventLists = List<EventMatch>.from(
        json['events']?.map((e) => EventMatch.fromJson(e)) ?? []);
    return MatchModel(
      id: json['_id'],
      home: EquipeModel.fromJson(json['home']),
      away: EquipeModel.fromJson(json['away']),
      date: DateTime.parse(json['date']),
      lieu: json['lieu'],
      type: json['type'],
      scores: {
        'equipeDomicile': json['scores']['equipeDomicile'],
        'equipeExterieure': json['scores']['equipeExterieure'],
      },
      events: eventLists,
      etat: json['etat'],
      link: json['lien'],
      poule: json['poule'] != null ? POM.fromJson(json['poule']) : null,
      journee: json['journee'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "home": home,
      "away": away,
      "date": date,
      "lieu": lieu,
      "type": type,
      "scores": scores,
    };
  }
}

// List<MatchModel> matchs = [];

// list des matchs
List<MatchModel> matchListFromJson(String jsonString) {
  var data = json.decode(jsonString);
  return List<MatchModel>.from(
    data.map((items) => MatchModel.fromJson(items)),
  );
}

//
class EventMatch {
  String type;
  String equipe;
  String joueur;
  int minute;
  Map<String, dynamic>? details;

  EventMatch({
    required this.type,
    required this.equipe,
    required this.joueur,
    required this.minute,
    this.details,
  });

  factory EventMatch.fromJson(Map<String, dynamic> json) {
    return EventMatch(
      type: json["type"],
      equipe: json["equipe"],
      joueur: json["joueur"],
      minute: json["minute"],
    );
  }
}

int compareByMinute(EventMatch a, EventMatch b) {
  return a.minute.compareTo(b.minute);
}

import 'match_model.dart';

class Bet {
  double cote, mise, gains;
  DateTime date_create;
  List<MatchModel> matchs;
  String etat;

  Bet({
    required this.cote,
    required this.mise,
    required this.gains,
    required this.date_create,
    required this.matchs,
    required this.etat,
  });
}

List<Bet> bets = [
  Bet(
    cote: 12.6,
    mise: 1000,
    gains: 12.6 * 1000,
    date_create: DateTime.now(),
    matchs: [],
    etat: "Accepté",
  ),
  Bet(
    cote: 42,
    mise: 500,
    gains: 42 * 500,
    date_create: DateTime.now(),
    matchs: [],
    etat: "Perdu",
  ),
  Bet(
    cote: 2,
    mise: 550000,
    gains: 2 * 550000,
    date_create: DateTime.now(),
    matchs: [],
    etat: "Gagné",
  ),
  Bet(
    cote: 2.85,
    mise: 100000,
    gains: 2.85 * 100000,
    date_create: DateTime.now(),
    matchs: [],
    etat: "Perdu",
  ),
];

//
//
class BetModel {
  String titlle;
  double homeWin, awayWin, draw;
  BetModel({
    required this.titlle,
    required this.homeWin,
    required this.awayWin,
    required this.draw,
  });
}

final victoire =  BetModel(titlle: "Victoire", homeWin: 1.3, awayWin: 5.1, draw: 1.8,);
final doubleChance =  BetModel(titlle: "Victoire ou Nul", homeWin: 1.3, awayWin: 5.1, draw: 1.8,);
final deuxmarque =  BetModel(titlle: "Deux équipent marquent", homeWin: 1.3, awayWin: 5.1, draw: 1.8,);
final corners =  BetModel(titlle: "Corners", homeWin: 1.3, awayWin: 5.1, draw: 1.8,);
final fautes =  BetModel(titlle: "Fautes", homeWin: 1.3, awayWin: 5.1, draw: 1.8,);
final cartonJaune =  BetModel(titlle: "Carton Jaune", homeWin: 1.3, awayWin: 5.1, draw: 1.8,);
final cartonRouge =  BetModel(titlle: "Carton Rouge", homeWin: 1.3, awayWin: 5.1, draw: 1.8,);

enum BetOutcome { Won, Lost, Pending }

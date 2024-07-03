import 'package:admin/constant.dart';

class OnBoardModel {
  final String title;
  final String path;
  final String desc;

  const OnBoardModel({
    required this.title,
    required this.desc,
    required this.path,
  });
}

List<OnBoardModel> onBoardList = [
  OnBoardModel(
    title: "BIENVENUE",
    desc: "Heureux de vous comptez parmi nous. Une Ouverture du tournoi avec un lancement vraiment spectaculaire",
    path: "$assets/lancement.jpg",
  ),
  OnBoardModel(
    title: "SPECTACLE",
    desc: "Un tournoi qui vous offre plein de spectacle avec différents équipes professionnelle",
    path: "$assets/spetacle.jpeg",
  ),
  OnBoardModel(
    title: "PARIS SPORTIFS",
    desc: "Une occasion pour vous de miser sur votre équipe ou joueur favoris dans les matchs en cours ou à venir pour gagner des gains",
    path: "$assets/bet.jpg",
  ),
];

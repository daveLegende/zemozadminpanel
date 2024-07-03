class TopScorer {
  final String name;
  final String team;
  final int goals;
  int position = 0;

  TopScorer({required this.name, required this.team, required this.goals});
}

List<TopScorer> topScorers = [
  TopScorer(name: "Eza kokou", team: "AVENIR FC", goals: 7),
  TopScorer(name: "Tchesko", team: "ESPOIR FC", goals: 6),
  TopScorer(name: "Zézé", team: "L'ALBICELESTE", goals: 6),
  TopScorer(name: "Pasha Will", team: "ANGES FC", goals: 4),
  TopScorer(name: "Léonardo", team: "ZENITH FC", goals: 4),
  TopScorer(name: "Elano", team: "EA FC", goals: 4),
  TopScorer(name: "Ibrahim", team: "LIBRO FC", goals: 3),
  TopScorer(name: "Kotner", team: "PETIT GENIE FC", goals: 3),
  TopScorer(name: "Dimitri", team: "SANS SOUIS FC", goals: 3),
  TopScorer(name: "Douglas", team: "AS MASTER BUILDER", goals: 3),
];

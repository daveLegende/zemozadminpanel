import 'package:flutter/material.dart';

class Rubrique {
  String label;
  IconData icon;

  Rubrique({
    required this.label,
    required this.icon,
  });
}

List<Rubrique> rubriques = [
  Rubrique(
    label: "Live",
    icon: Icons.live_tv,
  ),
  Rubrique(
    label: "Prochains Matchs",
    icon: Icons.calendar_today,
  ),
  Rubrique(
    label: "Poules",
    icon: Icons.sports_soccer,
  ),
  Rubrique(
    label: "Stats Individuels",
    icon: Icons.history_edu,
  ),
];

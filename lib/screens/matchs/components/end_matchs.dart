import 'package:admin/components/chargement_text.dart';
import 'package:admin/constants.dart';
import 'package:admin/models/match_model.dart';
import 'package:flutter/cupertino.dart';

import 'match_all_widget.dart';

class EndMatches extends StatelessWidget {
  const EndMatches({
    super.key,
    required this.matchs,
    required this.type,
  });
  final String type;
  final List<MatchModel> matchs;

  @override
  Widget build(BuildContext context) {
    // var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: defaultPadding),
      child: matchs.isEmpty
          ? Container(
              height: height / 2,
              child: ErrorText(text: "Aucun Match disponible"),
            )
          : ListView.builder(
              itemCount: matchs.length,
              itemBuilder: (context, index) {
                final e = matchs[index];
                if (e.etat == type) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: MatchGridItem(
                      type: type,
                      match: e,
                    ),
                  );
                } else {
                  return Container();
                }
              },
            ),
    );
  }
}

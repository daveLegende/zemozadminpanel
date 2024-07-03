import 'package:admin/constant.dart';
import 'package:admin/constants.dart';
import 'package:admin/style.dart';
import 'package:flutter/material.dart';

class TicketHeader extends StatelessWidget {
  const TicketHeader({
    super.key,
    required this.today,
    required this.sevenDays,
    required this.monthDays,
    required this.totals,
  });
  final int today, sevenDays, monthDays, totals;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: defaultPadding,
        vertical: defaultPadding,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(
          4,
          (i) {
            return AnalyseItemWidget(
              title: getText(i),
              color: getColor(i),
              nbre: i == 0
                  ? today
                  : i == 1
                      ? sevenDays
                      : i == 2
                          ? monthDays
                          : totals,
            );
          },
        ),
      ),
    );
  }

  getColor(int i) {
    if (i == 0) {
      return bgColor;
    } else if (i == 1) {
      return mColor3;
    } else if (i == 2) {
      return mColor4;
    } else {
      return mColor6;
    }
  }

  getText(int i) {
    if (i == 0) {
      return "Dans la journée";
    } else if (i == 1) {
      return "Il y'a une semaine";
    } else if (i == 2) {
      return "Il y'a un mois";
    } else {
      return "Total acheté";
    }
  }
}

class AnalyseItemWidget extends StatelessWidget {
  const AnalyseItemWidget({
    super.key,
    required this.title,
    required this.nbre, required this.color,
  });
  final String title;
  final int nbre;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Card(
        elevation: 10,
        color: mwhite,
        child: Container(
          width: 150,
          height: 100,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: mwhite,
            borderRadius: BorderRadius.circular(5),
            border: Border(
              left: BorderSide(
                color: color,
                width: 2,
              ),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                title,
                style: StyleText().googleTitre.copyWith(fontSize: 14),
              ),
              Text(
                "$nbre",
                style: StyleText().transStyle.copyWith(color: color),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

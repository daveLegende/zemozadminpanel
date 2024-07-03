import 'package:admin/constant.dart';
import 'package:admin/constants.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class TicketChartScreen extends StatefulWidget {
  @override
  _TicketChartScreenState createState() => _TicketChartScreenState();
}

class _TicketChartScreenState extends State<TicketChartScreen> {
  List<double> ticketsByDay = [
    10,
    20,
    15,
    30,
    25,
    35,
    40
  ]; // Exemple de données
  List<double> ticketsByWeek = [
    50,
    60,
    55,
    70,
    65,
    75,
    80
  ]; // Exemple de données
  List<double> ticketsByMonth = [
    100,
    120,
    110,
    130,
    125,
    135,
    140
  ]; // Exemple de données
  List<double> totalTickets = [
    200,
    250,
    300,
    350,
    400,
    450,
    500
  ]; // Exemple de données

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: LineChart(
        LineChartData(
          titlesData: FlTitlesData(
              bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, titleMeta) {
                switch (value.toInt()) {
                  case 0:
                    return Text("Mon");
                  case 1:
                    return Text('Tue');
                  case 2:
                    return Text('Wed');
                  case 3:
                    return Text('Thu');
                  case 4:
                    return Text('Fri');
                  case 5:
                    return Text('Sat');
                  case 6:
                    return Text('Sun');
                }
                return Container();
              },
            ),
          )),
          lineBarsData: [
            LineChartBarData(
              spots: ticketsByDay
                  .asMap()
                  .entries
                  .map((entry) => FlSpot(entry.key.toDouble(), entry.value))
                  .toList(),
              isCurved: true,
              color: bgColor,
              barWidth: 2,
              isStrokeCapRound: true,
              belowBarData: BarAreaData(show: false),
            ),
            LineChartBarData(
              spots: ticketsByWeek
                  .asMap()
                  .entries
                  .map((entry) => FlSpot(entry.key.toDouble(), entry.value))
                  .toList(),
              isCurved: true,
              color: mColor3,
              barWidth: 2,
              isStrokeCapRound: true,
              belowBarData: BarAreaData(show: false),
            ),
            LineChartBarData(
              spots: ticketsByMonth
                  .asMap()
                  .entries
                  .map((entry) => FlSpot(entry.key.toDouble(), entry.value))
                  .toList(),
              isCurved: true,
              color: mColor4,
              barWidth: 2,
              isStrokeCapRound: true,
              belowBarData: BarAreaData(show: false),
            ),
            LineChartBarData(
              spots: totalTickets
                  .asMap()
                  .entries
                  .map((entry) => FlSpot(entry.key.toDouble(), entry.value))
                  .toList(),
              isCurved: true,
              color: mbSeconderedColorKbe,
              barWidth: 2,
              isStrokeCapRound: true,
              belowBarData: BarAreaData(show: false),
            ),
          ],
          minY: 0,
          maxY: 600,
          gridData: FlGridData(show: true),
          borderData: FlBorderData(show: true),
        ),
      ),
    );
  }
}

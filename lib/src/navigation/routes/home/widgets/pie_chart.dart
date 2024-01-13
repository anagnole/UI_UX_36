import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:snapgoals_v2/src/app_state.dart';
import 'package:provider/provider.dart';

class PieChartWidget extends StatelessWidget {
  const PieChartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<AppState>();
    appState.totalTasksByCategory();

    return FutureBuilder<List<int>>(
        future: appState.futureTaskNumByCategory,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            //appState.snapgoalsDB.deleteAll(); //

            final sums = snapshot.data!;

            List<charts.Series<ChartData, String>> seriesList = [
              charts.Series<ChartData, String>(
                id: 'Categories',
                domainFn: (ChartData data, _) => data.category,
                measureFn: (ChartData data, _) => data.value,
                colorFn: (ChartData data, _) => charts.ColorUtil.fromDartColor(
                    _getColorForCategory(data.category)),
                data: [
                  ChartData('Fitness', sums[0]),

                  /// ayta edo na einai analoga me ta tasks apo to database
                  ChartData('Social', sums[1]),
                  ChartData('Study', sums[2]),
                ],
              )
            ];
            if (sums[0] + sums[1] + sums[2] == 0) {
              return Text("you have not completed any tasks yet");
            } else {
              var chart = charts.PieChart(
                seriesList,
                animate: true,
              );
              return Stack(
                children: [
                  SizedBox(
                    height: 300,
                    width: 300,
                    child: chart,
                  ),
                  Positioned(
                    top: 0,
                    left: 0,
                    child: Image.asset(
                      'assets/images/chart_ring.png',
                      height: 300,
                      width: 300,
                    ),
                  ),
                ],
              );
            }
          }
        });
  }

  Color _getColorForCategory(String category) {
    if (category == 'Fitness') {
      return const Color(0xFFFFC7C2);
    } else if (category == 'Social') {
      return const Color(0xFFAFF4C6);
    } else if (category == 'Study') {
      return const Color(0xFFFFFCBD);
    } else {
      return Colors.grey;
    }
  }
}

class ChartData {
  final String category;
  final int value;

  ChartData(this.category, this.value);
}

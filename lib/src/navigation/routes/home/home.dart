import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
            child: PieChartWidget(),
         
      ),
    );
  }
}



class PieChartWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
   
    
    List<charts.Series<ChartData, String>> seriesList = [
      charts.Series<ChartData, String>(
        id: 'Categories',
        domainFn: (ChartData data, _) => data.category,
        measureFn: (ChartData data, _) => data.value,
        colorFn: (ChartData data, _) => charts.ColorUtil.fromDartColor(
            _getColorForCategory(data.category)), 
        data: [
          ChartData('Fitness', 30),  /// ayta edo na einai analoga me ta tasks apo to database
          ChartData('Social', 40),
          ChartData('Study', 30),
        ],
      )
    ];

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

  Color _getColorForCategory(String category) {
    if (category == 'Fitness') {
      return Color(0xFFFFC7C2);
    } else if (category == 'Social') {
      return Color(0xFFAFF4C6);
    } else if (category == 'Study') {
      return Color(0xFFFFFCBD);
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
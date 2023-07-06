import 'package:agri_fit/Utilities/graph/steps_data.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class StepsGraph extends StatelessWidget {
  final List monthlySteps;

  const StepsGraph({
    super.key,
    required this.monthlySteps,
  });

  @override
  Widget build(BuildContext context) {
    // initialize bar data
    BarData myBarData = BarData(
      janMean: monthlySteps[0], 
      febMean: monthlySteps[1], 
      marMean: monthlySteps[2], 
      aprMean: monthlySteps[3], 
      mayMean: monthlySteps[4], 
      junMean: monthlySteps[5], 
      julMean: monthlySteps[6], 
      augMean: monthlySteps[7], 
      sepMean: monthlySteps[8], 
      octMean: monthlySteps[9], 
      novMean: monthlySteps[10], 
      desMean: monthlySteps[11],
      );
      myBarData.initializeBarData(); 
    
    return BarChart(
      BarChartData(
        minY: 0,
        gridData: const FlGridData(show: false),
        borderData: FlBorderData(show: false),
        titlesData: const FlTitlesData(
          show: true,
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: true, getTitlesWidget: bottomTitles))
        ),
        barGroups: myBarData.barData.map(
          (data) => BarChartGroupData(
            x: data.x,
            barRods: [BarChartRodData(
              toY: data.y,
              color: Color.fromARGB(255, 8, 131, 100),
              width: 20,
              borderRadius: BorderRadius.circular(3),
              )
              ],
            
            ),
            ).toList(),
        ),
    );
  }
}

Widget bottomTitles(double value, TitleMeta meta){
  const style = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 12
  );

  Widget text;
  switch (value.toInt()) {
    case 1:
      text = const Text('Jan', style: style);
      break;
    case 2:
      text = const Text('Feb', style: style);
      break;
    case 3:
      text = const Text('Mar', style: style);
      break;
    case 4:
      text = const Text('Apr', style: style);
      break;
    case 5:
      text = const Text('May', style: style);
      break;
    case 6:
      text = const Text('Jun', style: style);
      break;
    case 7:
      text = const Text('Jul', style: style);
      break;
    case 8:
      text = const Text('Aug', style: style);
      break;
    case 9:
      text = const Text('Sep', style: style);
      break;
    case 10:
      text = const Text('Oct', style: style);
      break;
    case 11:
      text = const Text('Nov', style: style);
      break;
    case 12:
      text = const Text('Dec', style: style);
      break;
    default:
      text = const Text('', style: style);
    break;
  }
  return SideTitleWidget(child: text, axisSide: meta.axisSide);
}
import 'package:agri_fit/Utilities/graph/steps_data.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class StepsGraph extends StatelessWidget {
  final List<int> weeklySteps;

  const StepsGraph({
    super.key,
    required this.weeklySteps,
  });

  @override
  Widget build(BuildContext context) {
    // initialize bar data
    BarData myBarData = BarData(
      minusThreeWeeks: weeklySteps[0].toDouble(), 
      minusTwoWeeks: weeklySteps[1].toDouble(), 
      lastWeek: weeklySteps[2].toDouble(), 
      thisWeek: weeklySteps[3].toDouble(), 
      );
      myBarData.initializeBarData(); 
    
    return BarChart(
      // layout changes to BarChart
      BarChartData(
        minY: 0,
        gridData: const FlGridData(show: false),
        borderData: FlBorderData(show: false),

        barTouchData: BarTouchData(
          enabled: true,
          touchTooltipData: BarTouchTooltipData(
            tooltipRoundedRadius: 40,
            tooltipBgColor:const Color.fromARGB(255, 237, 237, 237),) 
        ),

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
              color: const Color.fromARGB(255, 8, 131, 100),
              width: 25,
              borderRadius: const BorderRadius.only(topLeft: Radius.circular(5), topRight: Radius.circular(5))
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
      text = const Text('-3 weeks', style: style);
      break;
    case 2:
      text = const Text('-2 weeks', style: style);
      break;
    case 3:
      text = const Text('Last week', style: style);
      break;
    case 4:
      text = const Text('This week', style: style);
      break;
    default:
      text = const Text('', style: style);
    break;
  }
  return SideTitleWidget(axisSide: meta.axisSide, child: text);
}
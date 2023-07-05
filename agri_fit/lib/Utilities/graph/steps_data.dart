/*List<double> monthlySteps = [
  6000.0,
  8000.0,
  15000.0,
  16000.0,
  17000.0,
  15000.0,
  18000.0,
  14000.0,
  14000.0,
  15000.0,
  10000.0,
  8000.0
];
*/
// Funker ikke når listen er her...

class IndividualBar {
  final int x;
  final double y;

  IndividualBar({
    required this.x,
    required this.y,
    });
}


class BarData {
  final double janMean;
  final double febMean;
  final double marMean;
  final double aprMean;
  final double mayMean;
  final double junMean;
  final double julMean;
  final double augMean;
  final double sepMean;
  final double octMean;
  final double novMean;
  final double desMean;

  BarData({
    required this.janMean,
    required this.febMean,
    required this.marMean,
    required this.aprMean,
    required this.mayMean,
    required this.junMean,
    required this.julMean,
    required this.augMean,
    required this.sepMean,
    required this.octMean,
    required this.novMean,
    required this.desMean,
  });

  List<IndividualBar> barData = [];

  // initialize bar data
  void initializeBarData() {
    barData = [
      IndividualBar(x: 1, y: janMean),
      IndividualBar(x: 2, y: febMean),
      IndividualBar(x: 3, y: marMean),
      IndividualBar(x: 4, y: aprMean),
      IndividualBar(x: 5, y: mayMean),
      IndividualBar(x: 6, y: junMean),
      IndividualBar(x: 7, y: julMean),
      IndividualBar(x: 8, y: augMean),
      IndividualBar(x: 9, y: sepMean),
      IndividualBar(x: 10, y: octMean),
      IndividualBar(x: 11, y: novMean),
      IndividualBar(x: 12, y: desMean),
    ];
  }
}

class IndividualBar {
  final int x;
  final double y;

  IndividualBar({
    required this.x,
    required this.y,
    });
}

class BarData {
  final double minusThreeWeeks;
  final double minusTwoWeeks;
  final double lastWeek;
  final double thisWeek;

  BarData({
    required this.minusThreeWeeks,
    required this.minusTwoWeeks,
    required this.lastWeek,
    required this.thisWeek,
  });

  List<IndividualBar> barData = [];

  // initialize bar data
  void initializeBarData() {
    barData = [
      IndividualBar(x: 1, y: minusThreeWeeks),
      IndividualBar(x: 2, y: minusTwoWeeks),
      IndividualBar(x: 3, y: lastWeek),
      IndividualBar(x: 4, y: thisWeek),
    ];
  }
}

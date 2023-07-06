import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:agri_fit/Database/Steps.dart';

//This is the change notifier. It will manage all the logic of the home page: fetching data from the db
//and on startup fetching the data from the online services
class Provider extends ChangeNotifier {

  late List<Steps> provideSteps;
  late List<Callories> provideCals;

  late List<Steps> _stepsDB;
  late List<Callories> _calsDB;

  //select day of data to be shown
  DateTime showDate = DateTime.now().subtract(const Duration(days:1));
}

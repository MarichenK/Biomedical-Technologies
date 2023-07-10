//import 'dart:ffi';

import 'package:floor/floor.dart';
import 'package:intl/intl.dart';

@entity
class Steps {
  //@PrimaryKey(autoGenerate: true)
  //final int? id;

  final int step;
  final DateTime dateTime;

  Steps({required this.dateTime, required this.step});

  Steps.fromJson(String date, Map<String, dynamic> json) :
    dateTime = DateFormat('yyyy-MM-dd HH:mm:ss').parse('$date ${json["time"]}'),
    step = int.parse(json["value"]) {
      print(date);
    }

  @override
  String toString() {
    return 'Steps(time: $dateTime, value: $step)';
  }
}

@entity 
class Callories {

  final double cals;
  final DateTime dateTime;

  Callories({required this.dateTime, required this.cals});

  Callories.fromJson(String date, Map<String, dynamic> json) :
    dateTime = DateFormat('yyyy-MM-dd HH:mm:ss').parse('$date ${json["time"]}'),
    cals = double.parse(json["value"]){
      print(date);
    } 

  @override
  String toString() {
    return 'Callories(time: $dateTime, value: $cals)';
  }
}

@entity
class StepsWeek {
  final int step;
  final DateTime startTime;
  final DateTime endTime;

  StepsWeek({required this.startTime, required this.endTime, required this.step});

  StepsWeek.fromJson(String date1, String date2, Map<String, dynamic> json) :
    startTime = DateFormat('yyyy-MM-dd HH:mm:ss').parse('$date1 ${json["time"]}'),
    endTime = DateFormat('yyyy-MM-dd HH:mm:ss').parse('$date2 ${json["time"]}'),
    step = int.parse(json["value"]);
  
  @override
  String toString() {
    return 'Steps per week(start_date: $startTime, endDate: $endTime, value: $step)';
  }
}
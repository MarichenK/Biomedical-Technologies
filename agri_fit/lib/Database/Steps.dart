//import 'dart:ffi';

import 'package:agri_fit/Database/Todo.dart';
import 'package:floor/floor.dart';
import 'package:intl/intl.dart';

/*@Entity(
  foreignKeys:[ForeignKey(
    childColumns: ['name'], 
    parentColumns: ['id'], 
    entity: Todo)]
)*/
@entity
class Steps {
  //@PrimaryKey(autoGenerate: true)
  //final int? id;

  final int step;
  final DateTime dateTime;

  Steps({required this.step, required this.dateTime});

  Steps.fromJson(String date, Map<String, dynamic> json) :
    dateTime = DateFormat('yyyy-MM-dd HH:mm:ss').parse('$date ${json["time"]}'),
    step = int.parse(json["step"]);

  @override
  String toString() {
    return 'Steps(time: $dateTime, value: $step)';
  }
}

@entity 
class Callories {

  final int cals;
  final DateTime dateTime;

  Callories({required this.cals, required this.dateTime});

  Callories.fromJson(String date, Map<String, dynamic> json) :
    dateTime = DateFormat('yyyy-MM-dd HH:mm:ss').parse('$date ${json["time"]}'),
    cals = int.parse(json["cals"]);

  @override
  String toString() {
    return 'Callories(time: $dateTime, value: $cals)';
  }
}
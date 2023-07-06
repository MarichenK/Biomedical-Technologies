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

  final int cals;
  final DateTime dateTime;

  Callories({required this.dateTime, required this.cals});

  Callories.fromJson(String date, Map<String, dynamic> json) :
    dateTime = DateFormat('yyyy-MM-dd HH:mm:ss').parse('$date ${json["time"]}'),
    cals = int.parse(json["value"]);

  @override
  String toString() {
    return 'Callories(time: $dateTime, value: $cals)';
  }
}
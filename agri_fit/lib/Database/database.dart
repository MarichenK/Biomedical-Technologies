import 'dart:async';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:agri_fit/Utilities/dateTimeConverter.dart';

import 'package:agri_fit/Database/Daos/TodoDao.dart';
import 'package:agri_fit/Database/Daos/CaloriesDao.dart';
import 'package:agri_fit/Database/Daos/StepsDao.dart';
import 'package:agri_fit/Database/Todo.dart';
import 'package:agri_fit/Database/Steps.dart';
import 'package:agri_fit/Database/Calories.dart';

part 'database.g.dart';

@TypeConverters([DateTimeConverter])
@Database(version: 1, entities: [Todo, Calories, Steps])
abstract class AppDatabase extends FloorDatabase {
  //Add all the daos as getters here
  TodoDao get todoDao;
  CaloriesDao get caloriesDao;
  //StepsDao get stepsDao;
}//AppDatabase 
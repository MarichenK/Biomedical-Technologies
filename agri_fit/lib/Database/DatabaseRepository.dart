import 'package:agri_fit/Database/database.dart';
import 'package:agri_fit/Database/Todo.dart';
import 'package:flutter/material.dart';
import 'package:agri_fit/Database/Calories.dart';
import 'package:agri_fit/Database/Steps.dart';

class DatabaseRepository extends ChangeNotifier{

  //The state of the database is just the AppDatabase
  final AppDatabase database;

  //Default constructor
  DatabaseRepository({required this.database});

  //This method wraps the findAllTodos() method of the DAO
  //Future<List<Todo>> findAllTodos() async{
    //final results = await database.todoDao.findAllTodos();
    //return results;
  //}//findAllTodos

  Future<Todo?> findTodoById(int id) async{
    final result = await database.todoDao.findTodoById(id);
    return result;
  }//find specific dao

  Future<List<Calories>> findCaloriesByDate(int id, DateTime startTime, DateTime endTime) async {
    final result = await database.caloriesDao.findCaloriesbyDate(id, startTime, endTime);
    return result;
  }

  Future<List<Steps>> findStepsByDate(int id, DateTime startTime, DateTime endTime) async {
    final result = await database.stepsDao.findStepsbyDate(id, startTime, endTime);
    return result;
  }

  Future<List<Calories>> findLastWeekCalories(int id, DateTime time) async{
    final result = await database.caloriesDao.findLastWeekCalories(id);
    return result;
  }

  Future<List<Steps>> findLastWeekSteps(int id, DateTime time) async{
    final result = await database.stepsDao.findLastWeekSteps(id);
    return result;
  }

  Future<List<Calories>> findAllCalories(int id) async{
    final result = database.caloriesDao.findAllCalories(id);
    return result;
  }

  Future<List<Steps>> findAllSteps(int id) async{
    final result = database.stepsDao.findAllSteps(id);
    return result;
  }



  //This method wraps the insertTodo() method of the DAO. 
  //Then, it notifies the listeners that something changed.
  Future<void> insertTodo(Todo todo)async {
    await database.todoDao.insertTodo(todo);
    notifyListeners();
  }//insertTodo

  Future<void> insertCalories(Calories calories) async{
    await database.caloriesDao.insertCalories(calories);
    notifyListeners();
  }

  Future<void> insertSteps(Steps steps) async{
    await database.stepsDao.insertSteps(steps);
    notifyListeners();
  }


  //This method wraps the deleteTodo() method of the DAO. 
  //Then, it notifies the listeners that something changed.
  Future<void> removeTodo(Todo todo) async{
    await database.todoDao.deleteTodo(todo);
    notifyListeners();
  }//removeTodo

  Future<void> deleteCalories(Calories calories) async{
    await database.caloriesDao.deleteCalories(calories);
    notifyListeners();
  }

  Future<void> deleteSteps(Steps steps) async{
    await database.stepsDao.deleteSteps(steps);
    notifyListeners();
  }

  Future<void> updateTodo(Todo todo) async{
    await database.todoDao.updateTodo(todo);
    notifyListeners();
  } //update todo 

  Future<void> updateCalories(Calories calories) async{
    await database.caloriesDao.updateCalories(calories);
    notifyListeners();
  }

  Future<void> updateSteps(Steps steps) async{
    await database.stepsDao.updateSteps(steps);
    notifyListeners();
  }
  
}//DatabaseRepository 
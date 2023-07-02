import 'package:agri_fit/Database/database.dart';
import 'package:agri_fit/Database/Todo.dart';
import 'package:flutter/material.dart';

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

  //This method wraps the insertTodo() method of the DAO. 
  //Then, it notifies the listeners that something changed.
  Future<void> insertTodo(Todo todo)async {
    await database.todoDao.insertTodo(todo);
    notifyListeners();
  }//insertTodo

  //This method wraps the deleteTodo() method of the DAO. 
  //Then, it notifies the listeners that something changed.
  Future<void> removeTodo(Todo todo) async{
    await database.todoDao.deleteTodo(todo);
    notifyListeners();
  }//removeTodo

  Future<void> updateTodo(Todo todo) async{
    await database.todoDao.updateTodo(todo);
    notifyListeners();
  } //update todo 
  
}//DatabaseRepository 
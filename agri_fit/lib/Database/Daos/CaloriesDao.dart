import 'package:floor/floor.dart';
import 'package:agri_fit/Database/Calories.dart';

//Here, we are saying that the following class defines a dao.

@dao
abstract class CaloriesDao {
  //Query #0: SELECT -> this allows to obtain all the entries of the HeartRate table of a certain date belonging to a patient
  @Query(
      'SELECT * FROM Calories WHERE dateTime between :startTime and :endTime and id == :id ORDER BY dateTime ASC')
  Future<List<Calories>> findCaloriesbyDate(
      int id, DateTime startTime, DateTime endTime);

  //Query #1: SELECT -> this allows to obtain all the entries of the Calorie table
  @Query('SELECT * FROM Calories WHERE id == :id')
  Future<List<Calories>> findAllCalories(int id);

  //Query #2: INSERT -> this allows to add a Calorie in the table
  @insert
  Future<void> insertCalories(Calories calories);

  //Query #3: DELETE -> this allows to delete a Calorie from the table
  @delete
  Future<void> deleteCalories(Calories calories);

  //Query #4: UPDATE -> this allows to update a Calorie entry
  @Update(onConflict: OnConflictStrategy.replace)
  Future<void> updateCalories(Calories calories);

  //Query #4: SELECT
  @Query(
      'SELECT * FROM Calories WHERE id=:id and dateTime >= :time ORDER BY dateTime ASC')
  Future<List<Calories>> _findLastWeekCalories(int id, DateTime time);
  
  Future<List<Calories>> findLastWeekCalories(int id) {
    return _findLastWeekCalories(
        id, DateTime.now().subtract(const Duration(hours: 168)));
  }
}//CaloriesDao
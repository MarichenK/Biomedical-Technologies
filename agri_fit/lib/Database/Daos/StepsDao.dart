import 'package:floor/floor.dart';
import 'package:agri_fit/Database/Steps.dart';

//Here, we are saying that the following class defines a dao.

@dao
abstract class StepsDao {
  //Query #0: SELECT -> this allows to obtain all the entries of the Steps table of a certain date belonging to a patient
  @Query(
      'SELECT * FROM Steps WHERE dateTime between :startTime and :endTime and id == :id ORDER BY dateTime ASC')
  Future<List<Steps>> findStepsbyDate(
      int id, DateTime startTime, DateTime endTime);

  //Query #1: SELECT -> this allows to obtain all the entries of the Steps table
  @Query('SELECT * FROM Steps WHERE id == :id')
  Future<List<Steps>> findAllSteps(int id);

  //Query #2: INSERT -> this allows to add a Steps in the table
  @insert
  Future<void> insertSteps(Steps steps);

  //Query #3: DELETE -> this allows to delete a step from the table
  @delete
  Future<void> deleteSteps(Steps steps);

  //Query #4: UPDATE -> this allows to update a step entry
  @Update(onConflict: OnConflictStrategy.replace)
  Future<void> updateSteps(Steps steps);

  //Query #4: SELECT
  @Query(
      'SELECT * FROM Steps WHERE id=:id and dateTime >= :time ORDER BY dateTime ASC')
  Future<List<Steps>> _findLastWeekSteps(int id, DateTime time);

  Future<List<Steps>> findLastWeekSteps(int id) {
    return _findLastWeekSteps(
        id, DateTime.now().subtract(const Duration(hours: 168)));
  }
}//StepsDao
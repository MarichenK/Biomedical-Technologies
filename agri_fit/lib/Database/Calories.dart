import 'package:agri_fit/Database/Todo.dart';
import 'package:floor/floor.dart';

@Entity(
  foreignKeys:[ForeignKey(
    childColumns: ['name'], 
    parentColumns: ['id'], 
    entity: Todo)]
)

class Calories {
  @PrimaryKey(autoGenerate: true)
  final int? id;

  final int cal;
  final DateTime dateTime;
  
  Calories({this.id, required this.cal, required this.dateTime});
}
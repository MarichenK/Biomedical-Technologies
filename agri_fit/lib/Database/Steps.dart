import 'package:agri_fit/Database/Todo.dart';
import 'package:floor/floor.dart';

@Entity(
  foreignKeys:[ForeignKey(
    childColumns: ['name'], 
    parentColumns: ['id'], 
    entity: Todo)]
)
class Steps {
  @PrimaryKey(autoGenerate: true)
  final int? id;

  final int step;
  final DateTime dateTime;

  Steps({this.id, required this.step, required this.dateTime});
}
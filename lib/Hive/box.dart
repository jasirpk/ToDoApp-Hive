import 'package:hive/hive.dart';
import 'package:todo_app/Hive/model.dart';

class Boxes {
  static Box<Notes> getData() => Hive.box<Notes>('notes');
}

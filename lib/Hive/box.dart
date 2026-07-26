
import 'package:hive/hive.dart';
import 'package:todo_app/Hive/user_model.dart';

class Boxes {
  static Box <UserModel> getData()=>Hive.box('users');
}
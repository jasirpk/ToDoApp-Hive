import 'package:hive/hive.dart';
part 'model.g.dart';

@HiveType(typeId: 0)
class Notes extends HiveObject {
  @HiveField(0)
  String title;

  @HiveField(1)
  String descritption;

  Notes({
    required this.title,
    required this.descritption,
  });
}

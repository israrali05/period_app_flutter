import 'package:hive/hive.dart';

part 'user_model.g.dart'; // Generated part file for Hive

@HiveType(typeId: 0)
class UserModel extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  DateTime nextPeriodStartDate;

  @HiveField(2)
  DateTime ovulationDay;

  @HiveField(3)
  int nextCycleDuration;

  UserModel({
    required this.name,
    required this.nextPeriodStartDate,
    required this.ovulationDay,
    required this.nextCycleDuration,
  });
}

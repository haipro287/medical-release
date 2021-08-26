import 'package:hive/hive.dart';

// part 'service.g.dart';

@HiveType(typeId: 4)
class Record {
  @HiveField(0)
  String? id;
  @HiveField(1)
  String? name;
  @HiveField(2)
  String? url;
  @HiveField(3)
  String? username;
  @HiveField(4)
  String? phone;
  @HiveField(5)
  String? secondaryId;
  @HiveField(6)
  String? romanji;
  @HiveField(7)
  String? kanji;
  @HiveField(8)
  String? primaryId;
  @HiveField(9)
  String? fromTime;
  @HiveField(10)
  String? endTime;
  @HiveField(11)
  String? status;
  @HiveField(12)
  String? service;
}

import 'package:hive/hive.dart';

// part 'service.g.dart';

@HiveType(typeId: 3)
class Friend {
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
  String? secondaryName;
  @HiveField(7)
  String? secondaryUsername;
  @HiveField(8)
  String? primaryId;
  
}

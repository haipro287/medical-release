import 'package:hive/hive.dart';

// part 'service.g.dart';

@HiveType(typeId: 2)
class Service {
  @HiveField(0)
  String? id;
  @HiveField(1)
  String? name;
  @HiveField(2)
  String? url;
  @HiveField(3)
  String? username;
  @HiveField(4)
  bool? isConnected;
  @HiveField(5)
  String? icon;
  @HiveField(6)
  String? description;
  @HiveField(7)
  String? redirectURL;

  Service(
      {this.id,
      this.name,
      this.url,
      this.username,
      this.isConnected,
      this.icon,
      this.description,
      this.redirectURL});
}

import 'package:hive/hive.dart';

part 'User.g.dart';

@HiveType(typeId: 1)
class User {
  @HiveField(0)
  String? id;
  @HiveField(1)
  String? name;
  @HiveField(2)
  String? phone;
  @HiveField(3)
  String? mail;
  @HiveField(4)
  String? publicKey;
  @HiveField(5)
  String? privateKey;
  @HiveField(6)
  String? encryptedPrivateKey;
  @HiveField(7)
  String? username;
  @HiveField(8)
  String? password;
}

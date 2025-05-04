import 'package:hive/hive.dart';

part 'users_model_hive.g.dart';

@HiveType(typeId: 1)
class UserModelHive extends HiveObject {
  @HiveField(0)
  final String userId;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String image;

  UserModelHive({
    required this.userId,
    required this.name,
    required this.image,
  });
}

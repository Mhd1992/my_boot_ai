import 'package:hive/hive.dart';

part 'setting_hive.g.dart';

@HiveType(typeId: 2)
class SettingsHive extends HiveObject {
  @HiveField(0)
  final bool isDarkTheme;
  @HiveField(1)
  final String shouldSpeak;

  SettingsHive({
    required this.isDarkTheme,
    required this.shouldSpeak,
  });
}

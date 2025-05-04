import 'package:hive/hive.dart';
import 'package:my_boot_ai/constants/constants.dart';
import 'package:my_boot_ai/hive/chat_history_hive.dart';
import 'package:my_boot_ai/hive/setting_hive.dart';
import 'package:my_boot_ai/hive/users_model_hive.dart';

class Boxes {
  static Box<ChatHistoryHive> getChatHistory() =>
      Hive.box<ChatHistoryHive>(Constants.chatHistoryBox);

  static Box<UserModelHive> getUsers() =>
      Hive.box<UserModelHive>(Constants.usersBox);

  static Box<SettingsHive> getSettings() =>
      Hive.box<SettingsHive>(Constants.settingsBox);
}

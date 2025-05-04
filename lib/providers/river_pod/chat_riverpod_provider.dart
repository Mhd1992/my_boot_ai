import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:my_boot_ai/constants/constants.dart';
import 'package:my_boot_ai/hive/chat_history_hive.dart';
import 'package:my_boot_ai/hive/setting_hive.dart';
import 'package:my_boot_ai/hive/users_model_hive.dart';
import 'package:my_boot_ai/models/message_model.dart';
import 'package:path_provider/path_provider.dart' as path;
import 'package:image_picker/image_picker.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

// Define a ChangeNotifierProvider
final chatProvider = ChangeNotifierProvider<ChatNotifier>((ref) {
  return ChatNotifier();
});

class ChatNotifier extends ChangeNotifier {
  List<MessageModel> _inMessageChat = [];
  PageController _pageController = PageController();
  List<XFile> _imageFileList = [];
  int _currentIndex = 0;
  String _chatId = '';
  GenerativeModel? _generativeModel;
  GenerativeModel? _generativeTextModel;
  GenerativeModel? _generativeVisionModel;
  String _modeType = 'gemini-pro';
  bool isLoading = false;

  List<MessageModel> get inMessageChat => _inMessageChat;
  List<XFile> get imageFileList => _imageFileList;
  PageController get pageController => _pageController;
  GenerativeModel? get generativeModel => _generativeModel;
  GenerativeModel? get generativeTextModel => _generativeTextModel;
  GenerativeModel? get generativeVisionModel => _generativeVisionModel;
  int get currentIndex => _currentIndex;
  String get chatId => _chatId;
  String get modeType => _modeType;

  static Future<void> initHive() async {
    final dir = await path.getApplicationCacheDirectory();
    Hive.init(dir.path);
    await Hive.initFlutter(Constants.geminiDb);

    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(ChatHistoryHiveAdapter());
      await Hive.openBox<ChatHistoryHive>(Constants.chatHistoryBox);
    }

    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(UserModelHiveAdapter());
      await Hive.openBox<UserModelHive>(Constants.usersBox);
    }

    if (!Hive.isAdapterRegistered(2)) {
      Hive.registerAdapter(SettingsHiveAdapter());
      await Hive.openBox<SettingsHive>(Constants.settingsBox);
    }
  }
}

/*
* Consumer(
  builder: (context, watch, child) {
    final chatNotifier = watch(chatProvider);
    // Use chatNotifier as needed
    return Container(); // Your widget here
  },
);
*
* */

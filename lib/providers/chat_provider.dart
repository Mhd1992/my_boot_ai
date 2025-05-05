import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:my_boot_ai/constants/constants.dart';
import 'package:my_boot_ai/hive/chat_history_hive.dart';
import 'package:my_boot_ai/hive/setting_hive.dart';
import 'package:my_boot_ai/hive/users_model_hive.dart';
import 'package:my_boot_ai/models/message_model.dart';
import 'package:my_boot_ai/service/api_service.dart';
import 'package:path_provider/path_provider.dart' as path;
import 'package:image_picker/image_picker.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class ChatProvider extends ChangeNotifier {
  List<MessageModel> _inMessageChat = [];

  PageController _pageController = PageController();

  List<XFile> _imageFileList = [];

  int _currentIndex = 0;

  String _chatId = '';

  GenerativeModel? _generativeModel;
  GenerativeModel? _generativeTextModel;
  GenerativeModel? _generativeVisionModel;

  String _modeType = 'gemini-pro';

  bool _isLoading = false;

  List<MessageModel> get inMessageChat => _inMessageChat; //getters

  List<XFile> get imageFileList => _imageFileList;

  PageController get pageController => _pageController;

  GenerativeModel? get generativeModel => _generativeModel;

  GenerativeModel? get generativeTextModel => _generativeTextModel;

  GenerativeModel? get generativeVisionModel => _generativeVisionModel;

  int get currentIndex => _currentIndex;

  String get chatId => _chatId;

  String get modeType => _modeType;

  bool get isLoading => _isLoading;

  static initHive() async {
    //
    final dir = await path.getApplicationCacheDirectory();
    Hive.init(dir.path);
    await Hive.initFlutter(Constants.geminiDb);

    //register adaptor
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

  Future<void> setInChatMessage({required String chatId}) async {
    final messageData = await loadMessageDB(chatId: chatId);
    /*   messageData.forEach((e) {
      if (_inMessageChat.contains(e)) {
        log('this message already existed');

      }else{
        _inMessageChat.add(e);

      }
    });*/

    for (var message in messageData) {
      if (_inMessageChat.contains(message)) {
        log('this message already existed');
        continue;
      }
      _inMessageChat.add(message);
    }

    notifyListeners();
  }

  void setImagesFileList({required List<XFile> valueFileList}) {
    _imageFileList = valueFileList;
    notifyListeners();
  }

  String setCurrentModel({required String newModel}) {
    _modeType = newModel;
    notifyListeners();
    return _modeType;
  }

  //set if text or vision
  Future<void> setModel({required bool isTextOnly}) async {
    if (isTextOnly) {
      _generativeModel = _generativeTextModel ??
          GenerativeModel(
              model: setCurrentModel(newModel: 'gemini-pro'),
              apiKey: ApiService().apiKey);
    } else {
      _generativeModel = _generativeVisionModel ??
          GenerativeModel(
              model: setCurrentModel(newModel: 'gemini-pro-vision'),
              apiKey: ApiService().apiKey);
    }
    notifyListeners();
  }

  void setCurrentIndex({required int index}) {
    _currentIndex = index;
    notifyListeners();
  }

  void setCurrentChatId({required String chatId}) {
    _chatId = chatId;
    notifyListeners();
  }

  void setLoading({required bool value}) {
    _isLoading = value;
    notifyListeners();
  }

  Future<List<MessageModel>> loadMessageDB({required String chatId}) async {
    //  await Hive.openBox(Constants.chatMessageBox + chatId);
    await Hive.openBox("${Constants.chatMessageBox}$chatId");

    final messageBox = await Hive.box("${Constants.chatMessageBox}$chatId");
    final newData = messageBox.keys.map((e) {
      final message = messageBox.get(e);
      final messageData =
          MessageModel.fromMap(Map<String, dynamic>.from(message));
      return messageData;
    }).toList();
    notifyListeners();
    return newData;
  }
}

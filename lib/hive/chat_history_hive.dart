import 'package:hive/hive.dart';

part 'chat_history_hive.g.dart';

@HiveType(typeId: 0)
class ChatHistoryHive extends HiveObject {
  @HiveField(0)
  final String chatId;
  @HiveField(1)
  final String promptId;
  @HiveField(2)
  final String response;
  @HiveField(3)
  final List<String> imagesUrls;
  @HiveField(4)
  final DateTime timeStamp;

  ChatHistoryHive(
      {required this.chatId,
      required this.promptId,
      required this.response,
      required this.imagesUrls,
      required this.timeStamp});
}

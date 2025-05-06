class MessageModel {
  String messageId;
  String chatId;
  Role role;
  StringBuffer message;
  DateTime timeSent;
  List<String> imagesUrl;

  MessageModel(
      {required this.messageId,
      required this.chatId,
      required this.role,
      required this.message,
      required this.timeSent,
      required this.imagesUrl});

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      messageId: map['messageId'],
      chatId: map['chatId'],
      role: map['role'],
      message: map['message'],
      timeSent: map['timeSent'],
      imagesUrl: map['imagesUrl'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'messageId': messageId,
      'chatId': chatId,
      'role': role.index,
      'message': message.toString(),
      'timeSent': timeSent.toIso8601String(),
      'imagesUrl': imagesUrl,
    };
  }

  MessageModel copyWith({String? messageId, String? chatId, Role? role,
  StringBuffer? message, DateTime? timeSent, List<String>? imagesUrl}) {
    return MessageModel(
        messageId: messageId ?? this.messageId,
        chatId: chatId ?? this.chatId,
        role: role ?? this.role,
        message: message ?? this.message,
        timeSent: timeSent ?? this.timeSent,
        imagesUrl: imagesUrl ?? this.imagesUrl);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is MessageModel && other.messageId == messageId;
  }

  @override
  int get hashCode => messageId.hashCode;
}

enum Role { user, assistant }

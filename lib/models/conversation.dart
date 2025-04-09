import 'package:mixlify/models/message.dart';

class Conversation {
  final String id;
  final String displayName;
  final String? avatarUrl;
  final String lastMessage;
  final DateTime lastMessageTime;
  final List<String> platforms;
  final int unreadCount;
  final bool isOnline;
  final List<Message> messages;

  Conversation({
    required this.id,
    required this.displayName,
    this.avatarUrl,
    required this.lastMessage,
    required this.lastMessageTime,
    required this.platforms,
    this.unreadCount = 0,
    this.isOnline = false,
    this.messages = const [],
  });

  Conversation copyWith({
    String? id,
    String? displayName,
    String? avatarUrl,
    String? lastMessage,
    DateTime? lastMessageTime,
    List<String>? platforms,
    int? unreadCount,
    bool? isOnline,
    List<Message>? messages,
  }) {
    return Conversation(
      id: id ?? this.id,
      displayName: displayName ?? this.displayName,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      lastMessage: lastMessage ?? this.lastMessage,
      lastMessageTime: lastMessageTime ?? this.lastMessageTime,
      platforms: platforms ?? this.platforms,
      unreadCount: unreadCount ?? this.unreadCount,
      isOnline: isOnline ?? this.isOnline,
      messages: messages ?? this.messages,
    );
  }
}

enum MessageStatus {
  sent,
  delivered,
  read,
  failed
}

class Message {
  final String id;
  final String conversationId;
  final String senderId;
  final String senderName;
  final String? senderAvatar;
  final String content;
  final DateTime timestamp;
  final MessageStatus status;
  final String platform;
  final Map<String, dynamic>? metadata;

  Message({
    required this.id,
    required this.conversationId,
    required this.senderId,
    required this.senderName,
    this.senderAvatar,
    required this.content,
    required this.timestamp,
    required this.platform,
    this.status = MessageStatus.sent,
    this.metadata,
  });

  Message copyWith({
    String? id,
    String? conversationId,
    String? senderId,
    String? senderName,
    String? senderAvatar,
    String? content,
    DateTime? timestamp,
    String? platform,
    MessageStatus? status,
    Map<String, dynamic>? metadata,
  }) {
    return Message(
      id: id ?? this.id,
      conversationId: conversationId ?? this.conversationId,
      senderId: senderId ?? this.senderId,
      senderName: senderName ?? this.senderName,
      senderAvatar: senderAvatar ?? this.senderAvatar,
      content: content ?? this.content,
      timestamp: timestamp ?? this.timestamp,
      platform: platform ?? this.platform,
      status: status ?? this.status,
      metadata: metadata ?? this.metadata,
    );
  }

  bool get isOutgoing => senderId == 'current_user'; // TODO: Replace with actual user ID
}

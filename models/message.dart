enum MessageStatus {
  sent,
  delivered,
  read,
  failed
}

class Message {
  final String id;
  final String content;
  final DateTime timestamp;
  final String senderId;
  final String platform;
  final MessageStatus status;
  final bool isOutgoing;

  Message({
    required this.id,
    required this.content,
    required this.timestamp,
    required this.senderId,
    required this.platform,
    this.status = MessageStatus.sent,
    this.isOutgoing = false,
  });

  Message copyWith({
    String? id,
    String? content,
    DateTime? timestamp,
    String? senderId,
    String? platform,
    MessageStatus? status,
    bool? isOutgoing,
  }) {
    return Message(
      id: id ?? this.id,
      content: content ?? this.content,
      timestamp: timestamp ?? this.timestamp,
      senderId: senderId ?? this.senderId,
      platform: platform ?? this.platform,
      status: status ?? this.status,
      isOutgoing: isOutgoing ?? this.isOutgoing,
    );
  }
}

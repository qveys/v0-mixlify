import 'package:flutter/material.dart';
import 'package:mixlify/models/message.dart';
import 'package:mixlify/utils/time_formatter.dart';
import 'package:mixlify/widgets/platform_indicator.dart';

class MessageBubble extends StatelessWidget {
  final Message message;
  final bool showAvatar;

  const MessageBubble({
    super.key,
    required this.message,
    this.showAvatar = true,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: message.isOutgoing ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (!message.isOutgoing && showAvatar)
            CircleAvatar(
              radius: 16,
              backgroundImage: message.senderAvatar != null
                  ? NetworkImage(message.senderAvatar!)
                  : null,
              child: message.senderAvatar == null
                  ? Text(
                      message.senderName.substring(0, 1).toUpperCase(),
                      style: const TextStyle(fontSize: 12),
                    )
                  : null,
            )
          else if (!message.isOutgoing && !showAvatar)
            const SizedBox(width: 32),
            
          const SizedBox(width: 8),
          
          Flexible(
            child: Column(
              crossAxisAlignment: message.isOutgoing ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                if (!message.isOutgoing && showAvatar)
                  Padding(
                    padding: const EdgeInsets.only(left: 4, bottom: 4),
                    child: Text(
                      message.senderName,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                      ),
                    ),
                  ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  decoration: BoxDecoration(
                    color: message.isOutgoing
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        message.content,
                        style: TextStyle(
                          color: message.isOutgoing
                              ? Theme.of(context).colorScheme.onPrimary
                              : Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            TimeFormatter.formatMessageTime(message.timestamp),
                            style: TextStyle(
                              fontSize: 10,
                              color: message.isOutgoing
                                  ? Theme.of(context).colorScheme.onPrimary.withOpacity(0.7)
                                  : Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
                            ),
                          ),
                          const SizedBox(width: 4),
                          if (message.isOutgoing)
                            Icon(
                              message.status == MessageStatus.sent
                                  ? Icons.check
                                  : message.status == MessageStatus.delivered
                                      ? Icons.done_all
                                      : Icons.done_all,
                              size: 12,
                              color: message.status == MessageStatus.read
                                  ? Colors.blue
                                  : Theme.of(context).colorScheme.onPrimary.withOpacity(0.7),
                            ),
                          if (!message.isOutgoing)
                            PlatformIndicator(platform: message.platform),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          const SizedBox(width: 8),
          
          if (message.isOutgoing && showAvatar)
            CircleAvatar(
              radius: 16,
              backgroundImage: message.senderAvatar != null
                  ? NetworkImage(message.senderAvatar!)
                  : null,
              child: message.senderAvatar == null
                  ? Text(
                      message.senderName.substring(0, 1).toUpperCase(),
                      style: const TextStyle(fontSize: 12),
                    )
                  : null,
            )
          else if (message.isOutgoing && !showAvatar)
            const SizedBox(width: 32),
        ],
      ),
    );
  }
}

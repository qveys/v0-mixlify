import 'package:flutter/material.dart';
import 'package:mixlify/models/conversation.dart';
import 'package:mixlify/models/message.dart';

class ChatProvider extends ChangeNotifier {
  List<Conversation> _conversations = [];
  List<Conversation> _filteredConversations = [];
  final Map<String, List<Message>> _messages = {};
  List<Message> _searchResults = [];

  List<Conversation> get conversations => _conversations;
  List<Conversation> get filteredConversations => _filteredConversations;
  List<Message> get searchResults => _searchResults;

  Future<void> loadConversations() async {
    // TODO: Implement actual Matrix API calls to load conversations
    
    // Mock data for demo purposes
    await Future.delayed(const Duration(seconds: 1));
    
    _conversations = [
      Conversation(
        id: '1',
        displayName: 'Alice Johnson',
        avatarUrl: null,
        platforms: ['Matrix', 'WhatsApp'],
        lastMessage: 'Hey, how are you doing?',
        lastMessageTime: DateTime.now().subtract(const Duration(minutes: 5)),
        unreadCount: 2,
        isOnline: true,
      ),
      Conversation(
        id: '2',
        displayName: 'Bob Smith',
        avatarUrl: null,
        platforms: ['Telegram'],
        lastMessage: 'Did you see the news today?',
        lastMessageTime: DateTime.now().subtract(const Duration(hours: 1)),
        unreadCount: 0,
        isOnline: false,
      ),
      Conversation(
        id: '3',
        displayName: 'Carol White',
        avatarUrl: null,
        platforms: ['Matrix', 'Messenger'],
        lastMessage: 'Let\'s meet tomorrow at 2pm',
        lastMessageTime: DateTime.now().subtract(const Duration(hours: 3)),
        unreadCount: 0,
        isOnline: true,
      ),
      Conversation(
        id: '4',
        displayName: 'David Brown',
        avatarUrl: null,
        platforms: ['WhatsApp'],
        lastMessage: 'Check out this link I found',
        lastMessageTime: DateTime.now().subtract(const Duration(days: 1)),
        unreadCount: 0,
        isOnline: false,
      ),
      Conversation(
        id: '5',
        displayName: 'Emma Davis',
        avatarUrl: null,
        platforms: ['Matrix', 'SMS'],
        lastMessage: 'Thanks for your help!',
        lastMessageTime: DateTime.now().subtract(const Duration(days: 2)),
        unreadCount: 0,
        isOnline: false,
      ),
    ];
    
    _filteredConversations = List.from(_conversations);
    notifyListeners();
  }

  Future<void> loadMessages(String conversationId) async {
    // TODO: Implement actual Matrix API calls to load messages
    
    // Mock data for demo purposes
    await Future.delayed(const Duration(milliseconds: 800));
    
    final messages = <Message>[];
    final now = DateTime.now();
    
    // Generate mock messages based on conversation ID
    switch (conversationId) {
      case '1':
        messages.addAll([
          Message(
            id: '101',
            conversationId: conversationId,
            senderId: 'alice',
            senderName: 'Alice Johnson',
            content: 'Hey, how are you doing?',
            timestamp: now.subtract(const Duration(minutes: 30)),
            platform: 'WhatsApp',
          ),
          Message(
            id: '102',
            conversationId: conversationId,
            senderId: 'me',
            senderName: 'Me',
            content: 'I\'m good, thanks! How about you?',
            timestamp: now.subtract(const Duration(minutes: 25)),
            status: MessageStatus.read,
            platform: 'Matrix',
          ),
          Message(
            id: '103',
            conversationId: conversationId,
            senderId: 'alice',
            senderName: 'Alice Johnson',
            content: 'Doing well! Just finished a big project at work.',
            timestamp: now.subtract(const Duration(minutes: 20)),
            platform: 'WhatsApp',
          ),
          Message(
            id: '104',
            conversationId: conversationId,
            senderId: 'alice',
            senderName: 'Alice Johnson',
            content: 'Want to grab coffee this weekend?',
            timestamp: now.subtract(const Duration(minutes: 5)),
            platform: 'Matrix',
          ),
        ]);
        break;
      case '2':
        messages.addAll([
          Message(
            id: '201',
            conversationId: conversationId,
            senderId: 'bob',
            senderName: 'Bob Smith',
            content: 'Did you see the news today?',
            timestamp: now.subtract(const Duration(hours: 1)),
            platform: 'Telegram',
          ),
        ]);
        break;
      case '3':
        messages.addAll([
          Message(
            id: '301',
            conversationId: conversationId,
            senderId: 'carol',
            senderName: 'Carol White',
            content: 'Hey, are you free tomorrow?',
            timestamp: now.subtract(const Duration(hours: 4)),
            platform: 'Messenger',
          ),
          Message(
            id: '302',
            conversationId: conversationId,
            senderId: 'me',
            senderName: 'Me',
            content: 'Yes, I should be free after lunch. What\'s up?',
            timestamp: now.subtract(const Duration(hours: 3, minutes: 55)),
            status: MessageStatus.read,
            platform: 'Matrix',
          ),
          Message(
            id: '303',
            conversationId: conversationId,
            senderId: 'carol',
            senderName: 'Carol White',
            content: 'Let\'s meet tomorrow at 2pm',
            timestamp: now.subtract(const Duration(hours: 3)),
            platform: 'Messenger',
          ),
        ]);
        break;
      default:
        // Generate some generic messages for other conversations
        messages.addAll([
          Message(
            id: '901',
            conversationId: conversationId,
            senderId: conversationId,
            senderName: getConversationById(conversationId)?.displayName ?? 'Unknown',
            content: 'Hello there!',
            timestamp: now.subtract(const Duration(days: 1, hours: 2)),
            platform: getConversationById(conversationId)?.platforms.first ?? 'Matrix',
          ),
          Message(
            id: '902',
            conversationId: conversationId,
            senderId: 'me',
            senderName: 'Me',
            content: 'Hi! How can I help you?',
            timestamp: now.subtract(const Duration(days: 1, hours: 1)),
            status: MessageStatus.read,
            platform: 'Matrix',
          ),
        ]);
    }
    
    _messages[conversationId] = messages;
    notifyListeners();
  }

  List<Message> getMessagesForConversation(String conversationId) {
    return _messages[conversationId] ?? [];
  }

  Conversation? getConversationById(String id) {
    try {
      return _conversations.firstWhere((conv) => conv.id == id);
    } catch (e) {
      return null;
    }
  }

  void filterByPlatform(String platform) {
    if (platform == 'All') {
      _filteredConversations = List.from(_conversations);
    } else {
      _filteredConversations = _conversations
          .where((conv) => conv.platforms.contains(platform))
          .toList();
    }
    notifyListeners();
  }

  Future<void> sendMessage(String conversationId, String content, String platform) async {
    // TODO: Implement actual Matrix API calls to send messages
    
    // Create a new message
    final newMessage = Message(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      conversationId: conversationId,
      senderId: 'me',
      senderName: 'Me',
      content: content,
      timestamp: DateTime.now(),
      status: MessageStatus.sent,
      platform: platform,
    );
    
    // Add to messages list
    if (_messages.containsKey(conversationId)) {
      _messages[conversationId]!.add(newMessage);
    } else {
      _messages[conversationId] = [newMessage];
    }
    
    // Update conversation last message
    final conversationIndex = _conversations.indexWhere((conv) => conv.id == conversationId);
    if (conversationIndex != -1) {
      _conversations[conversationIndex] = _conversations[conversationIndex].copyWith(
        lastMessage: content,
        lastMessageTime: DateTime.now(),
      );
      
      // Also update filtered conversations if needed
      final filteredIndex = _filteredConversations.indexWhere((conv) => conv.id == conversationId);
      if (filteredIndex != -1) {
        _filteredConversations[filteredIndex] = _filteredConversations[filteredIndex].copyWith(
          lastMessage: content,
          lastMessageTime: DateTime.now(),
        );
      }
    }
    
    notifyListeners();
    
    // Simulate message status updates
    await Future.delayed(const Duration(seconds: 1));
    updateMessageStatus(newMessage.id, MessageStatus.delivered);
    
    await Future.delayed(const Duration(seconds: 2));
    updateMessageStatus(newMessage.id, MessageStatus.read);
  }

  void updateMessageStatus(String messageId, MessageStatus status) {
    for (final conversationId in _messages.keys) {
      final index = _messages[conversationId]!.indexWhere((msg) => msg.id == messageId);
      if (index != -1) {
        _messages[conversationId]![index] = _messages[conversationId]![index].copyWith(
          status: status,
        );
        notifyListeners();
        break;
      }
    }
  }

  void markConversationAsRead(String conversationId) {
    final index = _conversations.indexWhere((conv) => conv.id == conversationId);
    if (index != -1 && _conversations[index].unreadCount > 0) {
      _conversations[index] = _conversations[index].copyWith(
        unreadCount: 0,
      );
      
      // Also update filtered conversations if needed
      final filteredIndex = _filteredConversations.indexWhere((conv) => conv.id == conversationId);
      if (filteredIndex != -1) {
        _filteredConversations[filteredIndex] = _filteredConversations[filteredIndex].copyWith(
          unreadCount: 0,
        );
      }
      
      notifyListeners();
    }
  }

  void deleteConversation(String conversationId) {
    _conversations.removeWhere((conv) => conv.id == conversationId);
    _filteredConversations.removeWhere((conv) => conv.id == conversationId);
    _messages.remove(conversationId);
    notifyListeners();
  }

  void searchMessages({
    required String query,
    String? platform,
    DateTime? startDate,
    DateTime? endDate,
  }) {
    if (query.isEmpty) {
      _searchResults = [];
      notifyListeners();
      return;
    }
    
    final results = <Message>[];
    
    // Search through all messages
    for (final conversationId in _messages.keys) {
      for (final message in _messages[conversationId]!) {
        // Check if message content contains the query
        if (message.content.toLowerCase().contains(query.toLowerCase())) {
          // Apply platform filter if specified
          if (platform != null && platform != 'All' && message.platform != platform) {
            continue;
          }
          
          // Apply date filters if specified
          if (startDate != null && message.timestamp.isBefore(startDate)) {
            continue;
          }
          
          if (endDate != null) {
            // Add one day to include the end date fully
            final adjustedEndDate = endDate.add(const Duration(days: 1));
            if (message.timestamp.isAfter(adjustedEndDate)) {
              continue;
            }
          }
          
          results.add(message);
        }
      }
    }
    
    // Sort results by timestamp (newest first)
    results.sort((a, b) => b.timestamp.compareTo(a.timestamp));
    
    _searchResults = results;
    notifyListeners();
  }
}

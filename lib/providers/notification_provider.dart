import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationProvider extends ChangeNotifier {
  bool _notificationsEnabled = true;
  bool _soundEnabled = true;
  bool _vibrationEnabled = true;
  final Map<String, bool> _mutedConversations = {};

  bool get notificationsEnabled => _notificationsEnabled;
  bool get soundEnabled => _soundEnabled;
  bool get vibrationEnabled => _vibrationEnabled;
  Map<String, bool> get mutedConversations => _mutedConversations;

  NotificationProvider() {
    _loadPreferences();
  }

  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    _notificationsEnabled = prefs.getBool('notificationsEnabled') ?? true;
    _soundEnabled = prefs.getBool('soundEnabled') ?? true;
    _vibrationEnabled = prefs.getBool('vibrationEnabled') ?? true;
    
    // Load muted conversations
    final mutedConvs = prefs.getStringList('mutedConversations') ?? [];
    for (final convId in mutedConvs) {
      _mutedConversations[convId] = true;
    }
    
    notifyListeners();
  }

  Future<void> _savePreferences() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('notificationsEnabled', _notificationsEnabled);
    await prefs.setBool('soundEnabled', _soundEnabled);
    await prefs.setBool('vibrationEnabled', _vibrationEnabled);
    
    // Save muted conversations
    final mutedConvs = _mutedConversations.entries
        .where((entry) => entry.value)
        .map((entry) => entry.key)
        .toList();
    await prefs.setStringList('mutedConversations', mutedConvs);
  }

  void toggleNotifications(bool value) {
    _notificationsEnabled = value;
    _savePreferences();
    notifyListeners();
  }

  void toggleSound(bool value) {
    _soundEnabled = value;
    _savePreferences();
    notifyListeners();
  }

  void toggleVibration(bool value) {
    _vibrationEnabled = value;
    _savePreferences();
    notifyListeners();
  }

  void muteConversation(String conversationId, bool muted) {
    _mutedConversations[conversationId] = muted;
    _savePreferences();
    notifyListeners();
  }

  bool isConversationMuted(String conversationId) {
    return _mutedConversations[conversationId] ?? false;
  }
}

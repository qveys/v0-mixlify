import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  bool _isLoggedIn = false;
  String _username = '';
  String _serverUrl = '';
  String? _userMatrixId;
  String? _userAvatarUrl;
  String? _accessToken;

  bool get isLoggedIn => _isLoggedIn;
  String get username => _username;
  String? get serverUrl => _serverUrl;
  String? get userMatrixId => _userMatrixId;
  String? get userAvatarUrl => _userAvatarUrl;
  String? get accessToken => _accessToken;

  Future<bool> checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    _isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    
    if (_isLoggedIn) {
      _username = prefs.getString('username') ?? '';
      _serverUrl = prefs.getString('serverUrl') ?? '';
      _userMatrixId = prefs.getString('userMatrixId');
      _userAvatarUrl = prefs.getString('userAvatarUrl');
      _accessToken = prefs.getString('accessToken');
    }
    
    return _isLoggedIn;
  }

  Future<bool> login(String serverUrl, String username, String password) async {
    // TODO: Implement actual Matrix login logic
    
    // Simulate successful login for demo purposes
    await Future.delayed(const Duration(seconds: 2));
    
    _isLoggedIn = true;
    _username = username;
    _serverUrl = serverUrl;
    _userMatrixId = '@$username:${serverUrl.replaceAll('https://', '')}';
    
    // Save login state
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', true);
    await prefs.setString('username', username);
    await prefs.setString('serverUrl', serverUrl);
    await prefs.setString('userMatrixId', _userMatrixId!);
    
    notifyListeners();
    return true;
  }

  Future<void> logout() async {
    // TODO: Implement actual Matrix logout logic
    
    _isLoggedIn = false;
    _username = '';
    _serverUrl = '';
    _userMatrixId = null;
    _userAvatarUrl = null;
    _accessToken = null;
    
    // Clear saved login state
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    
    notifyListeners();
  }

  Future<void> updateProfile({String? displayName, String? avatarUrl}) async {
    // TODO: Implement actual Matrix profile update logic
    
    if (displayName != null && displayName.isNotEmpty) {
      _username = displayName;
    }
    
    if (avatarUrl != null) {
      _userAvatarUrl = avatarUrl;
    }
    
    // Save updated profile
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', _username);
    if (_userAvatarUrl != null) {
      await prefs.setString('userAvatarUrl', _userAvatarUrl!);
    }
    
    notifyListeners();
  }
}

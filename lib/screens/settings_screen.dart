import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mixlify/providers/auth_provider.dart';
import 'package:mixlify/providers/notification_provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final notificationProvider = Provider.of<NotificationProvider>(context);

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // User profile section
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage: authProvider.userAvatarUrl != null
                      ? NetworkImage(authProvider.userAvatarUrl!)
                      : null,
                  child: authProvider.userAvatarUrl == null
                      ? Text(
                          authProvider.username.isNotEmpty
                              ? authProvider.username.substring(0, 1).toUpperCase()
                              : 'U',
                          style: const TextStyle(fontSize: 32),
                        )
                      : null,
                ),
                const SizedBox(height: 16),
                Text(
                  authProvider.username,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Text(
                  authProvider.userMatrixId ?? '',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                  ),
                ),
                const SizedBox(height: 16),
                OutlinedButton.icon(
                  icon: const Icon(Icons.edit),
                  label: const Text('Edit Profile'),
                  onPressed: () {
                    // Navigate to profile edit screen
                  },
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        
        // Account settings
        _buildSettingsSection(
          context,
          'Account Settings',
          [
            _buildSettingsTile(
              context,
              'Matrix Server',
              authProvider.serverUrl ?? 'Not connected',
              Icons.dns_rounded,
              () {
                // Navigate to server settings
              },
            ),
            _buildSettingsTile(
              context,
              'Change Password',
              '',
              Icons.lock_outline,
              () {
                // Navigate to password change screen
              },
            ),
          ],
        ),
        
        // Connected platforms
        _buildSettingsSection(
          context,
          'Connected Platforms',
          [
            _buildPlatformTile(
              context,
              'WhatsApp',
              'Connected',
              'whatsapp',
              true,
              () {
                // Manage WhatsApp connection
              },
            ),
            _buildPlatformTile(
              context,
              'Telegram',
              'Connected',
              'telegram',
              true,
              () {
                // Manage Telegram connection
              },
            ),
            _buildPlatformTile(
              context,
              'Messenger',
              'Not connected',
              'messenger',
              false,
              () {
                // Connect Messenger
              },
            ),
            _buildPlatformTile(
              context,
              'Instagram',
              'Not connected',
              'instagram',
              false,
              () {
                // Connect Instagram
              },
            ),
            ListTile(
              leading: const Icon(Icons.add_circle_outline),
              title: const Text('Connect New Platform'),
              onTap: () {
                // Show platform connection dialog
              },
            ),
          ],
        ),
        
        // Notification settings
        _buildSettingsSection(
          context,
          'Notifications',
          [
            SwitchListTile(
              title: const Text('Enable Notifications'),
              subtitle: const Text('Receive notifications for new messages'),
              secondary: const Icon(Icons.notifications_outlined),
              value: notificationProvider.notificationsEnabled,
              onChanged: (value) {
                notificationProvider.toggleNotifications(value);
              },
            ),
            SwitchListTile(
              title: const Text('Sound'),
              secondary: const Icon(Icons.volume_up_outlined),
              value: notificationProvider.soundEnabled,
              onChanged: (value) {
                notificationProvider.toggleSound(value);
              },
            ),
            SwitchListTile(
              title: const Text('Vibration'),
              secondary: const Icon(Icons.vibration),
              value: notificationProvider.vibrationEnabled,
              onChanged: (value) {
                notificationProvider.toggleVibration(value);
              },
            ),
          ],
        ),
        
        // Appearance settings
        _buildSettingsSection(
          context,
          'Appearance',
          [
            ListTile(
              leading: const Icon(Icons.color_lens_outlined),
              title: const Text('Theme'),
              subtitle: const Text('Light, Dark, or System'),
              onTap: () {
                // Show theme selection dialog
              },
            ),
            ListTile(
              leading: const Icon(Icons.text_fields),
              title: const Text('Font Size'),
              subtitle: const Text('Small, Medium, or Large'),
              onTap: () {
                // Show font size selection dialog
              },
            ),
          ],
        ),
        
        // Privacy and security
        _buildSettingsSection(
          context,
          'Privacy & Security',
          [
            ListTile(
              leading: const Icon(Icons.security),
              title: const Text('End-to-End Encryption'),
              subtitle: const Text('Manage encryption settings'),
              onTap: () {
                // Navigate to encryption settings
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete_outline),
              title: const Text('Clear Chat History'),
              onTap: () {
                _showClearHistoryDialog(context);
              },
            ),
          ],
        ),
        
        // About and help
        _buildSettingsSection(
          context,
          'About & Help',
          [
            ListTile(
              leading: const Icon(Icons.help_outline),
              title: const Text('Help & Support'),
              onTap: () {
                // Navigate to help screen
              },
            ),
            ListTile(
              leading: const Icon(Icons.info_outline),
              title: const Text('About Mixlify'),
              subtitle: const Text('Version 1.0.0'),
              onTap: () {
                // Show about dialog
              },
            ),
          ],
        ),
        
        // Logout button
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 24),
          child: ElevatedButton.icon(
            icon: const Icon(Icons.logout),
            label: const Text('Logout'),
            onPressed: () {
              _confirmLogout(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 12),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSettingsSection(
    BuildContext context,
    String title,
    List<Widget> children,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
        Card(
          child: Column(
            children: children,
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildSettingsTile(
    BuildContext context,
    String title,
    String subtitle,
    IconData icon,
    VoidCallback onTap,
  ) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      subtitle: subtitle.isNotEmpty ? Text(subtitle) : null,
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }

  Widget _buildPlatformTile(
    BuildContext context,
    String platform,
    String status,
    String platformId,
    bool isConnected,
    VoidCallback onTap,
  ) {
    Color statusColor = isConnected ? Colors.green : Colors.grey;
    
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: _getPlatformColor(platformId),
        child: Text(
          platform.substring(0, 1),
          style: const TextStyle(color: Colors.white),
        ),
      ),
      title: Text(platform),
      subtitle: Text(
        status,
        style: TextStyle(color: statusColor),
      ),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }

  Color _getPlatformColor(String platform) {
    switch (platform.toLowerCase()) {
      case 'matrix':
        return Colors.blue;
      case 'whatsapp':
        return const Color(0xFF25D366);
      case 'messenger':
        return const Color(0xFF0084FF);
      case 'telegram':
        return const Color(0xFF0088CC);
      case 'instagram':
        return const Color(0xFFE1306C);
      case 'sms':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  void _showClearHistoryDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Clear Chat History'),
          content: const Text(
            'Are you sure you want to clear all chat history? This action cannot be undone.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                // Clear chat history
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Chat history cleared'),
                  ),
                );
              },
              style: TextButton.styleFrom(
                foregroundColor: Colors.red,
              ),
              child: const Text('Clear'),
            ),
          ],
        );
      },
    );
  }

  void _confirmLogout(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Logout'),
          content: const Text('Are you sure you want to logout?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                final authProvider = Provider.of<AuthProvider>(context, listen: false);
                authProvider.logout();
                Navigator.pushReplacementNamed(context, '/login');
              },
              child: const Text('Logout'),
            ),
          ],
        );
      },
    );
  }
}

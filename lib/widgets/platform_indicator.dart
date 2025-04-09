import 'package:flutter/material.dart';

class PlatformIndicator extends StatelessWidget {
  final String platform;
  final double size;

  const PlatformIndicator({
    super.key,
    required this.platform,
    this.size = 16,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: _getPlatformColor(platform),
      ),
      child: Center(
        child: Icon(
          _getPlatformIcon(platform),
          size: size * 0.6,
          color: Colors.white,
        ),
      ),
    );
  }

  Color _getPlatformColor(String platform) {
    switch (platform.toLowerCase()) {
      case 'whatsapp':
        return const Color(0xFF25D366);
      case 'telegram':
        return const Color(0xFF0088cc);
      case 'messenger':
        return const Color(0xFF0084FF);
      case 'instagram':
        return const Color(0xFFE4405F);
      case 'facebook':
        return const Color(0xFF1877F2);
      case 'twitter':
        return const Color(0xFF1DA1F2);
      case 'linkedin':
        return const Color(0xFF0A66C2);
      case 'slack':
        return const Color(0xFF4A154B);
      case 'discord':
        return const Color(0xFF5865F2);
      case 'teams':
        return const Color(0xFF464775);
      case 'zoom':
        return const Color(0xFF2D8CFF);
      case 'skype':
        return const Color(0xFF00AFF0);
      case 'viber':
        return const Color(0xFF665CAC);
      case 'line':
        return const Color(0xFF00B900);
      case 'wechat':
        return const Color(0xFF07C160);
      case 'signal':
        return const Color(0xFF3A76F0);
      case 'vkontakte':
        return const Color(0xFF4C75A3);
      case 'reddit':
        return const Color(0xFFFF4500);
      case 'tiktok':
        return const Color(0xFF000000);
      case 'snapchat':
        return const Color(0xFFFFFC00);
      case 'pinterest':
        return const Color(0xFFE60023);
      case 'tumblr':
        return const Color(0xFF36465D);
      case 'medium':
        return const Color(0xFF000000);
      case 'github':
        return const Color(0xFF181717);
      case 'gitlab':
        return const Color(0xFFFC6D26);
      case 'bitbucket':
        return const Color(0xFF0052CC);
      case 'jira':
        return const Color(0xFF0052CC);
      case 'trello':
        return const Color(0xFF0052CC);
      case 'asana':
        return const Color(0xFFF06A6A);
      case 'notion':
        return const Color(0xFF000000);
      case 'evernote':
        return const Color(0xFF2DBE60);
      case 'dropbox':
        return const Color(0xFF0061FE);
      case 'google drive':
        return const Color(0xFF1FA463);
      case 'onedrive':
        return const Color(0xFF0364B8);
      case 'box':
        return const Color(0xFF0061D5);
      case 'icloud':
        return const Color(0xFF5D5D5D);
      case 'mega':
        return const Color(0xFFD9272E);
      case 'pcloud':
        return const Color(0xFF0083FF);
      case 'yandex.disk':
        return const Color(0xFFFC3F1D);
      case 'mediafire':
        return const Color(0xFF4A90E2);
      case 'microsoft':
        return const Color(0xFF00A4EF);
      case 'apple':
        return const Color(0xFF000000);
      case 'google':
        return const Color(0xFF4285F4);
      case 'amazon':
        return const Color(0xFFFF9900);
      case 'netflix':
        return const Color(0xFFE50914);
      case 'spotify':
        return const Color(0xFF1DB954);
      case 'youtube':
        return const Color(0xFFFF0000);
      case 'twitch':
        return const Color(0xFF9146FF);
      case 'soundcloud':
        return const Color(0xFFFF3300);
      case 'deezer':
        return const Color(0xFF00C7F2);
      case 'tidal':
        return const Color(0xFF000000);
      case 'apple music':
        return const Color(0xFFFA243C);
      case 'google play music':
        return const Color(0xFF4285F4);
      case 'amazon music':
        return const Color(0xFF00A8E1);
      case 'yandex.music':
        return const Color(0xFFFC3F1D);
      case 'vk music':
        return const Color(0xFF4C75A3);
      case 'mail.ru':
        return const Color(0xFF005FF9);
      case 'gmail':
        return const Color(0xFFEA4335);
      case 'outlook':
        return const Color(0xFF0078D4);
      case 'yahoo':
        return const Color(0xFF6001D2);
      case 'protonmail':
        return const Color(0xFF6D4AFF);
      case 'icloud mail':
        return const Color(0xFF5D5D5D);
      case 'yandex.mail':
        return const Color(0xFFFC3F1D);
      case 'mail.ru mail':
        return const Color(0xFF005FF9);
      case 'vk mail':
        return const Color(0xFF4C75A3);
      case 'telegram mail':
        return const Color(0xFF0088cc);
      case 'whatsapp mail':
        return const Color(0xFF25D366);
      case 'messenger mail':
        return const Color(0xFF0084FF);
      case 'instagram mail':
        return const Color(0xFFE4405F);
      case 'facebook mail':
        return const Color(0xFF1877F2);
      case 'twitter mail':
        return const Color(0xFF1DA1F2);
      case 'linkedin mail':
        return const Color(0xFF0A66C2);
      case 'slack mail':
        return const Color(0xFF4A154B);
      case 'discord mail':
        return const Color(0xFF5865F2);
      case 'teams mail':
        return const Color(0xFF464775);
      case 'zoom mail':
        return const Color(0xFF2D8CFF);
      case 'skype mail':
        return const Color(0xFF00AFF0);
      case 'viber mail':
        return const Color(0xFF665CAC);
      case 'line mail':
        return const Color(0xFF00B900);
      case 'wechat mail':
        return const Color(0xFF07C160);
      case 'signal mail':
        return const Color(0xFF3A76F0);
      case 'vkontakte mail':
        return const Color(0xFF4C75A3);
      case 'reddit mail':
        return const Color(0xFFFF4500);
      case 'tiktok mail':
        return const Color(0xFF000000);
      case 'snapchat mail':
        return const Color(0xFFFFFC00);
      case 'pinterest mail':
        return const Color(0xFFE60023);
      case 'tumblr mail':
        return const Color(0xFF36465D);
      case 'medium mail':
        return const Color(0xFF000000);
      case 'github mail':
        return const Color(0xFF181717);
      case 'gitlab mail':
        return const Color(0xFFFC6D26);
      case 'bitbucket mail':
        return const Color(0xFF0052CC);
      case 'jira mail':
        return const Color(0xFF0052CC);
      case 'trello mail':
        return const Color(0xFF0052CC);
      case 'asana mail':
        return const Color(0xFFF06A6A);
      case 'notion mail':
        return const Color(0xFF000000);
      case 'evernote mail':
        return const Color(0xFF2DBE60);
      case 'dropbox mail':
        return const Color(0xFF0061FE);
      case 'google drive mail':
        return const Color(0xFF1FA463);
      case 'onedrive mail':
        return const Color(0xFF0364B8);
      case 'box mail':
        return const Color(0xFF0061D5);
      case 'icloud mail mail':
        return const Color(0xFF5D5D5D);
      case 'mega mail':
        return const Color(0xFFD9272E);
      case 'pcloud mail':
        return const Color(0xFF0083FF);
      case 'yandex.disk mail':
        return const Color(0xFFFC3F1D);
      case 'mediafire mail':
        return const Color(0xFF4A90E2);
      case 'microsoft mail':
        return const Color(0xFF00A4EF);
      case 'apple mail':
        return const Color(0xFF000000);
      case 'google mail':
        return const Color(0xFF4285F4);
      case 'amazon mail':
        return const Color(0xFFFF9900);
      case 'netflix mail':
        return const Color(0xFFE50914);
      case 'spotify mail':
        return const Color(0xFF1DB954);
      case 'youtube mail':
        return const Color(0xFFFF0000);
      case 'twitch mail':
        return const Color(0xFF9146FF);
      case 'soundcloud mail':
        return const Color(0xFFFF3300);
      case 'deezer mail':
        return const Color(0xFF00C7F2);
      case 'tidal mail':
        return const Color(0xFF000000);
      case 'apple music mail':
        return const Color(0xFFFA243C);
      case 'google play music mail':
        return const Color(0xFF4285F4);
      case 'amazon music mail':
        return const Color(0xFF00A8E1);
      case 'yandex.music mail':
        return const Color(0xFFFC3F1D);
      case 'vk music mail':
        return const Color(0xFF4C75A3);
      default:
        return Colors.grey;
    }
  }

  IconData _getPlatformIcon(String platform) {
    switch (platform.toLowerCase()) {
      case 'whatsapp':
        return Icons.message;
      case 'telegram':
        return Icons.telegram;
      case 'messenger':
        return Icons.message;
      case 'instagram':
        return Icons.camera_alt;
      case 'facebook':
        return Icons.facebook;
      case 'twitter':
        return Icons.flutter_dash;
      case 'linkedin':
        return Icons.business;
      case 'slack':
        return Icons.chat;
      case 'discord':
        return Icons.games;
      case 'teams':
        return Icons.groups;
      case 'zoom':
        return Icons.video_camera_front;
      case 'skype':
        return Icons.video_camera_back;
      case 'viber':
        return Icons.phone;
      case 'line':
        return Icons.line_style;
      case 'wechat':
        return Icons.chat_bubble;
      case 'signal':
        return Icons.security;
      case 'vkontakte':
        return Icons.public;
      case 'reddit':
        return Icons.reddit;
      case 'tiktok':
        return Icons.music_note;
      case 'snapchat':
        return Icons.camera_alt;
      case 'pinterest':
        return Icons.image;
      case 'tumblr':
        return Icons.article;
      case 'medium':
        return Icons.article;
      case 'github':
        return Icons.code;
      case 'gitlab':
        return Icons.code;
      case 'bitbucket':
        return Icons.code;
      case 'jira':
        return Icons.bug_report;
      case 'trello':
        return Icons.view_kanban;
      case 'asana':
        return Icons.task;
      case 'notion':
        return Icons.note;
      case 'evernote':
        return Icons.note;
      case 'dropbox':
        return Icons.cloud;
      case 'google drive':
        return Icons.folder;
      case 'onedrive':
        return Icons.folder;
      case 'box':
        return Icons.folder;
      case 'icloud':
        return Icons.cloud;
      case 'mega':
        return Icons.cloud;
      case 'pcloud':
        return Icons.cloud;
      case 'yandex.disk':
        return Icons.folder;
      case 'mediafire':
        return Icons.cloud;
      case 'microsoft':
        return Icons.window;
      case 'apple':
        return Icons.apple;
      case 'google':
        return Icons.g_mobiledata;
      case 'amazon':
        return Icons.shopping_cart;
      case 'netflix':
        return Icons.movie;
      case 'spotify':
        return Icons.music_note;
      case 'youtube':
        return Icons.play_circle;
      case 'twitch':
        return Icons.live_tv;
      case 'soundcloud':
        return Icons.music_note;
      case 'deezer':
        return Icons.music_note;
      case 'tidal':
        return Icons.music_note;
      case 'apple music':
        return Icons.music_note;
      case 'google play music':
        return Icons.music_note;
      case 'amazon music':
        return Icons.music_note;
      case 'yandex.music':
        return Icons.music_note;
      case 'vk music':
        return Icons.music_note;
      case 'mail.ru':
        return Icons.mail;
      case 'gmail':
        return Icons.mail;
      case 'outlook':
        return Icons.mail;
      case 'yahoo':
        return Icons.mail;
      case 'protonmail':
        return Icons.mail;
      case 'icloud mail':
        return Icons.mail;
      case 'yandex.mail':
        return Icons.mail;
      case 'mail.ru mail':
        return Icons.mail;
      case 'vk mail':
        return Icons.mail;
      case 'telegram mail':
        return Icons.mail;
      case 'whatsapp mail':
        return Icons.mail;
      case 'messenger mail':
        return Icons.mail;
      case 'instagram mail':
        return Icons.mail;
      case 'facebook mail':
        return Icons.mail;
      case 'twitter mail':
        return Icons.mail;
      case 'linkedin mail':
        return Icons.mail;
      case 'slack mail':
        return Icons.mail;
      case 'discord mail':
        return Icons.mail;
      case 'teams mail':
        return Icons.mail;
      case 'zoom mail':
        return Icons.mail;
      case 'skype mail':
        return Icons.mail;
      case 'viber mail':
        return Icons.mail;
      case 'line mail':
        return Icons.mail;
      case 'wechat mail':
        return Icons.mail;
      case 'signal mail':
        return Icons.mail;
      case 'vkontakte mail':
        return Icons.mail;
      case 'reddit mail':
        return Icons.mail;
      case 'tiktok mail':
        return Icons.mail;
      case 'snapchat mail':
        return Icons.mail;
      case 'pinterest mail':
        return Icons.mail;
      case 'tumblr mail':
        return Icons.mail;
      case 'medium mail':
        return Icons.mail;
      case 'github mail':
        return Icons.mail;
      case 'gitlab mail':
        return Icons.mail;
      case 'bitbucket mail':
        return Icons.mail;
      case 'jira mail':
        return Icons.mail;
      case 'trello mail':
        return Icons.mail;
      case 'asana mail':
        return Icons.mail;
      case 'notion mail':
        return Icons.mail;
      case 'evernote mail':
        return Icons.mail;
      case 'dropbox mail':
        return Icons.mail;
      case 'google drive mail':
        return Icons.mail;
      case 'onedrive mail':
        return Icons.mail;
      case 'box mail':
        return Icons.mail;
      case 'icloud mail mail':
        return Icons.mail;
      case 'mega mail':
        return Icons.mail;
      case 'pcloud mail':
        return Icons.mail;
      case 'yandex.disk mail':
        return Icons.mail;
      case 'mediafire mail':
        return Icons.mail;
      case 'microsoft mail':
        return Icons.mail;
      case 'apple mail':
        return Icons.mail;
      case 'google mail':
        return Icons.mail;
      case 'amazon mail':
        return Icons.mail;
      case 'netflix mail':
        return Icons.mail;
      case 'spotify mail':
        return Icons.mail;
      case 'youtube mail':
        return Icons.mail;
      case 'twitch mail':
        return Icons.mail;
      case 'soundcloud mail':
        return Icons.mail;
      case 'deezer mail':
        return Icons.mail;
      case 'tidal mail':
        return Icons.mail;
      case 'apple music mail':
        return Icons.mail;
      case 'google play music mail':
        return Icons.mail;
      case 'amazon music mail':
        return Icons.mail;
      case 'yandex.music mail':
        return Icons.mail;
      case 'vk music mail':
        return Icons.mail;
      default:
        return Icons.devices_other;
    }
  }
}

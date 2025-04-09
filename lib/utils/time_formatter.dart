import 'package:intl/intl.dart';

class TimeFormatter {
  static String formatMessageTime(DateTime dateTime) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final dateToCheck = DateTime(dateTime.year, dateTime.month, dateTime.day);

    if (dateToCheck == today) {
      // Today, show time only
      return DateFormat('h:mm a').format(dateTime);
    } else if (dateToCheck == yesterday) {
      // Yesterday
      return 'Yesterday';
    } else if (now.difference(dateTime).inDays < 7) {
      // Within the last week, show day name
      return DateFormat('EEEE').format(dateTime);
    } else {
      // Older than a week, show date
      return DateFormat('MMM d').format(dateTime);
    }
  }

  static String formatDate(DateTime dateTime) {
    return DateFormat('MMM d, yyyy').format(dateTime);
  }
}

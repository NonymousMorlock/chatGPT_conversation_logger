import 'package:intl/intl.dart';

extension DateExtensions on DateTime {
  String get timeAgo {
    final difference = DateTime.now().difference(this);
    if (difference.inDays > 365) {
      final years = (difference.inDays / 365).floor();
      return '$years year${years > 1 ? 's' : ''} ago -- $year';
    } else if (difference.inDays > 30) {
      final months = (difference.inDays / 30).floor();
      return '$months month${months > 1 ? 's' : ''} ago -- '
          '${DateFormat.MMMM().format(this)}';
    } else if (difference.inDays > 0) {
      return '${difference.inDays} day${difference.inDays > 1 ? 's' : ''} ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} '
          'hour${difference.inHours > 1 ? 's' : ''} ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} '
          'minute${difference.inMinutes > 1 ? 's' : ''} ago';
    } else {
      return 'now';
    }
  }

  String get plainDate {
    final day = DateFormat('EEEE').format(this);
    final date = DateFormat('d').format(this);
    final month = DateFormat('MMMM').format(this);
    final year = DateFormat('yyyy').format(this);

    final ordinalDate = _getDayOfMonthSuffix(int.parse(date));

    return '$day, $date$ordinalDate $month $year';
  }

  String _getDayOfMonthSuffix(int n) {
    assert(n >= 1 && n <= 31, 'illegal day of month: $n');
    if (n >= 11 && n <= 13) {
      return 'th';
    }
    switch (n % 10) {
      case 1:
        return 'st';
      case 2:
        return 'nd';
      case 3:
        return 'rd';
      default:
        return 'th';
    }
  }
}

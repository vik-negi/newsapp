import 'package:intl/intl.dart';

String formatTimeAgo(String timestamp) {
  DateTime dateTime = DateTime.parse(timestamp);
  Duration difference = DateTime.now().difference(dateTime);

  if (difference.inDays > 0) {
    return DateFormat.yMMMMd().format(dateTime); // Example: July 17, 2024
  } else if (difference.inHours > 0) {
    return '${difference.inHours} ${difference.inHours == 1 ? 'hour ago' : 'hours ago'}';
  } else if (difference.inMinutes > 0) {
    return '${difference.inMinutes} ${difference.inMinutes == 1 ? 'min ago' : 'mins ago'}';
  } else {
    return 'few seconds ago';
  }
}

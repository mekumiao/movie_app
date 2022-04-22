import 'package:intl/intl.dart';

import 'date_utils.dart';

class FormatUtils {
  FormatUtils._();

  /// 格式化价格
  static String price(num price) {
    final oCcy = NumberFormat('#,##0.00', 'en_US');
    return oCcy.format(price);
  }

  /// 格式化时间戳(秒级时间戳)
  static String timestamp(String? timestamp) {
    if (timestamp != null && timestamp.isNotEmpty) {
      final seconds = int.tryParse(timestamp);
      if (seconds != null) {
        final dateTime = DateTime.fromMillisecondsSinceEpoch(seconds * 1000);
        return DateUtils.apiDayFormat(dateTime);
      }
    }
    return '--';
  }

  /// 格式化时间戳(毫秒级时间戳)
  static String timestampMS(String? timestamp) {
    if (timestamp != null && timestamp.isNotEmpty) {
      final seconds = int.tryParse(timestamp);
      if (seconds != null) {
        final dateTime = DateTime.fromMillisecondsSinceEpoch(seconds);
        return DateUtils.apiDayFormat(dateTime);
      }
    }
    return '--';
  }
}

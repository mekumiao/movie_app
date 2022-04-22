import 'package:url_launcher/url_launcher.dart';

class LanuchException implements Exception {}

class LanuchUtils {
  /// 打开链接
  static Future<void> webURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw LanuchException();
    }
  }

  /// 调起拨号页
  static Future<void> telURL(String phone) async {
    final String url = 'tel:$phone';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw LanuchException();
    }
  }
}

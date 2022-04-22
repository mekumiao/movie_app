import 'package:flutter/foundation.dart';

class Constant {
  Constant._();

  /// App运行在Release环境时，inProduction为true；当App运行在Debug和Profile环境时，inProduction为false
  static const bool isProduction = kReleaseMode;

  static const String data = 'data';
  static const String message = 'message';
  static const String code = 'code';

  static const String keyGuide = 'keyGuide';
  static const String phone = 'phone';
  static const String accessToken = 'accessToken';
  static const String refreshToken = 'refreshToken';

  static const String apiHost = 'apiHost';
  static const String defaultApiHost = 'http://localhost:8100';

  static const int limitSize = 20;
  static const String cookie = 'cookie';
}

import 'package:cookie_jar/cookie_jar.dart';
import 'package:design/design.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:utils/util.dart';

class ApiHelper {
  ApiHelper._();
  static Dio? _dio;
  static final CookieJar cookieJar = CookieJar();

  static String get _baseUrl {
    return '${SpUtil.getString(Constant.apiHost, defValue: Constant.defaultApiHost)}/api/';
  }

  static void resetInstance() {
    _dio = null;
  }

  static Dio getInstance() {
    final dio = Dio(BaseOptions(
      baseUrl: _baseUrl,
      receiveTimeout: 20 * 1000,
      // connectTimeout 在Web端导致 Bad state：Future already completed 错误
      connectTimeout: Device.isWeb ? 0 : 2 * 1000,
      validateStatus: (statusCode) => statusCode == 200,
    ));
    dio.interceptors.add(CookieManager(cookieJar));
    return dio;
  }

  static Dio get dio => _dio ??= getInstance();
}

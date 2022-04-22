import 'package:design/design.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:movie_api/movie_api.dart';
import 'package:remote_movie_api/src/api_helper.dart';
import 'package:utils/util.dart';

class AccountRequestFailure implements Exception {}

class LoginFailure implements Exception {
  const LoginFailure({this.message = ''});

  final String message;
}

class RemoteAccountApi extends AccountApi {
  @override
  Future<UserDto?> login(LoginAdd input) async {
    try {
      final resp = await ApiHelper.dio.post('account/login', data: input);
      final output = OutputResult.fromJson(resp.data);
      if (output.code == 0) {
        final cookies = await ApiHelper.cookieJar.loadForRequest(resp.realUri);
        final cookie = CookieManager.getCookies(cookies);
        await SpUtil.putString(Constant.cookie, cookie);
        return UserDto.fromJson(output.result);
      }
      throw LoginFailure(message: output.msg);
    } on DioError {
      throw AccountRequestFailure();
    }
  }

  @override
  Future<void> logout() async {
    await ApiHelper.dio.post('account/logout');
  }
}

import 'package:movie_api/movie_api.dart';

abstract class UserApi {
  Future<UserDto?> get();
}

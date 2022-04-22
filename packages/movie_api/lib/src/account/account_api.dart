import 'package:movie_api/src/user/models/models.dart';

import 'models/models.dart';

abstract class AccountApi {
  Future<UserDto?> login(LoginAdd input);
  Future<void> logout();
}

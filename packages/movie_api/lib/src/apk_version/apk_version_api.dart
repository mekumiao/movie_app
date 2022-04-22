import 'package:movie_api/src/apk_version/models/models.dart';

abstract class ApkVersionApi {
  Future<ApkVersionDto?> latest();
}

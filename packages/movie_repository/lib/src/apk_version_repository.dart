import 'package:movie_api/movie_api.dart';

class ApkVersionRepository {
  const ApkVersionRepository({
    required ApkVersionApi apkVersionApi,
  }) : _apkVersionApi = apkVersionApi;

  final ApkVersionApi _apkVersionApi;

  Future<ApkVersionDto?> latest() async {
    return _apkVersionApi.latest();
  }
}

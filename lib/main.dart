import 'package:flutter/gestures.dart';
import 'package:flutter_services_binding/flutter_services_binding.dart';
import 'package:remote_movie_api/remote_movie_api.dart';
import 'package:utils/util.dart';

import 'bootstrap.dart';

Future<void> main() async {
  FlutterServicesBinding.ensureInitialized();

  GestureBinding.instance?.resamplingEnabled = true;

  await Device.initDeviceInfo();
  await SpUtil.getInstance();

  final movieApi = RemoteMovieApi();
  final movieFileApi = RemoteMovieFileApi();
  final movieTypeApi = RemoteMovieTypeApi();
  final userSearchHistoryApi = RemoteUserSearchHistoryApi();
  final actorApi = RemoteActorApi();
  final hostConfigApi = RemoteHostConfigApi();
  final apkVersionApi = RemoteApkVersionApi();
  final workerApi = RemoteWorkerApi();
  final accountApi = RemoteAccountApi();
  final fileApi = RemoteFileApi();

  await bootstrap(
    movieApi: movieApi,
    movieFileApi: movieFileApi,
    movieTypeApi: movieTypeApi,
    userSearchHistoryApi: userSearchHistoryApi,
    actorApi: actorApi,
    hostConfigApi: hostConfigApi,
    apkVersionApi: apkVersionApi,
    workerApi: workerApi,
    accountApi: accountApi,
    fileApi: fileApi,
  );
}

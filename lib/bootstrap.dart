import 'dart:async';
import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:movie_api/movie_api.dart';
import 'package:movie_app/app/app.dart';
import 'package:movie_app/app/app_bloc_observer.dart';
import 'package:path_provider/path_provider.dart';
import 'package:utils/util.dart';

Future<void> bootstrap({
  required MovieApi movieApi,
  required MovieFileApi movieFileApi,
  required MovieTypeApi movieTypeApi,
  required UserSearchHistoryApi userSearchHistoryApi,
  required ActorApi actorApi,
  required HostConfigApi hostConfigApi,
  required ApkVersionApi apkVersionApi,
  required WorkerApi workerApi,
  required AccountApi accountApi,
  required FileApi fileApi,
}) async {
  final storage = await HydratedStorage.build(
    storageDirectory: Device.isWeb ? HydratedStorage.webStorageDirectory : await getTemporaryDirectory(),
  );

  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  final runZoned = HydratedBlocOverrides.runZoned(
    () => runApp(App(
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
    )),
    blocObserver: AppBlocObserver(),
    storage: storage,
  );

  runZonedGuarded(
    () => runZoned,
    (error, stackTrace) => log(error.toString(), stackTrace: stackTrace),
  );
}

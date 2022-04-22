import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:movie_api/movie_api.dart';
import 'package:movie_app/home/home.dart';
import 'package:movie_app/login/login.dart';
import 'package:movie_app/setting/setting.dart';
import 'package:movie_app/theme/theme_datas.dart';
import 'package:movie_repository/movie_repository.dart';
import 'package:oktoast/oktoast.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:share_widgets/share_widgets.dart';
import 'package:utils/util.dart';

class App extends StatelessWidget {
  const App({
    Key? key,
    required this.movieApi,
    required this.movieFileApi,
    required this.movieTypeApi,
    required this.userSearchHistoryApi,
    required this.actorApi,
    required this.hostConfigApi,
    required this.apkVersionApi,
    required this.workerApi,
    required this.accountApi,
    required this.fileApi,
  }) : super(key: key);

  final MovieApi movieApi;
  final MovieFileApi movieFileApi;
  final MovieTypeApi movieTypeApi;
  final UserSearchHistoryApi userSearchHistoryApi;
  final ActorApi actorApi;
  final HostConfigApi hostConfigApi;
  final ApkVersionApi apkVersionApi;
  final WorkerApi workerApi;
  final AccountApi accountApi;
  final FileApi fileApi;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (_) => MovieRepository(
            movieApi: movieApi,
            movieFileApi: movieFileApi,
            movieTypeApi: movieTypeApi,
            fileApi: fileApi,
          ),
        ),
        RepositoryProvider(
          create: (_) => SearchHistoryRepository(
            userSearchHistoryApi: userSearchHistoryApi,
          ),
        ),
        RepositoryProvider(
          create: (_) => ActorRepositroy(
            actorApi: actorApi,
          ),
        ),
        RepositoryProvider(
          create: (_) => ConfigRepository(
            hostConfigApi: hostConfigApi,
          ),
        ),
        RepositoryProvider(
          create: (_) => ApkVersionRepository(
            apkVersionApi: apkVersionApi,
          ),
        ),
        RepositoryProvider(
          create: (_) => WorkerRepository(
            workerApi: workerApi,
          ),
        ),
        RepositoryProvider(
          create: (_) => accountApi,
        ),
        RepositoryProvider(
          create: (_) => FileRepository(
            fileApi: fileApi,
          ),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => HomeCubit()),
          BlocProvider(create: (context) => SettingBloc(configRepository: context.read())),
        ],
        child: const AppView(),
      ),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _includeOKToast(
      child: _includeRefreshConfiguration(
        child: BlocBuilder<SettingBloc, SettingState>(
          builder: (context, state) => _buildMaterialApp(state),
        ),
      ),
    );
  }

  Widget _includeOKToast({required Widget child}) {
    return OKToast(
      child: child,
      backgroundColor: Colors.black54,
      textPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      radius: 20.0,
      position: ToastPosition.bottom,
      duration: const Duration(milliseconds: 2000),
      dismissOtherOnShow: true,
    );
  }

  Widget _includeRefreshConfiguration({required Widget child}) {
    return RefreshConfiguration(
      headerBuilder: () => const WaterDropHeader(),
      footerBuilder: () => const ClassicFooter(),
      headerTriggerDistance: 80.0,
      springDescription: const SpringDescription(stiffness: 170, damping: 16, mass: 1.9),
      maxOverScrollExtent: 100,
      maxUnderScrollExtent: 0,
      enableScrollWhenRefreshCompleted: true,
      enableLoadingWhenFailed: true,
      hideFooterWhenNotFull: false,
      enableBallisticLoad: true,
      child: child,
    );
  }

  Widget _buildMaterialApp(SettingState state) {
    return MaterialApp(
      home: const LoginPage(),
      theme: ThemeDatas.lightThemeData,
      darkTheme: ThemeDatas.darkThemeData,
      themeMode: state.mode,
      scrollBehavior: const MaterialScrollBehavior().copyWith(
        scrollbars: true,
        dragDevices: {
          PointerDeviceKind.touch,
          PointerDeviceKind.stylus,
          PointerDeviceKind.invertedStylus,
          //解决desktop端使用鼠标不能拖动问题
          PointerDeviceKind.mouse,
          PointerDeviceKind.unknown
        },
      ),
      onGenerateTitle: (context) => AppLocalizations.of(context).title,
      localizationsDelegates: const [
        ...AppLocalizations.localizationsDelegates,
        RefreshLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      locale: state.locale,
      builder: (BuildContext context, Widget? child) {
        /// 仅针对安卓
        if (Device.isAndroid) {
          /// 切换深色模式会触发此方法，这里设置导航栏颜色
          ThemeUtils.setSystemNavigationBar(state.mode);
        }

        /// 保证文字大小不受手机系统设置影响 https://www.kikt.top/posts/flutter/layout/dynamic-text/
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
          child: child!,
        );
      },

      /// 因为使用了fluro，这里设置主要针对Web
      onUnknownRoute: (_) {
        return MaterialPageRoute<void>(
          builder: (BuildContext context) => const NotFoundPage(),
        );
      },
      restorationScopeId: 'movie',
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:movie_api/movie_api.dart';
import 'package:movie_app/login/login.dart';
import 'package:movie_app/update/update.dart';
import 'package:share_widgets/share_widgets.dart';
import 'package:utils/util.dart';

import '../bloc/setting_bloc.dart';
import 'host_page.dart';
import 'language_page.dart';
import 'theme_page.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const SettingPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        centerTitle: AppLocalizations.of(context).setting,
      ),
      body: MyScrollView(
        children: <Widget>[
          const ThemeClickItem(),
          const LanguageClickItem(),
          const HostClickItem(),
          if (Device.isMobile) const UpdateClickItem(),
          const ReLoginClickItem(),
        ],
      ),
    );
  }
}

class ThemeClickItem extends StatelessWidget {
  const ThemeClickItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingBloc, SettingState>(
      buildWhen: (previous, current) => previous.mode != current.mode,
      builder: (context, state) => ClickItem(
        title: AppLocalizations.of(context).theme,
        content: themeText(context, state.mode),
        onTap: () {
          Navigator.push(context, ThemePage.route());
        },
      ),
    );
  }

  String themeText(BuildContext context, ThemeMode mode) {
    switch (mode) {
      case ThemeMode.dark:
        return AppLocalizations.of(context).darkTheme;
      case ThemeMode.light:
        return AppLocalizations.of(context).lightTheme;
      case ThemeMode.system:
        return AppLocalizations.of(context).followSystem;
      default:
        return AppLocalizations.of(context).followSystem;
    }
  }
}

class HostClickItem extends StatelessWidget {
  const HostClickItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingBloc, SettingState>(
      buildWhen: (previous, current) => previous.hostIndex != current.hostIndex,
      builder: (context, state) => ClickItem(
        title: 'Host',
        content: state.selectedHost.name,
        onTap: () {
          context.read<SettingBloc>().add(const HostsFetched());
          Navigator.push(context, HostPage.route());
        },
      ),
    );
  }
}

class LanguageClickItem extends StatelessWidget {
  const LanguageClickItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingBloc, SettingState>(
      buildWhen: (previous, current) => previous.languageCode != current.languageCode,
      builder: (context, state) => ClickItem(
        title: AppLocalizations.of(context).language,
        content: languageText(context, state.languageCode),
        onTap: () {
          Navigator.push(context, LanguagePage.route());
        },
      ),
    );
  }

  String languageText(BuildContext context, String languageCode) {
    switch (languageCode) {
      case 'zh':
        return '简体中文';
      case 'en':
        return 'English';
      default:
        return AppLocalizations.of(context).followSystem;
    }
  }
}

class ReLoginClickItem extends StatelessWidget {
  const ReLoginClickItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingBloc, SettingState>(
      buildWhen: (previous, current) => previous.languageCode != current.languageCode,
      builder: (context, state) => ClickItem(
        title: '退出登录',
        content: '点击退出登录',
        onTap: () {
          context.read<AccountApi>().logout();
          context.read<SettingBloc>().add(const UserChanged(user: UserDto()));
          Navigator.of(context).pushAndRemoveUntil(LoginPage.route(), (route) => false);
        },
      ),
    );
  }
}

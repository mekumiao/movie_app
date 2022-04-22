import 'package:design/design.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:share_widgets/share_widgets.dart';

import '../bloc/setting_bloc.dart';

class ThemePage extends StatelessWidget {
  const ThemePage({Key? key}) : super(key: key);

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const ThemePage());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingBloc, SettingState>(
      builder: (context, state) => Scaffold(
        appBar: MyAppBar(
          centerTitle: AppLocalizations.of(context).theme,
        ),
        body: ListView(
          children: [
            Gaps.vGap16,
            _buildThemeItem(
              context: context,
              state: state,
              text: AppLocalizations.of(context).lightTheme,
              mode: ThemeMode.light,
            ),
            Gaps.line,
            _buildThemeItem(
              context: context,
              state: state,
              text: AppLocalizations.of(context).darkTheme,
              mode: ThemeMode.dark,
            ),
            Gaps.line,
            _buildThemeItem(
              context: context,
              state: state,
              text: AppLocalizations.of(context).followSystem,
              mode: ThemeMode.system,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildThemeItem({
    required BuildContext context,
    required SettingState state,
    required String text,
    required ThemeMode mode,
  }) {
    return InkWell(
      onTap: () {
        context.read<SettingBloc>().add(ThemeModeChanged(mode: mode));
      },
      child: Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        height: 50.0,
        child: Row(
          children: <Widget>[
            Expanded(
              child: Text(text),
            ),
            Opacity(
              opacity: state.mode == mode ? 1 : 0,
              child: const Icon(Icons.done, color: Colors.blue),
            )
          ],
        ),
      ),
    );
  }
}

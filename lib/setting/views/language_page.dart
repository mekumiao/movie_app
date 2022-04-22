import 'package:design/design.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:share_widgets/share_widgets.dart';

import '../bloc/setting_bloc.dart';

class LanguagePage extends StatelessWidget {
  const LanguagePage({Key? key}) : super(key: key);

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const LanguagePage());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingBloc, SettingState>(
      builder: (context, state) => Scaffold(
        appBar: MyAppBar(
          centerTitle: AppLocalizations.of(context).language,
        ),
        body: ListView(
          children: [
            Gaps.vGap16,
            _buildThemeItem(
              context: context,
              state: state,
              text: '简体中文',
              languageCode: 'zh',
            ),
            Gaps.line,
            _buildThemeItem(
              context: context,
              state: state,
              text: 'English',
              languageCode: 'en',
            ),
            Gaps.line,
            _buildThemeItem(
              context: context,
              state: state,
              text: AppLocalizations.of(context).followSystem,
              languageCode: '',
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
    required String languageCode,
  }) {
    return InkWell(
      onTap: () {
        context.read<SettingBloc>().add(LanguageCodeChanged(languageCode: languageCode));
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
              opacity: state.languageCode == languageCode ? 1 : 0,
              child: const Icon(Icons.done, color: Colors.blue),
            )
          ],
        ),
      ),
    );
  }
}

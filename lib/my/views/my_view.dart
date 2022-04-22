import 'package:design/design.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:movie_app/gen/assets.gen.dart';
import 'package:movie_app/setting/setting.dart';
import 'package:utils/util.dart';

class MyView extends StatefulWidget {
  const MyView({Key? key}) : super(key: key);

  @override
  State<MyView> createState() => _MyViewState();
}

class _MyViewState extends State<MyView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: <Widget>[
          IconButton(
            tooltip: AppLocalizations.of(context).setting,
            onPressed: () {
              Navigator.push(context, SettingPage.route());
            },
            icon: Assets.images.setting.image(
              key: const Key('setting'),
              width: 24.0,
              height: 24.0,
              color: ThemeUtils.getIconColor(context),
            ),
          )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Gaps.vGap12,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: MergeSemantics(
              child: Stack(
                children: <Widget>[
                  const SizedBox(width: double.infinity, height: 56.0),
                  Text(AppLocalizations.of(context).movie, style: TextStyles.textBold24),
                  Positioned(
                    right: 0.0,
                    child: CircleAvatar(
                      radius: 28.0,
                      backgroundColor: Colors.transparent,
                      backgroundImage: Assets.images.none,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Gaps.vGap24,
          Gaps.line,
          // TextButton(
          //   onPressed: () {
          //     Navigator.push(context, UploadPage.route());
          //   },
          //   child: const Text('上传'),
          // )
        ],
      ),
    );
  }
}

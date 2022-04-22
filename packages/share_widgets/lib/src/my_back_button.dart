import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:utils/util.dart';

class MyBackButton extends StatelessWidget {
  const MyBackButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () async {
        FocusManager.instance.primaryFocus?.unfocus();
        final isBack = await Navigator.maybePop(context);
        if (!isBack) {
          await SystemNavigator.pop();
        }
      },
      tooltip: 'Back',
      padding: const EdgeInsets.all(12.0),
      icon: Image.asset(
        'assets/ic_back_black.png',
        color: ThemeUtils.getIconColor(context),
        package: 'share_widgets',
      ),
    );
  }
}

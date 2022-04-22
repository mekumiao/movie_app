import 'package:flutter/material.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:utils/util.dart';

class IntlTools {
  static KeyboardActionsConfig getKeyboardActionsConfig(BuildContext context, List<FocusNode> list) {
    return KeyboardActionsConfig(
      keyboardBarColor: ThemeUtils.getKeyboardActionsColor(context),
      nextFocus: true,
      actions: List.generate(
        list.length,
        (i) => KeyboardActionsItem(
          focusNode: list[i],
          toolbarButtons: [
            (node) {
              return GestureDetector(
                onTap: () => node.unfocus(),
                child: const Padding(
                  padding: EdgeInsets.only(right: 16.0),
                  child: Text('关闭'),
                ),
              );
            },
          ],
        ),
      ),
    );
  }
}

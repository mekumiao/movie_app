import 'package:design/design.dart';
import 'package:flutter/material.dart';
import 'package:share_widgets/share_widgets.dart';

class DeleteBottomSheet extends StatelessWidget {
  const DeleteBottomSheet({
    Key? key,
    required this.onTapDelete,
  }) : super(key: key);

  final VoidCallback onTapDelete;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const SizedBox(
              height: 52.0,
              child: Center(
                child: Text(
                  '是否确认删除，防止错误操作',
                  style: TextStyles.textSize16,
                ),
              ),
            ),
            Gaps.line,
            MyButton(
              minHeight: 54.0,
              textColor: Theme.of(context).errorColor,
              text: '确认删除',
              backgroundColor: Colors.transparent,
              onPressed: () {
                Navigator.of(context).maybePop();
                onTapDelete();
              },
            ),
            Gaps.line,
            MyButton(
              minHeight: 54.0,
              textColor: Colours.text_gray,
              text: '取消',
              backgroundColor: Colors.transparent,
              onPressed: () {
                Navigator.of(context).maybePop();
              },
            ),
          ],
        ),
      ),
    );
  }
}

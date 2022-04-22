import 'package:design/design.dart';
import 'package:flutter/material.dart';

class TextSwitch extends StatelessWidget {
  const TextSwitch({
    Key? key,
    required this.text,
    this.checked,
    this.onChanged,
  }) : super(key: key);

  final String text;
  final bool? checked;
  final void Function(bool?)? onChanged;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (checked == null) {
          onChanged?.call(true);
        } else if (checked == true) {
          onChanged?.call(false);
        } else {
          onChanged?.call(null);
        }
      },
      child: Chip(
        backgroundColor: checked == true
            ? Colours.app_main
            : checked == false
                ? Colours.red
                : null,
        label: Text(
          text,
          style: TextStyles.textSize12,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}

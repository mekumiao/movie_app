import 'package:design/design.dart';
import 'package:flutter/material.dart';

class LabelText extends StatelessWidget {
  const LabelText({
    Key? key,
    required this.label,
    this.text,
    this.maxLines,
    this.overflow,
    this.textAlign,
  }) : super(key: key);

  final String label;
  final String? text;
  final int? maxLines;
  final TextOverflow? overflow;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    final child = Row(
      children: [
        Text(label),
        Gaps.hGap16,
        Expanded(
          child: SelectableText(
            text ?? '',
            maxLines: maxLines,
            textAlign: textAlign,
          ),
        ),
        Gaps.hGap16,
      ],
    );

    return ConstrainedBox(
      constraints: const BoxConstraints(minHeight: 50.0),
      child: Container(
        margin: const EdgeInsets.only(left: 16.0),
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border(
            bottom: Divider.createBorderSide(context, width: 0.6),
          ),
        ),
        child: child,
      ),
    );
  }
}

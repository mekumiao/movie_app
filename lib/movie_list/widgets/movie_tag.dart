import 'package:design/design.dart';
import 'package:flutter/material.dart';
import 'package:utils/util.dart';

class MovieTag extends StatelessWidget {
  const MovieTag({
    Key? key,
    required this.color,
    required this.text,
  }) : super(key: key);

  final Color? color;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      margin: const EdgeInsets.only(right: 4.0),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(2.0),
      ),
      height: 16.0,
      alignment: Alignment.center,
      child: Text(
        text,
        textDirection: TextDirection.ltr,
        style: TextStyle(
          color: Colors.white,
          fontSize: Dimens.font_sp10,
          height: Device.isAndroid ? 1.1 : null,
        ),
      ),
    );
  }
}

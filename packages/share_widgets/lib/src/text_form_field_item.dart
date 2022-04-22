import 'package:design/design.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:utils/util.dart';

/// 封装输入框
class TextFormFieldItem extends StatelessWidget {
  const TextFormFieldItem({
    Key? key,
    this.controller,
    required this.title,
    this.keyboardType = TextInputType.text,
    this.hintText = '',
    this.focusNode,
    this.initialValue,
    this.textInputAction,
    this.onChanged,
  }) : super(key: key);

  final TextEditingController? controller;
  final String title;
  final String hintText;
  final TextInputType keyboardType;
  final FocusNode? focusNode;
  final String? initialValue;
  final TextInputAction? textInputAction;
  final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    final Row child = Row(
      children: <Widget>[
        Text(title),
        Gaps.hGap16,
        Expanded(
          child: Semantics(
            label: hintText.isEmpty ? '请输入$title' : hintText,
            child: TextFormField(
              initialValue: initialValue,
              focusNode: focusNode,
              keyboardType: keyboardType,
              textInputAction: textInputAction,
              inputFormatters: _getInputFormatters(),
              controller: controller,
              decoration: InputDecoration(
                hintText: hintText,
                border: InputBorder.none,
                errorMaxLines: 0,
                helperMaxLines: 0,
              ),
              onChanged: onChanged,
            ),
          ),
        ),
        Gaps.hGap16
      ],
    );

    return Container(
      height: 80,
      margin: const EdgeInsets.only(left: 16.0),
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border(
          bottom: Divider.createBorderSide(context, width: 0.6),
        ),
      ),
      child: child,
    );
  }

  List<TextInputFormatter>? _getInputFormatters() {
    if (keyboardType == const TextInputType.numberWithOptions(decimal: true)) {
      return <TextInputFormatter>[UsNumberTextInputFormatter()];
    }
    if (keyboardType == TextInputType.number || keyboardType == TextInputType.phone) {
      return <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly];
    }
    return null;
  }
}

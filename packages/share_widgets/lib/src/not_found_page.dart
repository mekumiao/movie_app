import 'package:flutter/material.dart';

import 'empty_layout.dart';
import 'my_app_bar.dart';

class NotFoundPage extends StatelessWidget {
  const NotFoundPage({
    Key? key,
    this.title,
  }) : super(key: key);

  final String? title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        centerTitle: title ?? '页面不存在',
      ),
      body: const EmptyLayout(
        type: EmptyType.account,
        hintText: '页面不存在',
      ),
    );
  }
}

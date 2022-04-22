import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_widgets/share_widgets.dart';

import '../bloc/upload_bloc.dart';
import 'upload_list.dart';

class UploadPage extends StatelessWidget {
  const UploadPage({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const UploadPage());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UploadBloc(),
      child: const UploadView(),
    );
  }
}

class UploadView extends StatelessWidget {
  const UploadView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: MyAppBar(centerTitle: '上传'),
      body: UploadList(),
    );
  }
}

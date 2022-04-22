import 'package:design/design.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/upload/bloc/upload_bloc.dart';
import 'package:remote_movie_api/remote_movie_api.dart';

class UploadList extends StatefulWidget {
  const UploadList({Key? key}) : super(key: key);

  @override
  State<UploadList> createState() => _UploadListState();
}

class _UploadListState extends State<UploadList> {
  final List<CancelToken> _cancelTokens = [];
  late double progress = 0;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UploadBloc, UploadState>(
      builder: (context, state) => Column(
        children: [
          Gaps.hGap16,
          _buildTaskAppend(context),
          Gaps.hGap10,
          _buildItem(context),
        ],
      ),
    );
  }

  Widget _buildItem(BuildContext context) {
    return LinearProgressIndicator(
      backgroundColor: Colours.line,
      valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
      value: progress,
    );
  }

  Widget _buildTaskAppend(BuildContext context) {
    return TextButton(
        onPressed: () async {
          final result = await FilePicker.platform.pickFiles(allowMultiple: true);
          if (result != null) {
            final cancelToken = CancelToken();
            _cancelTokens.add(cancelToken);
            RemoteUploadApi().upload(
              result.paths.first!,
              cancelToken: cancelToken,
              progressCallback: (count, total) {
                setState(() {
                  progress = count / total;
                });
              },
            );
          }
        },
        child: const Text('选择文件'));
  }
}

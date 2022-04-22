import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:remote_movie_api/remote_movie_api.dart';

part 'upload_event.dart';
part 'upload_state.dart';

class UploadBloc extends Bloc<UploadEvent, UploadState> {
  UploadBloc() : super(const UploadState()) {
    on<UploadTaskAppend>(_onUploadTaskAppend);
  }

  final List<CancelToken> _cancelTokens = [];

  Future<void> _onUploadTaskAppend(
    UploadTaskAppend event,
    Emitter<UploadState> emit,
  ) async {
    final cancelToken = CancelToken();
    _cancelTokens.add(cancelToken);
    RemoteUploadApi().upload(
      event.filename,
      cancelToken: cancelToken,
      progressCallback: (count, data) {
        emit(state.copyWith(progress: data / count));
      },
    );
  }

  @override
  Future<void> close() {
    _cancelTokens.map((e) => e.cancel());
    return super.close();
  }
}

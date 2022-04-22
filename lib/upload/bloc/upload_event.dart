part of 'upload_bloc.dart';

abstract class UploadEvent extends Equatable {
  const UploadEvent();

  @override
  List<Object> get props => [];
}

class UploadTaskAppend extends UploadEvent {
  const UploadTaskAppend({required this.filename});

  final String filename;

  @override
  List<Object> get props => [filename];
}

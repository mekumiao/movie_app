import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'worker_message.g.dart';

enum RunningState {
  initial,
  running,
  completed,
  pausing,
  paused,
  cancelling,
  cancelled,
  error,
}

@JsonSerializable()
class WorkerMessage extends Equatable {
  const WorkerMessage({
    this.state = 0,
    this.message = '',
    this.progress = 0,
  });

  factory WorkerMessage.fromJson(Map<String, dynamic> json) => _$WorkerMessageFromJson(json);

  final int state;
  final String message;
  final int progress;

  Map<String, dynamic> toJson() => _$WorkerMessageToJson(this);

  @override
  List<Object?> get props => [state, message, progress];
}

part of 'actor_bloc.dart';

enum ActorStatus { initial, loading, refreshed, failure }

class ActorState extends Equatable {
  const ActorState({
    this.status = ActorStatus.initial,
    this.actors = const [],
  });

  final ActorStatus status;
  final List<ActorDto> actors;

  ActorState copyWith({
    ActorStatus? status,
    List<ActorDto>? actors,
  }) {
    return ActorState(
      status: status ?? this.status,
      actors: actors ?? this.actors,
    );
  }

  @override
  List<Object> get props => [status, actors.length];
}

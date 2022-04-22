part of 'actor_bloc.dart';

abstract class ActorEvent extends Equatable {
  const ActorEvent();

  @override
  List<Object> get props => [];
}

class ActorFetched extends ActorEvent {
  const ActorFetched();
}

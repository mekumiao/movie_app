import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_api/movie_api.dart';
import 'package:movie_repository/movie_repository.dart';

part 'actor_event.dart';
part 'actor_state.dart';

class ActorBloc extends Bloc<ActorEvent, ActorState> {
  ActorBloc({required ActorRepositroy actorRepositroy})
      : _actorRepositroy = actorRepositroy,
        super(const ActorState()) {
    on<ActorFetched>(_onActorFetched);
  }

  final ActorRepositroy _actorRepositroy;

  Future<void> _onActorFetched(
    ActorFetched event,
    Emitter<ActorState> emit,
  ) async {
    try {
      emit(state.copyWith(status: ActorStatus.loading));
      final actors = await _actorRepositroy.getAllActor();
      emit(state.copyWith(status: ActorStatus.refreshed, actors: actors));
    } catch (e) {
      emit(state.copyWith(status: ActorStatus.failure));
    }
  }
}

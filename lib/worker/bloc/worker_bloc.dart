import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_api/movie_api.dart';
import 'package:movie_repository/movie_repository.dart';
import 'package:utils/util.dart';

part 'worker_event.dart';
part 'worker_state.dart';

class WorkerBloc extends Bloc<WorkerEvent, WorkerState> {
  WorkerBloc({
    required WorkerRepository workerRepository,
  })  : _workerRepository = workerRepository,
        super(const WorkerState()) {
    on<WorkerRefreshed>(_onWorkerRefreshed);
    on<MovieSyncRun>(_onMovieSyncRun);
    on<MovieFileSyncRun>(_onMovieFileSyncRun);
    on<MoviePictureSyncRun>(_onMoviePictureSyncRun);
  }

  final WorkerRepository _workerRepository;

  Future<void> _onWorkerRefreshed(
    WorkerRefreshed event,
    Emitter<WorkerState> emit,
  ) async {
    emit(state.copyWith(status: WorkerStatus.loading));
    try {
      final movieMessage = await _workerRepository.getMovieSyncMessage();
      emit(state.copyWith(movieMessage: movieMessage));

      final movieFileMessage = await _workerRepository.getMovieFileSyncMessage();
      emit(state.copyWith(movieFileMessage: movieFileMessage));

      final moviePictureMessage = await _workerRepository.getMoviePictureSyncMessage();
      emit(state.copyWith(moviePictureMessage: moviePictureMessage));

      emit(state.copyWith(status: WorkerStatus.refreshed));
    } catch (e) {
      emit(state.copyWith(status: WorkerStatus.failure));
      showToast(e.toString());
    }
  }

  Future<void> _onMovieSyncRun(
    MovieSyncRun event,
    Emitter<WorkerState> emit,
  ) async {
    emit(state.copyWith(status: WorkerStatus.loading));
    try {
      await _workerRepository.runMovieSync(const MovieSyncPayload());
      final movieMessage = await _workerRepository.getMovieSyncMessage();
      emit(state.copyWith(movieMessage: movieMessage, status: WorkerStatus.refreshed));
    } catch (e) {
      emit(state.copyWith(status: WorkerStatus.failure));
      showToast(e.toString());
    }
  }

  Future<void> _onMovieFileSyncRun(
    MovieFileSyncRun event,
    Emitter<WorkerState> emit,
  ) async {
    emit(state.copyWith(status: WorkerStatus.loading));
    try {
      await _workerRepository.runMovieFileSync();
      final movieFileMessage = await _workerRepository.getMovieFileSyncMessage();
      emit(state.copyWith(movieFileMessage: movieFileMessage, status: WorkerStatus.refreshed));
    } catch (e) {
      emit(state.copyWith(status: WorkerStatus.failure));
      showToast(e.toString());
    }
  }

  Future<void> _onMoviePictureSyncRun(
    MoviePictureSyncRun event,
    Emitter<WorkerState> emit,
  ) async {
    emit(state.copyWith(status: WorkerStatus.loading));
    try {
      await _workerRepository.runMoviePictureSync();
      final moviePictureMessage = await _workerRepository.getMoviePictureSyncMessage();
      emit(state.copyWith(moviePictureMessage: moviePictureMessage, status: WorkerStatus.refreshed));
    } catch (e) {
      emit(state.copyWith(status: WorkerStatus.failure));
      showToast(e.toString());
    }
  }
}

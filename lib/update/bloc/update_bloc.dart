import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_api/movie_api.dart';
import 'package:movie_repository/movie_repository.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:utils/util.dart';

part 'update_event.dart';
part 'update_state.dart';

class UpdateBloc extends Bloc<UpdateEvent, UpdateState> {
  UpdateBloc({
    required ApkVersionRepository apkVersionRepository,
  })  : _apkVersionRepository = apkVersionRepository,
        super(const UpdateState()) {
    on<CheckUpdate>(_onCheckUpdate);
  }

  final ApkVersionRepository _apkVersionRepository;

  Future<void> _onCheckUpdate(
    CheckUpdate event,
    Emitter<UpdateState> emit,
  ) async {
    try {
      emit(state.copyWith(status: UpdateStateStatus.loading));
      final latest = await _apkVersionRepository.latest();
      if (latest != null) {
        final packageInfo = await PackageInfo.fromPlatform();
        if (int.parse(packageInfo.buildNumber) < latest.versionCode) {
          emit(state.copyWith(
            status: UpdateStateStatus.needUpdate,
            apkVersion: latest,
            currentVersionName: packageInfo.version,
          ));
          return;
        }
      }
      emit(state.copyWith(status: UpdateStateStatus.aleadyLatest));
    } catch (e) {
      showToast(e.toString());
      emit(state.copyWith(status: UpdateStateStatus.failure));
    }
  }
}

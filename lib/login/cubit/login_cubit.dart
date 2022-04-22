import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:movie_api/movie_api.dart';
import 'package:remote_movie_api/remote_movie_api.dart';
import 'package:utils/util.dart';

part 'login_state.dart';
part 'login_cubit.g.dart';

class LoginCubit extends HydratedCubit<LoginState> {
  LoginCubit({required AccountApi accountApi})
      : _accountApi = accountApi,
        super(const LoginState());

  final AccountApi _accountApi;

  Future<void> changeUsername(String username) async {
    emit(state.copyWith(
      loginAdd: state.loginAdd.copyWith(username: username),
    ));
  }

  Future<void> changePassword(String password) async {
    emit(state.copyWith(
      loginAdd: state.loginAdd.copyWith(password: password),
    ));
  }

  Future<UserDto?> login() async {
    try {
      emit(state.copyWith(status: LoginStatus.loading));
      final user = await _accountApi.login(state.loginAdd);
      emit(state.copyWith(status: LoginStatus.success));
      return user;
    } on LoginFailure catch (e) {
      showToast(e.message);
      emit(state.copyWith(status: LoginStatus.failure));
    } catch (e) {
      emit(state.copyWith(status: LoginStatus.failure));
      showToast(e.toString());
    }
    return null;
  }

  @override
  LoginState? fromJson(Map<String, dynamic> json) => LoginState.fromJson(json);

  @override
  Map<String, dynamic>? toJson(LoginState state) => state.toJson();
}

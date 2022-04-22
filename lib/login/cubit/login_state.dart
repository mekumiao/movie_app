part of 'login_cubit.dart';

enum LoginStatus { initial, loading, success, failure }

@JsonSerializable()
class LoginState extends Equatable {
  const LoginState({
    this.status = LoginStatus.initial,
    this.loginAdd = const LoginAdd(),
  });

  factory LoginState.fromJson(Map<String, dynamic> json) => _$LoginStateFromJson(json);

  final LoginStatus status;
  final LoginAdd loginAdd;

  Map<String, dynamic> toJson() => _$LoginStateToJson(this);

  LoginState copyWith({
    LoginStatus? status,
    LoginAdd? loginAdd,
  }) {
    return LoginState(
      status: status ?? this.status,
      loginAdd: loginAdd ?? this.loginAdd,
    );
  }

  @override
  List<Object> get props => [status, loginAdd];
}

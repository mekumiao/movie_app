import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'login_add.g.dart';

@JsonSerializable()
class LoginAdd extends Equatable {
  const LoginAdd({
    this.username = '',
    this.password = '',
  });

  factory LoginAdd.fromJson(Map<String, dynamic> json) => _$LoginAddFromJson(json);

  final String username;
  final String password;

  Map<String, dynamic> toJson() => _$LoginAddToJson(this);

  LoginAdd copyWith({
    String? username,
    String? password,
  }) {
    return LoginAdd(
      username: username ?? this.username,
      password: password ?? this.password,
    );
  }

  @override
  List<Object?> get props => [username, password];
}

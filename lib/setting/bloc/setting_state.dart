part of 'setting_bloc.dart';

const defaultHosts = [
  HostConfigDto(
    host: Constant.defaultApiHost,
    name: Constant.defaultApiHost,
  ),
  HostConfigDto(
    host: 'http://192.168.0.101:8100',
    name: 'http://192.168.0.101:8100',
  ),
  HostConfigDto(
    host: 'http://192.168.43.189:8100',
    name: 'http://192.168.43.189:8100',
  ),
];

@JsonSerializable()
class SettingState extends Equatable {
  const SettingState({
    this.mode = ThemeMode.system,
    this.languageCode = '',
    this.hostIndex = 0,
    this.hosts = defaultHosts,
    this.user = const UserDto(),
  });

  factory SettingState.fromJson(Map<String, dynamic> json) => _$SettingStateFromJson(json);

  final ThemeMode mode;
  final String languageCode;
  final int hostIndex;
  final List<HostConfigDto> hosts;
  final UserDto user;

  Locale? get locale => languageCode.isNotEmpty ? Locale(languageCode) : null;
  HostConfigDto get selectedHost => hostIndex < hosts.length ? hosts[hostIndex] : defaultHosts[0];

  SettingState copyWith({
    ThemeMode? mode,
    String? languageCode,
    int? hostIndex,
    List<HostConfigDto>? hosts,
    UserDto? user,
  }) {
    return SettingState(
      mode: mode ?? this.mode,
      languageCode: languageCode ?? this.languageCode,
      hostIndex: hostIndex ?? this.hostIndex,
      hosts: hosts ?? this.hosts,
      user: user ?? this.user,
    );
  }

  Map<String, dynamic> toJson() => _$SettingStateToJson(this);

  @override
  List<Object> get props => [hostIndex, mode, languageCode, hosts, user];
}

part of 'home_cubit.dart';

@JsonSerializable()
class HomeState extends Equatable {
  const HomeState({
    this.tabIndex = 0,
  });

  factory HomeState.fromJson(Map<String, dynamic> json) => _$HomeStateFromJson(json);

  final int tabIndex;

  Map<String, dynamic> toJson() => _$HomeStateToJson(this);

  @override
  List<Object> get props => [tabIndex];
}

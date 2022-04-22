import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:json_annotation/json_annotation.dart';

part 'home_cubit.g.dart';
part 'home_state.dart';

class HomeCubit extends HydratedCubit<HomeState> {
  HomeCubit() : super(const HomeState());

  void setTab(int tabIndex) => emit(HomeState(tabIndex: tabIndex));

  @override
  HomeState? fromJson(Map<String, dynamic> json) => HomeState.fromJson(json);

  @override
  Map<String, dynamic>? toJson(HomeState state) => state.toJson();
}

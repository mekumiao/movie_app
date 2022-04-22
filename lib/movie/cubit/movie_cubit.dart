import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:movie_api/movie_api.dart';

part 'movie_state.dart';
part 'movie_cubit.g.dart';

class MovieCubit extends HydratedCubit<MovieState> {
  MovieCubit() : super(const MovieState());

  void change({int? no, String? title, MovieQueryParameter? queryParameter}) {
    emit(state.copyWith(
      no: no,
      title: title,
      queryParameter: queryParameter,
    ));
  }

  @override
  MovieState? fromJson(Map<String, dynamic> json) => MovieState.fromJson(json);

  @override
  Map<String, dynamic>? toJson(MovieState state) => state.toJson();
}

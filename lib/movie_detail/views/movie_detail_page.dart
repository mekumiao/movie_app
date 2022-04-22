import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_api/movie_api.dart';
import 'package:movie_app/movie_detail/cubit/movie_detail_cubit.dart';
import 'package:movie_repository/movie_repository.dart';

import '../models/models.dart';
import 'movie_detail_view.dart';

class MovieDetailPage extends StatelessWidget {
  const MovieDetailPage({
    Key? key,
    required this.index,
    required this.heroTag,
    required this.movie,
  }) : super(key: key);

  final int index;
  final String heroTag;
  final MovieDto movie;

  static Route<MovieDetailResult> route({
    required int index,
    required String heroTag,
    required MovieDto movie,
  }) {
    return MaterialPageRoute<MovieDetailResult>(
      builder: (_) => MovieDetailPage(
        index: index,
        heroTag: heroTag,
        movie: movie,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => MovieDetailCubit(
        movieRepository: context.read<MovieRepository>(),
        movie: movie,
      ),
      child: MovieDetailView(index: index, heroTag: heroTag),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/movie_list/movie_list.dart';

import '../cubit/movie_cubit.dart';
import 'movie_view.dart';

class MoviePage extends StatelessWidget {
  const MoviePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => MovieCubit(),
        ),
        BlocProvider(
          create: (context) => MovieListBloc(movieRepository: context.read()),
        ),
      ],
      child: const MovieView(),
    );
  }
}

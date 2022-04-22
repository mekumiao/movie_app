import 'package:design/design.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/movie_list/movie_list.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../cubit/movie_cubit.dart';

class MovieView extends StatefulWidget {
  const MovieView({Key? key}) : super(key: key);

  @override
  State<MovieView> createState() => _MovieViewState();
}

class _MovieViewState extends State<MovieView> {
  late final RefreshController refreshController;

  @override
  void initState() {
    super.initState();

    refreshController = RefreshController(initialRefresh: false);

    final cubit = context.read<MovieCubit>();
    final bloc = context.read<MovieListBloc>();

    bloc
      ..add(MovieListQueryParameterChanged(queryParameter: cubit.state.queryParameter))
      ..add(MovieListTitleChanged(title: cubit.state.title))
      ..add(const MovieListTotalRefreshed())
      ..add(const MovieListRefreshed());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const MoviesTitle(),
        actions: [
          const MovieTotal(),
          Gaps.hGap10,
          SearchButton(
            refreshController: refreshController,
            onSearchReturned: (context, result) {
              context.read<MovieCubit>().change(
                    title: result.queryParameter.q,
                    queryParameter: result.queryParameter,
                  );
              context.read<MovieListBloc>().add(MovieListTitleChanged(title: result.queryParameter.q ?? ''));
            },
          ),
        ],
      ),
      body: MovieListView(flag: 'movie', refreshController: refreshController),
    );
  }
}

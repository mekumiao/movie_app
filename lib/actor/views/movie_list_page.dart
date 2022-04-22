import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_api/movie_api.dart';
import 'package:movie_app/movie_list/movie_list.dart';
import 'package:movie_repository/movie_repository.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:share_widgets/share_widgets.dart';

class MovieListPage extends StatelessWidget {
  const MovieListPage({
    Key? key,
    required this.title,
    required this.queryParameter,
  }) : super(key: key);

  final String title;
  final MovieQueryParameter queryParameter;

  static Route route({
    required String title,
    required MovieQueryParameter queryParameter,
  }) {
    return MaterialPageRoute<void>(
      builder: (_) => MovieListPage(title: title, queryParameter: queryParameter),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MovieListBloc(movieRepository: context.read<MovieRepository>())
        ..add(MovieListQueryParameterChanged(queryParameter: queryParameter))
        ..add(MovieListTitleChanged(title: title))
        ..add(const MovieListTotalRefreshed())
        ..add(const MovieListRefreshed()),
      child: const _MovieListView(),
    );
  }
}

class _MovieListView extends StatefulWidget {
  const _MovieListView({Key? key}) : super(key: key);

  @override
  State<_MovieListView> createState() => _MovieListViewState();
}

class _MovieListViewState extends State<_MovieListView> {
  final refreshController = RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const MyBackButton(),
        title: const MoviesTitle(),
        actions: const [MovieTotal()],
        centerTitle: true,
      ),
      body: MovieListView(flag: 'actor', refreshController: refreshController),
    );
  }
}

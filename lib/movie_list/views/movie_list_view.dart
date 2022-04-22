import 'dart:async';

import 'package:design/design.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:movie_app/gen/assets.gen.dart';
import 'package:movie_app/movie_detail/movie_detail.dart';
import 'package:movie_app/movie_list/movie_list.dart';
import 'package:movie_app/search_movie/search_movie.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:utils/util.dart';

import '../bloc/movie_list_bloc.dart';
import '../widgets/widgets.dart';

class MovieListView extends StatelessWidget {
  const MovieListView({
    Key? key,
    required this.flag,
    required this.refreshController,
  }) : super(key: key);

  final String flag;
  final RefreshController refreshController;

  @override
  Widget build(BuildContext context) {
    return BlocListener<MovieListBloc, MovieListState>(
      listenWhen: (previous, current) =>
          previous.status != current.status || previous.hasReachedMax != current.hasReachedMax,
      listener: (context, state) {
        if (state.status == MovieListStatus.refreshed) {
          refreshController.refreshCompleted();
          if (state.hasReachedMax) {
            refreshController.loadNoData();
          } else {
            refreshController.loadComplete();
          }
        } else if (state.status == MovieListStatus.loaded) {
          if (state.hasReachedMax) {
            refreshController.loadNoData();
          } else {
            refreshController.loadComplete();
          }
        } else if (state.status == MovieListStatus.refreshedFailure) {
          refreshController.refreshFailed();
        } else if (state.status == MovieListStatus.loadedFailure) {
          refreshController.loadFailed();
        }
      },
      child: BlocBuilder<MovieListBloc, MovieListState>(
        builder: (context, state) => SmartRefresher(
          enablePullDown: true,
          enablePullUp: true,
          controller: refreshController,
          onRefresh: () {
            context.read<MovieListBloc>()
              ..add(const MovieListRefreshed())
              ..add(const MovieListTotalRefreshed());
          },
          onLoading: () {
            context.read<MovieListBloc>().add(const MovieListFetched());
          },
          child: GridView.builder(
            controller: ScrollController(),
            itemCount: state.movies.length,
            physics: const AlwaysScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: Device.isMobile ? 2 : 4,
              childAspectRatio: 0.7,
            ),
            itemBuilder: (_, index) {
              final String heroTag = 'movie_picture_$flag-$index';
              return MovieItem(
                index: index,
                heroTag: heroTag,
                item: state.movies[index],
                onTap: () async {
                  final result = await Navigator.of(context).push(MovieDetailPage.route(
                    index: index,
                    heroTag: heroTag,
                    movie: state.movies[index],
                  ));
                  if (result != null) {
                    context.read<MovieListBloc>().add(MovieListItemChanged(index: result.index, movie: result.movie));
                  }
                },
              );
            },
          ),
        ),
      ),
    );
  }
}

class MovieTotal extends StatelessWidget {
  const MovieTotal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieListBloc, MovieListState>(
      buildWhen: (previous, current) =>
          previous.total != current.total || previous.movies.length != current.movies.length,
      builder: (context, state) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: Dimens.gap_dp10, vertical: Dimens.gap_dp10),
        child: Text(
          '${state.movies.length}/${state.total}',
          style: TextStyle(
            fontSize: Dimens.font_sp14,
            color: context.isDark ? Colours.dark_text : Colours.text,
          ),
        ),
      ),
    );
  }
}

class MoviesTitle extends StatelessWidget {
  const MoviesTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocSelector<MovieListBloc, MovieListState, String>(
      selector: (state) => state.title,
      builder: (context, title) => Text(
        title,
        style: TextStyle(
          fontSize: Dimens.font_sp18,
          color: context.isDark ? Colours.dark_text : Colours.text,
        ),
      ),
    );
  }
}

class SearchButton extends StatelessWidget {
  const SearchButton({
    Key? key,
    required this.refreshController,
    this.onSearchReturned,
  }) : super(key: key);

  final RefreshController refreshController;
  final FutureOr<void> Function(BuildContext context, SearchMovieResult result)? onSearchReturned;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: AppLocalizations.of(context).searchButton,
      onPressed: () async {
        final result = await Navigator.of(context).push(SearchMoviePage.route());
        if (result != null && result.isSearch == true) {
          await onSearchReturned?.call(context, result);
          context.read<MovieListBloc>().add(MovieListQueryParameterChanged(queryParameter: result.queryParameter));
          await refreshController.requestRefresh();
        }
      },
      icon: Assets.images.search.image(
        width: 24,
        height: 24,
        color: context.isDark ? Colours.dark_text : Colours.text,
      ),
    );
  }
}

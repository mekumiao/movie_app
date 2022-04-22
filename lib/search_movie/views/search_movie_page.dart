import 'package:design/design.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_api/movie_api.dart';
import 'package:movie_repository/movie_repository.dart';
import 'package:share_widgets/share_widgets.dart';

import '../bloc/search_movie_bloc.dart';
import '../models/models.dart';
import '../widgets/widgets.dart';

class SearchMoviePage extends StatelessWidget {
  const SearchMoviePage({Key? key}) : super(key: key);

  static Route<SearchMovieResult> route() {
    return MaterialPageRoute<SearchMovieResult>(builder: (_) => const SearchMoviePage());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SearchMovieBloc(
        movieRepository: context.read<MovieRepository>(),
        searchHistoryRepository: context.read<SearchHistoryRepository>(),
      ),
      child: const SearchMovieView(),
    );
  }
}

class SearchMovieView extends StatefulWidget {
  const SearchMovieView({Key? key}) : super(key: key);

  @override
  State<SearchMovieView> createState() => _SearchMovieViewState();
}

class _SearchMovieViewState extends State<SearchMovieView> {
  final qController = TextEditingController();

  @override
  void initState() {
    super.initState();

    final bloc = context.read<SearchMovieBloc>();
    qController.text = bloc.state.q;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchMovieBloc, SearchMovieState>(builder: (context, state) {
      return Scaffold(
        appBar: SearchBar(
          controller: qController,
          autofocus: false,
          hintText: '请输入影片名称查询',
          onPressed: (q) {
            final bloc = context.read<SearchMovieBloc>()
              ..add(SearchQChanged(q: q))
              ..add(const SearchHistoryChanged());
            final json = <String, dynamic>{'q': q, 'movieTypeId': state.movieTypeId}..addAll(bloc.state.parameters);
            Navigator.of(context).maybePop(
              SearchMovieResult(
                isSearch: true,
                queryParameter: MovieQueryParameter.fromJson(json),
              ),
            );
          },
        ),
        body: MyScrollView(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildActions(state),
            Gaps.vGap15,
            _buildQHistories(state),
            Gaps.vGap15,
            _buildParameters(state),
            Gaps.vGap15,
            _buildTypes(state),
          ],
        ),
      );
    });
  }

  Widget _buildActions(SearchMovieState state) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Dimens.gap_dp10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('操作', style: TextStyles.textBold14),
          Wrap(
            children: [
              InkWell(
                onTap: () => context.read<SearchMovieBloc>().add(const SearchAllowDeleteSwitched()),
                child: state.allowDelete ? const Text('退出编辑') : const Text('编辑历史'),
              ),
              Gaps.hGap10,
              Visibility(
                visible: state.allowDelete,
                child: InkWell(
                  onTap: () {
                    context.read<SearchMovieBloc>().add(const SearchHistoryCleared());
                    context.read<SearchMovieBloc>().add(const SearchAllowDeleteSwitched());
                  },
                  child: const Text('清空历史'),
                ),
              ),
              Gaps.hGap10,
              InkWell(
                onTap: () => context.read<SearchMovieBloc>().add(const SearchHistorySynced()),
                child: const Text('同步历史'),
              ),
              Gaps.hGap10,
              InkWell(
                onTap: () => context.read<SearchMovieBloc>().add(const MovieTypeReLoaded()),
                child: const Text('加载分类'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQHistories(SearchMovieState state) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Dimens.gap_dp10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('搜索历史', style: TextStyles.textBold14),
          Wrap(
            clipBehavior: Clip.antiAlias,
            alignment: WrapAlignment.start,
            runAlignment: WrapAlignment.start,
            crossAxisAlignment: WrapCrossAlignment.start,
            spacing: Dimens.font_sp10,
            children: List.generate(
              state.histories.length,
              (index) => InkWell(
                onTap: () {
                  qController.text = state.histories[index];
                },
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 100.0),
                  child: Chip(
                    label: Text(
                      state.histories[index],
                      style: TextStyles.textSize12,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    onDeleted: state.allowDelete
                        ? () => context.read<SearchMovieBloc>().add(SearchHistoryDeleted(q: state.histories[index]))
                        : null,
                  ),
                ),
              ),
            ).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildParameters(SearchMovieState state) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Dimens.font_sp10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text('过滤', style: TextStyles.textBold14),
          Wrap(
            clipBehavior: Clip.antiAlias,
            alignment: WrapAlignment.start,
            runAlignment: WrapAlignment.start,
            crossAxisAlignment: WrapCrossAlignment.start,
            spacing: Dimens.font_sp10,
            children: [
              TextSwitch(
                text: '已收藏',
                checked: state.parameters['isStar'] as bool?,
                onChanged: (checked) =>
                    context.read<SearchMovieBloc>().add(SearchParameterChanged(key: 'isStar', value: checked)),
              ),
              TextSwitch(
                text: '有图片',
                checked: state.parameters['hasPicture'] as bool?,
                onChanged: (checked) =>
                    context.read<SearchMovieBloc>().add(SearchParameterChanged(key: 'hasPicture', value: checked)),
              ),
              TextSwitch(
                text: '不喜欢',
                checked: state.parameters['isDislike'] as bool?,
                onChanged: (checked) =>
                    context.read<SearchMovieBloc>().add(SearchParameterChanged(key: 'isDislike', value: checked)),
              ),
              TextSwitch(
                text: '可播放',
                checked: state.parameters['hasMovieFile'] as bool?,
                onChanged: (checked) =>
                    context.read<SearchMovieBloc>().add(SearchParameterChanged(key: 'hasMovieFile', value: checked)),
              ),
              TextSwitch(
                text: '去重复',
                checked: state.parameters['distinct'] as bool?,
                onChanged: (checked) =>
                    context.read<SearchMovieBloc>().add(SearchParameterChanged(key: 'distinct', value: checked)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTypes(SearchMovieState state) {
    final keys = state.types.keys.toList();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Dimens.gap_dp10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text('分类', style: TextStyles.textBold14),
          Wrap(
            clipBehavior: Clip.antiAlias,
            alignment: WrapAlignment.start,
            runAlignment: WrapAlignment.start,
            crossAxisAlignment: WrapCrossAlignment.start,
            spacing: Dimens.font_sp10,
            children: List.generate(
              keys.length,
              (index) => ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 100),
                child: TextSwitch(
                  text: state.types[keys[index]] ?? '',
                  checked: state.movieTypeId == keys[index] ? true : null,
                  onChanged: (value) {
                    if (value == true) {
                      context.read<SearchMovieBloc>().add(MovieTypeChanged(id: keys[index]));
                    } else {
                      context.read<SearchMovieBloc>().add(const MovieTypeChanged(id: ''));
                    }
                  },
                ),
              ),
            ).toList(),
          ),
        ],
      ),
    );
  }
}

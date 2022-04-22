import 'package:design/design.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_widgets/share_widgets.dart';
import 'package:utils/util.dart';

import '../cubit/movie_detail_cubit.dart';
import '../models/models.dart';

class MovieDetailView extends StatefulWidget {
  const MovieDetailView({
    Key? key,
    required this.heroTag,
    required this.index,
  }) : super(key: key);

  final int index;
  final String heroTag;

  @override
  State<MovieDetailView> createState() => _MovieDetailViewState();
}

class _MovieDetailViewState extends State<MovieDetailView> {
  late bool isWithResult;

  @override
  void initState() {
    super.initState();

    isWithResult = false;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieDetailCubit, MovieDetailState>(builder: (context, state) {
      return WillPopScope(
        child: Scaffold(
          appBar: const MyAppBar(
            centerTitle: '影片详情',
          ),
          body: Column(
            children: [
              _buildPlayer(context, state),
              _buildDetail(context, state),
            ],
          ),
        ),
        onWillPop: () async {
          if (!isWithResult) {
            isWithResult = true;
            Navigator.of(context).maybePop(MovieDetailResult(index: widget.index, movie: state.movie));
            return false;
          }
          return true;
        },
      );
    });
  }

  Widget _buildPlayer(BuildContext context, MovieDetailState state) {
    return SizedBox(
      height: 240,
      width: double.infinity,
      child: state.playStatus == MoviePlayStatus.stopped
          ? Stack(
              alignment: Alignment.center,
              children: [
                Hero(
                  tag: widget.heroTag,
                  child: MyCachedNetworkImage(state.movie.pictureURL),
                ),
                if (state.movie.hasMovieFile)
                  Positioned(
                    right: 5,
                    bottom: 5,
                    child: IconButton(
                      onPressed: () => context.read<MovieDetailCubit>().play(),
                      iconSize: 80,
                      icon: ClipOval(
                        child: Material(
                          color: context.isDark ? Colors.white10 : Colors.black12,
                          child: const Icon(Icons.play_arrow, color: Colors.white70),
                        ),
                      ),
                    ),
                  )
              ],
            )
          : MyVideoPlayer(url: state.movie.movieFileURL),
    );
  }

  Widget _buildDetail(BuildContext context, MovieDetailState state) {
    return Expanded(
      child: MyScrollView(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        children: [
          Gaps.vGap8,
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                iconSize: Dimens.gap_dp24,
                onPressed: () => context.read<MovieDetailCubit>().switchStar(),
                icon: Icon(
                  Icons.star_outline_rounded,
                  color: state.isStar ? Colours.red : null,
                ),
              ),
              Gaps.hGap32,
              IconButton(
                iconSize: Dimens.gap_dp24,
                onPressed: () => context.read<MovieDetailCubit>().switchDislike(),
                icon: Icon(
                  Icons.remove_done_outlined,
                  color: state.isDislike ? Colours.red : null,
                ),
              ),
              Gaps.hGap32,
            ],
          ),
          Gaps.vGap8,
          LabelText(label: '名称', text: state.movie.name),
          Gaps.vGap8,
          LabelText(label: '视频', text: state.movie.movieFileName),
          Gaps.vGap8,
          LabelText(label: '分类', text: state.movie.movieTypeName),
          Gaps.vGap8,
          LabelText(label: '更新时间', text: FormatUtils.timestampMS(state.movie.pushTime)),
          Gaps.vGap8,
          LabelText(label: '描述', text: state.movie.remark),
          Gaps.vGap8,
          LabelText(label: '站点', text: state.movie.site.toString()),
          Gaps.vGap8,
          LabelText(label: '资源', text: state.movie.resourceLink),
        ],
      ),
    );
  }
}

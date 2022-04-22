import 'package:design/design.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:movie_api/movie_api.dart';
import 'package:movie_app/movie_edit/movie_edit.dart';
import 'package:share_widgets/share_widgets.dart';
import 'package:utils/util.dart';

import '../bloc/movie_list_bloc.dart';
import 'movie_tag.dart';

class MovieItem extends StatelessWidget {
  const MovieItem({
    Key? key,
    required this.item,
    required this.index,
    required this.onTap,
    required this.heroTag,
  }) : super(key: key);

  final MovieDto item;
  final int index;
  final VoidCallback onTap;
  final String heroTag;

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: ValueKey(index),
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (_) async {
              final result = await Navigator.of(context).push(MovieEditPage.route(
                id: item.id,
                movie: item,
              ));
              if (result != null) {
                context.read<MovieListBloc>().add(
                      MovieListItemChanged(
                        index: index,
                        movie: result.movie,
                      ),
                    );
              }
            },
            backgroundColor: const Color(0xFF21B7CA),
            foregroundColor: Colors.white,
            icon: Icons.edit,
          ),
          SlidableAction(
            onPressed: (_) {
              showModalBottomSheet<void>(
                context: context,
                builder: (_) {
                  return DeleteBottomSheet(
                    onTapDelete: () {
                      context.read<MovieListBloc>().add(MoiveListItemDeleted(index: index, id: item.id));
                    },
                  );
                },
              );
            },
            backgroundColor: const Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: Icons.delete,
          ),
        ],
      ),
      child: _buildItem(context),
    );
  }

  Widget _buildItem(BuildContext context) {
    final child = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Flexible(
              flex: 3,
              child: ExcludeSemantics(
                child: Hero(
                  tag: heroTag,
                  child: MyCachedNetworkImage(
                    item.pictureURL,
                    width: 120,
                    height: 180,
                  ),
                ),
              ),
            ),
            Gaps.hGap5,
            Flexible(
              child: Column(
                children: <Widget>[
                  Visibility(
                    visible: item.hasMovieFile,
                    child: Icon(
                      Icons.play_circle_outline,
                      color: Theme.of(context).primaryColor,
                      size: Dimens.font_sp18,
                    ),
                  ),
                  Gaps.vGap4,
                  Visibility(
                    visible: item.isStar,
                    child: Icon(
                      Icons.star_outline,
                      size: Dimens.font_sp18,
                      color: Theme.of(context).errorColor,
                    ),
                  ),
                  Gaps.vGap4,
                  Visibility(
                    visible: item.isDislike,
                    child: const Icon(
                      Icons.remove_done_outlined,
                      color: Colors.red,
                      size: Dimens.font_sp18,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
        Gaps.vGap4,
        Row(
          children: [
            Visibility(
              visible: item.movieTypeName.isNotEmpty,
              child: MovieTag(
                text: item.movieTypeName,
                color: Theme.of(context).shadowColor,
              ),
            ),
            Text(
              FormatUtils.timestampMS(item.pushTime),
              style: TextStyles.textSize10,
            ),
          ],
        ),
        Gaps.hGap4,
        Text(
          item.name,
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
          style: TextStyles.textSize12,
        ),
      ],
    );

    return Container(
      margin: const EdgeInsets.only(left: Dimens.gap_dp10, bottom: Dimens.gap_dp10),
      child: Stack(
        children: <Widget>[
          DecoratedBox(
            decoration: BoxDecoration(
              border: Border.fromBorderSide(
                Divider.createBorderSide(context, width: 0.8),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: Dimens.gap_dp10, vertical: Dimens.gap_dp4),
              child: child,
            ),
          ),
          _buildCover(),
        ],
      ),
    );
  }

  Widget _buildCover() {
    return Positioned.fill(
      child: InkWell(
        onTap: onTap,
        child: Material(
          color: Colors.transparent,
          child: Container(),
        ),
      ),
    );
  }
}

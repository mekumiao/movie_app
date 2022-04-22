import 'package:design/design.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:movie_api/movie_api.dart';
import 'package:movie_app/actor/bloc/actor_bloc.dart';
import 'package:movie_app/gen/assets.gen.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:share_widgets/share_widgets.dart';
import 'package:utils/util.dart';

import 'movie_list_page.dart';

class ActorList extends StatefulWidget {
  const ActorList({Key? key}) : super(key: key);

  @override
  State<ActorList> createState() => _ActorListState();
}

class _ActorListState extends State<ActorList> {
  late final ScrollController controller;
  late final RefreshController refreshController;

  @override
  void initState() {
    super.initState();
    controller = ScrollController();
    refreshController = RefreshController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        isBack: false,
        centerTitle: AppLocalizations.of(context).actor,
      ),
      body: BlocListener<ActorBloc, ActorState>(
        listenWhen: (previous, current) => previous.status != current.status,
        listener: (context, state) {
          if (state.status == ActorStatus.refreshed) {
            refreshController.refreshCompleted();
          } else if (state.status == ActorStatus.failure) {
            refreshController.refreshFailed();
          }
        },
        child: BlocBuilder<ActorBloc, ActorState>(
          builder: (context, state) => SmartRefresher(
            onRefresh: () {
              context.read<ActorBloc>().add(const ActorFetched());
            },
            controller: refreshController,
            child: GridView.builder(
              controller: controller,
              physics: const AlwaysScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: Dimens.gap_dp5,
                mainAxisSpacing: Dimens.gap_dp5,
                childAspectRatio: 1,
              ),
              itemCount: state.actors.length,
              itemBuilder: (context, index) {
                return _buildItems(context, state.actors[index]);
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildItems(BuildContext context, ActorDto actor) {
    return InkWell(
      onTap: () => Navigator.push(
        context,
        MovieListPage.route(
          title: actor.name,
          queryParameter: MovieQueryParameter(actorId: actor.id),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 28.0,
            backgroundColor: Colors.transparent,
            backgroundImage: _buildImageProvider(actor.pictureURL),
          ),
          Text(
            actor.name,
            textAlign: TextAlign.center,
            maxLines: 1,
            softWrap: false,
            overflow: TextOverflow.ellipsis,
            style: TextStyles.textSize12,
          ),
        ],
      ),
    );
  }

  ImageProvider _buildImageProvider(String url) {
    if (url.isNotEmpty) {
      final cookie = SpUtil.getString(Constant.cookie, defValue: '')!;
      return CachedNetworkImageProvider(url, headers: {'Cookie': cookie});
    } else {
      return Assets.images.none;
    }
  }
}

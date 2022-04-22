import 'package:design/design.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:share_widgets/share_widgets.dart';

import '../bloc/worker_bloc.dart';

class WorkerView extends StatefulWidget {
  const WorkerView({Key? key}) : super(key: key);

  @override
  State<WorkerView> createState() => _WorkerViewState();
}

class _WorkerViewState extends State<WorkerView> {
  final controller = ScrollController();
  final refreshController = RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        centerTitle: AppLocalizations.of(context).worker,
        isBack: false,
      ),
      body: BlocListener<WorkerBloc, WorkerState>(
        listenWhen: (previous, current) => previous.status != current.status,
        listener: (context, state) {
          if (state.status == WorkerStatus.refreshed) {
            refreshController.refreshCompleted();
          } else if (state.status == WorkerStatus.failure) {
            refreshController.refreshFailed();
          }
        },
        child: SmartRefresher(
          onRefresh: () {
            context.read<WorkerBloc>().add(const WorkerRefreshed());
          },
          controller: refreshController,
          child: ListView(
            controller: controller,
            children: const [
              Gaps.vGap5,
              MovieSyncWorker(),
              Gaps.vGap5,
              MovieFileSyncWorker(),
              Gaps.vGap5,
              MoviePictureSyncWorker(),
            ],
          ),
        ),
      ),
    );
  }
}

class MovieSyncWorker extends StatelessWidget {
  const MovieSyncWorker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WorkerBloc, WorkerState>(
      builder: (context, state) => Card(
          margin: const EdgeInsets.all(Dimens.gap_dp10),
          child: Padding(
            padding: const EdgeInsets.all(Dimens.gap_dp10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '电影同步',
                  style: TextStyles.textBold16,
                ),
                Gaps.line,
                Text(state.movieMessage.message),
                Gaps.vGap12,
                LinearProgressIndicator(
                  backgroundColor: Colours.line,
                  valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
                  value: state.movieProgress,
                ),
                Gaps.line,
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {},
                      child: const Text('设置'),
                    ),
                    Gaps.hGap5,
                    TextButton(
                      onPressed: () {
                        context.read<WorkerBloc>().add(const MovieSyncRun());
                      },
                      child: const Text('执行'),
                    ),
                  ],
                ),
              ],
            ),
          )),
    );
  }
}

class MovieFileSyncWorker extends StatelessWidget {
  const MovieFileSyncWorker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WorkerBloc, WorkerState>(
      builder: (context, state) => Card(
          margin: const EdgeInsets.all(Dimens.font_sp10),
          child: Padding(
            padding: const EdgeInsets.all(Dimens.font_sp10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '电影文件同步',
                  style: TextStyles.textBold16,
                ),
                Gaps.line,
                Text(state.movieFileMessage.message),
                Gaps.vGap12,
                LinearProgressIndicator(
                  backgroundColor: Colours.line,
                  valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
                  value: state.movieFileProgress,
                ),
                Gaps.line,
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        context.read<WorkerBloc>().add(const MovieFileSyncRun());
                      },
                      child: const Text('执行'),
                    ),
                  ],
                ),
              ],
            ),
          )),
    );
  }
}

class MoviePictureSyncWorker extends StatelessWidget {
  const MoviePictureSyncWorker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WorkerBloc, WorkerState>(
      builder: (context, state) => Card(
          margin: const EdgeInsets.all(Dimens.font_sp10),
          child: Padding(
            padding: const EdgeInsets.all(Dimens.font_sp10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '电影图片同步',
                  style: TextStyles.textBold16,
                ),
                Gaps.line,
                Text(state.moviePictureMessage.message),
                Gaps.vGap12,
                LinearProgressIndicator(
                  backgroundColor: Colours.line,
                  valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
                  value: state.moviePictureProgress,
                ),
                Gaps.line,
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        context.read<WorkerBloc>().add(const MoviePictureSyncRun());
                      },
                      child: const Text('执行'),
                    ),
                  ],
                ),
              ],
            ),
          )),
    );
  }
}

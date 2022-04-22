import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:share_widgets/share_widgets.dart';
import 'package:utils/util.dart';

import '../bloc/update_bloc.dart';
import '../widgets/widgets.dart';

class UpdateClickItem extends StatelessWidget {
  const UpdateClickItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UpdateBloc(apkVersionRepository: context.read()),
      child: const UpdateClickItemView(),
    );
  }
}

class UpdateClickItemView extends StatelessWidget {
  const UpdateClickItemView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<UpdateBloc, UpdateState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) async {
        if (state.status == UpdateStateStatus.needUpdate) {
          await Navigator.maybePop(context);
          showDialog<void>(
            context: context,
            barrierDismissible: false,
            builder: (_) => UpdateDialog(
              url: state.apkVersion.fileURL,
              remark: state.apkVersion.remark,
              currentVersionName: state.currentVersionName,
              versionName: state.apkVersion.versionName,
            ),
          );
        } else if (state.status == UpdateStateStatus.aleadyLatest) {
          await Navigator.maybePop(context);
          showToast('已经是最新版本', duration: const Duration(milliseconds: 3000));
        } else if (state.status == UpdateStateStatus.loading) {
          showDialog<void>(
            context: context,
            barrierDismissible: false,
            barrierColor: Colors.transparent,
            builder: (_) => const ProgressDialog(hintText: '加载中...'),
          );
        }
      },
      child: ClickItem(
        title: AppLocalizations.of(context).checkUpdate,
        onTap: () {
          context.read<UpdateBloc>().add(const CheckUpdate());
        },
      ),
    );
  }
}

import 'package:design/design.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_widgets/share_widgets.dart';

import '../bloc/setting_bloc.dart';

class HostPage extends StatelessWidget {
  const HostPage({Key? key}) : super(key: key);

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const HostPage());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingBloc, SettingState>(
      builder: (context, state) => Scaffold(
        appBar: const MyAppBar(centerTitle: 'Host'),
        body: ListView.separated(
          itemBuilder: (context, index) => _buildApiItem(context: context, state: state, index: index),
          separatorBuilder: (context, index) => Gaps.line,
          itemCount: state.hosts.length,
        ),
      ),
    );
  }

  Widget _buildApiItem({
    required BuildContext context,
    required SettingState state,
    required int index,
  }) {
    return InkWell(
      onTap: () {
        context.read<SettingBloc>().add(HostIndexChanged(index: index));
      },
      child: Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        height: 50.0,
        child: Row(
          children: <Widget>[
            Expanded(
              child: Text(state.hosts[index].name),
            ),
            Opacity(
              opacity: state.hostIndex == index ? 1 : 0,
              child: const Icon(Icons.done, color: Colors.blue),
            )
          ],
        ),
      ),
    );
  }
}

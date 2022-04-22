import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/worker_bloc.dart';
import 'worker_view.dart';

class WorkerPage extends StatelessWidget {
  const WorkerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<WorkerBloc>(
      create: (context) => WorkerBloc(workerRepository: context.read()),
      child: const WorkerView(),
    );
  }
}

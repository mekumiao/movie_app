import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/my_bloc.dart';
import 'my_view.dart';

class MyPage extends StatelessWidget {
  const MyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MyBloc>(
      create: (context) => MyBloc(),
      child: const MyView(),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_repository/movie_repository.dart';

import '../bloc/actor_bloc.dart';
import 'actor_list.dart';

class ActorPage extends StatelessWidget {
  const ActorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ActorBloc>(
      create: (context) => ActorBloc(actorRepositroy: context.read<ActorRepositroy>())..add(const ActorFetched()),
      child: const ActorList(),
    );
  }
}

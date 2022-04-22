import 'package:design/design.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_api/movie_api.dart';
import 'package:movie_repository/movie_repository.dart';
import 'package:share_widgets/share_widgets.dart';

import '../cubit/movie_edit_cubit.dart';
import '../models/models.dart';

class MovieEditPage extends StatelessWidget {
  const MovieEditPage({
    Key? key,
    required this.id,
    required this.movie,
  }) : super(key: key);

  final String id;
  final MovieDto movie;

  static Route<MovieEditResult> route({
    required String id,
    required MovieDto movie,
  }) {
    return MaterialPageRoute<MovieEditResult>(
      builder: (_) => MovieEditPage(id: id, movie: movie),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MovieEditCubit>(
      create: (context) => MovieEditCubit(id: id, movie: movie, movieRepository: context.read<MovieRepository>()),
      child: const MovieEditForm(),
    );
  }
}

class MovieEditForm extends StatefulWidget {
  const MovieEditForm({Key? key}) : super(key: key);

  @override
  State<MovieEditForm> createState() => _MovieEditFormState();
}

class _MovieEditFormState extends State<MovieEditForm> {
  final _actorNameFocusNode = FocusNode();
  final _remarkFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    final url = context.select((MovieEditCubit cubit) => cubit.state.picturePath);
    return Scaffold(
      appBar: const MyAppBar(centerTitle: '编辑电影信息'),
      body: Column(
        children: [
          Gaps.vGap16,
          Center(
            child: SelectedImage(
              remark: '封面图片',
              url: url,
              onSelected: (path) {
                context.read<MovieEditCubit>().pictureChange(path);
              },
            ),
          ),
          Gaps.vGap16,
          ActorNameInput(focusNode: _actorNameFocusNode),
          Gaps.vGap12,
          RemarkInput(focusNode: _remarkFocusNode),
          Gaps.vGap12,
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: Dimens.gap_dp16, vertical: Dimens.gap_dp8),
            child: SubmitButton(),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    _actorNameFocusNode.dispose();
    _remarkFocusNode.dispose();
    super.dispose();
  }
}

class ActorNameInput extends StatelessWidget {
  const ActorNameInput({Key? key, required this.focusNode}) : super(key: key);

  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieEditCubit, MovieEditState>(
      builder: (context, state) {
        return TextFormFieldItem(
          title: '演员名称',
          hintText: '请输入演员名称',
          focusNode: focusNode,
          initialValue: state.update.actorName,
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.next,
          onChanged: (value) {
            context.read<MovieEditCubit>().actorNameChange(value);
          },
        );
      },
    );
  }
}

class RemarkInput extends StatelessWidget {
  const RemarkInput({Key? key, required this.focusNode}) : super(key: key);

  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieEditCubit, MovieEditState>(
      builder: (context, state) {
        return TextFormFieldItem(
          title: '备注',
          hintText: '请输入备注',
          focusNode: focusNode,
          initialValue: state.update.remark,
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.done,
          onChanged: (value) {
            context.read<MovieEditCubit>().remarkChange(value);
          },
        );
      },
    );
  }
}

class SubmitButton extends StatelessWidget {
  const SubmitButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyButton(
      onPressed: () async {
        final bloc = context.read<MovieEditCubit>();
        await bloc.submit();
        Navigator.of(context).pop(MovieEditResult(movie: bloc.state.movie));
      },
      text: '提交',
    );
  }
}

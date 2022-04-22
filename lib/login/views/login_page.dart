import 'package:design/design.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/home/home.dart';
import 'package:movie_app/login/cubit/login_cubit.dart';
import 'package:movie_app/setting/setting.dart';
import 'package:share_widgets/share_widgets.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const LoginPage());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LoginCubit(accountApi: context.read()),
      child: const LoginView(),
    );
  }
}

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final usernameNode = FocusNode();
  final passwordNode = FocusNode();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final cubit = context.read<LoginCubit>();
    usernameController.text = cubit.state.loginAdd.username;
    passwordController.text = cubit.state.loginAdd.password;
  }

  @override
  void dispose() {
    usernameNode.dispose();
    passwordNode.dispose();
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        isBack: false,
        actionName: '设置',
        onPressed: () {
          Navigator.of(context).push(SettingPage.route());
        },
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: _buildBody(),
        ),
      ),
    );
  }

  List<Widget> _buildBody() {
    return <Widget>[
      const Text('用户名', style: TextStyles.textBold18),
      Gaps.vGap16,
      UsernameTextField(
        controller: usernameController,
        node: usernameNode,
      ),
      Gaps.vGap24,
      const Text('密  码', style: TextStyles.textBold18),
      Gaps.vGap16,
      PasswordTextField(
        controller: passwordController,
        node: passwordNode,
      ),
      Gaps.vGap24,
      MyButton(
        key: const Key('ok'),
        onPressed: () async {
          final cubit = context.read<LoginCubit>();
          await cubit.changeUsername(usernameController.text);
          await cubit.changePassword(passwordController.text);
          final user = await cubit.login();
          if (user != null) {
            context.read<SettingBloc>().add(UserChanged(user: user));
            Navigator.of(context).pushAndRemoveUntil(HomePage.route(), (route) => false);
          }
        },
        text: '确认',
      ),
    ];
  }
}

class UsernameTextField extends StatelessWidget {
  const UsernameTextField({
    Key? key,
    required this.controller,
    required this.node,
  }) : super(key: key);

  final TextEditingController controller;
  final FocusNode node;

  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLength: 40,
      focusNode: node,
      controller: controller,
      keyboardType: TextInputType.url,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: 16.0),
        hintText: '请输入用户名',
        counterText: '',
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).primaryColor,
            width: 0.8,
          ),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).dividerTheme.color!,
            width: 0.8,
          ),
        ),
      ),
    );
  }
}

class PasswordTextField extends StatelessWidget {
  const PasswordTextField({
    Key? key,
    required this.controller,
    required this.node,
  }) : super(key: key);

  final TextEditingController controller;
  final FocusNode node;

  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLength: 40,
      obscureText: true,
      focusNode: node,
      controller: controller,
      keyboardType: TextInputType.visiblePassword,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: 16.0),
        hintText: '请输入密码',
        counterText: '',
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).primaryColor,
            width: 0.8,
          ),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).dividerTheme.color!,
            width: 0.8,
          ),
        ),
      ),
    );
  }
}

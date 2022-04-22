import 'package:design/design.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:movie_app/actor/actor.dart';
import 'package:movie_app/gen/assets.gen.dart';
import 'package:movie_app/movie/movie.dart';
import 'package:movie_app/my/my.dart';
import 'package:movie_app/worker/worker.dart';
import 'package:share_widgets/share_widgets.dart';
import 'package:utils/util.dart';

import '../cubit/home_cubit.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const HomePage());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeCubit(),
      child: const HomeView(),
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tabIndex = context.select((HomeCubit cubit) => cubit.state.tabIndex);
    return DoubleTapBackExitApp(
      child: Scaffold(
        body: IndexedStack(
          index: tabIndex,
          children: const [
            WorkerPage(),
            MoviePage(),
            ActorPage(),
            MyPage(),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: context.backgroundColor,
          items: [
            _buildBottomNavigationBarItem(
              AppLocalizations.of(context).worker,
              Assets.images.home.iconOrder,
              context.isDark,
            ),
            _buildBottomNavigationBarItem(
              AppLocalizations.of(context).movie,
              Assets.images.home.iconCommodity,
              context.isDark,
            ),
            _buildBottomNavigationBarItem(
              AppLocalizations.of(context).actor,
              Assets.images.home.iconStatistics,
              context.isDark,
            ),
            _buildBottomNavigationBarItem(
              AppLocalizations.of(context).my,
              Assets.images.home.iconShop,
              context.isDark,
            ),
          ],
          type: BottomNavigationBarType.fixed,
          currentIndex: tabIndex,
          elevation: 5.0,
          iconSize: 21.0,
          selectedFontSize: Dimens.font_sp10,
          unselectedFontSize: Dimens.font_sp10,
          selectedItemColor: Theme.of(context).primaryColor,
          unselectedItemColor: context.isDark ? Colours.dark_unselected_item_color : Colours.unselected_item_color,
          onTap: (index) => context.read<HomeCubit>().setTab(index),
        ),
      ),
    );
  }

  BottomNavigationBarItem _buildBottomNavigationBarItem(String lable, AssetGenImage genImage, bool isDark) {
    return BottomNavigationBarItem(
      icon: genImage.image(width: 25, color: isDark ? null : Colours.unselected_item_color),
      activeIcon: genImage.image(width: 25, color: isDark ? Colours.dark_app_main : Colours.app_main),
      label: lable,
    );
  }
}

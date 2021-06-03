import 'package:flutter/material.dart';
import 'package:lab_movil_2222/src/pages/club_house_page.dart';
import 'package:lab_movil_2222/src/pages/goals_page.dart';
import 'package:lab_movil_2222/src/pages/account_page.dart';
import 'package:lab_movil_2222/src/pages/initial_page.dart';
import 'package:lab_movil_2222/src/pages/route_page.dart';
import 'package:lab_movil_2222/src/pages/statistics_page.dart';
import 'package:lab_movil_2222/src/providers/ui_bottomBar_provider.dart';
import 'package:lab_movil_2222/src/widgets/custom_navigation_bar.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: _HomePageBody(),
        // PageView(children: [
        //   _titlePage(),

        // ]),
        bottomNavigationBar: CustomNavigationBar(),
      ),
    );
  }
}

class _HomePageBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UIBottomBarProvider>(context);
    final currentIndex = uiProvider.selectedMenuOption;

    switch (currentIndex) {
      case 1:
        return InitialPage();
      case 2:
        return GoalsPage();
      case 3:
        return AccountPage();
      case 4:
        return ClubHousePage();
      case 5:
        return StatisticsPage();
      default:
        return HomePage();
    }
  }
}

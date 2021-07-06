import 'package:flutter/material.dart';
import 'package:lab_movil_2222/screens/cities.screen.dart';
import 'package:lab_movil_2222/screens/club_house.screen.dart';
import 'package:lab_movil_2222/screens/goals.screen.dart';
import 'package:lab_movil_2222/screens/profile.screen.dart';
import 'package:lab_movil_2222/screens/statistics.screen.dart';
import 'package:lab_movil_2222/themes/colors.dart';

enum NavigationBarPages {
  page1,
  page2,
  page3,
  page4,
  page5,
}

class CustomNavigationBar extends StatelessWidget {
  const CustomNavigationBar({
    this.activePage = NavigationBarPages.page1,
    this.nextPage,
    this.prevPage,
  });

  final NavigationBarPages activePage;

  final VoidCallback? nextPage;
  final VoidCallback? prevPage;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorsApp.backgroundBottomBar,
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: this.prevPage,
            child: Container(
              child: ImageIcon(
                AssetImage('assets/icons/left_arrow_icon.png'),
                color: this.prevPage == null
                    ? ColorsApp.backgroundBottomBar
                    : Colors.grey,
              ),
            ),
          ),
          GestureDetector(
            onTap: () =>
                Navigator.pushReplacementNamed(context, CitiesScreen.route),
            child: Container(
              child: ImageIcon(
                AssetImage('assets/icons/boat_icon.png'),
                color: this.activePage == NavigationBarPages.page1
                    ? Colors.white
                    : Colors.grey,
              ),
            ),
          ),
          GestureDetector(
            onTap: () => Navigator.pushNamed(context, GoalsScreen.route),
            child: Container(
              child: ImageIcon(
                AssetImage('assets/icons/goals_icon.png'),
                color: this.activePage == NavigationBarPages.page2
                    ? Colors.white
                    : Colors.grey,
              ),
            ),
          ),
          GestureDetector(
            onTap: () => Navigator.pushNamed(context, ProfileScreen.route),
            child: Container(
              child: ImageIcon(
                AssetImage('assets/icons/avatar_icon.png'),
                color: this.activePage == NavigationBarPages.page3
                    ? Colors.white
                    : Colors.grey,
              ),
            ),
          ),
          GestureDetector(
            onTap: () => Navigator.pushNamed(context, ClubHouseScreen.route),
            child: Container(
              child: ImageIcon(
                AssetImage('assets/icons/coffee_icon.png'),
                color: this.activePage == NavigationBarPages.page4
                    ? Colors.white
                    : Colors.grey,
              ),
            ),
          ),
          GestureDetector(
            onTap: () => Navigator.pushNamed(context, StatisticsScreen.route),
            child: Container(
              child: ImageIcon(
                AssetImage('assets/icons/stats_icon.png'),
                color: this.activePage == NavigationBarPages.page5
                    ? Colors.white
                    : Colors.grey,
              ),
            ),
          ),
          GestureDetector(
            onTap: this.nextPage,
            child: Container(
              child: ImageIcon(
                AssetImage('assets/icons/right_arrow_icon.png'),
                color: this.nextPage == null
                    ? ColorsApp.backgroundBottomBar
                    : Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );

  }
}

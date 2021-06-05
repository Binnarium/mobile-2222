import 'package:flutter/material.dart';

import 'package:lab_movil_2222/screens/account.screen.dart';
import 'package:lab_movil_2222/screens/club_house.screen.dart';
import 'package:lab_movil_2222/screens/goals.screen.dart';
import 'package:lab_movil_2222/screens/route.screen.dart';
import 'package:lab_movil_2222/screens/statistics.screen.dart';
import 'package:lab_movil_2222/themes/colors.dart';

class HomeScreen extends StatefulWidget {
  static const String route = '/';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentPage = 0;

  static List<Widget> _pages = <Widget>[
    RouteScreen(),
    GoalsScreen(),
    AccountScreen(),
    ClubHouseScreen(),
    StatisticsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages.elementAt(_currentPage),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (int index) {
          setState(() {
            _currentPage = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentPage,
        backgroundColor: ColorsApp.backgroundBottomBar,
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.white,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: [
          // BottomNavigationBarItem(
          //   icon: ImageIcon(
          //     AssetImage('assets/icons/left_arrow_icon.png'),
          //   ),
          //   label: "",
          // ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage('assets/icons/boat_icon.png'),
            ),
            label: "Ruta",
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage('assets/icons/goals_icon.png'),
            ),
            label: "Progreso",
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage('assets/icons/avatar_icon.png'),
            ),
            label: "Perfil",
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage('assets/icons/coffee_icon.png'),
            ),
            label: "Cafe",
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage('assets/icons/stats_icon.png'),
            ),
            label: "Stats",
          ),
          // BottomNavigationBarItem(
          //   icon: ImageIcon(
          //     AssetImage('assets/icons/right_arrow_icon.png'),
          //   ),
          //   label: "",
          // ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:lab_movil_2222/screens/club_house.screen.dart';
import 'package:lab_movil_2222/screens/goals.screen.dart';
import 'package:lab_movil_2222/screens/profile.screen.dart';
import 'package:lab_movil_2222/screens/route.screen.dart';
import 'package:lab_movil_2222/screens/statistics.screen.dart';
import 'package:lab_movil_2222/themes/colors.dart';

enum NavigationBarPages {
  page1,
  page2,
  page3,
  page4,
  page5,
}

const Map<NavigationBarPages, String> AppRoutes = {
  NavigationBarPages.page1: RouteScreen.route,
  NavigationBarPages.page2: GoalsScreen.route,
  NavigationBarPages.page3: ProfileScreen.route,
  NavigationBarPages.page4: ClubHouseScreen.route,
  NavigationBarPages.page5: StatisticsScreen.route,
};

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
    //Controla cuando se presione un botón
    void _onItemTapped(int value) {
      String tapped = AppRoutes.values.toList()[value];
      Navigator.pushReplacementNamed(context, tapped);
    }

    return BottomNavigationBar(
      onTap: _onItemTapped,
      type: BottomNavigationBarType.fixed,
      currentIndex: AppRoutes.keys.toList().indexOf(this.activePage),
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
    );
  }
}

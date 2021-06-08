import 'package:flutter/material.dart';
import 'package:lab_movil_2222/providers/ui_bottomBar_provider.dart';
import 'package:lab_movil_2222/screens/account.screen.dart';
import 'package:lab_movil_2222/screens/club_house.screen.dart';
import 'package:lab_movil_2222/screens/goals.screen.dart';
import 'package:lab_movil_2222/screens/route.screen.dart';
import 'package:lab_movil_2222/screens/statistics.screen.dart';
import 'package:lab_movil_2222/themes/colors.dart';
import 'package:provider/provider.dart';

class CustomNavigationBar extends StatefulWidget {
  //BottomBar que va en todas las pantallas

  @override
  _CustomNavigationBarState createState() => _CustomNavigationBarState();
}

class _CustomNavigationBarState extends State<CustomNavigationBar> {
  static List<Widget> pages = <Widget>[
    RouteScreen(),
    GoalsScreen(),
    AccountScreen(),
    ClubHouseScreen(),
    StatisticsScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UIBottomBarProvider>(context);
    final currentIndex = uiProvider.selectedMenuOption;
    //Controla cuando se presione un botón
    void _onItemTapped(int value) {
      setState(() {
        uiProvider.selectedMenuOption = value;
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) {
          return pages.elementAt(value);
        }));
      });
    }

    return BottomNavigationBar(
      onTap: _onItemTapped,
      type: BottomNavigationBarType.fixed,
      currentIndex: currentIndex,
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

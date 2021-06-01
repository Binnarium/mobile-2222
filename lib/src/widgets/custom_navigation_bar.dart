import 'package:flutter/material.dart';
import 'package:lab_movil_2222/src/providers/ui_bottomBar_provider.dart';
import 'package:provider/provider.dart';

class CustomNavigationBar extends StatelessWidget {
  //BottomBar que va en todas las pantallas

  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UIBottomBarProvider>(context);
    final currentIndex = uiProvider.selectedMenuOption;

    return BottomNavigationBar(
      onTap: (int i) => uiProvider.selectedMenuOption = i,
      type: BottomNavigationBarType.fixed,
      currentIndex: currentIndex,
      backgroundColor: Color(0xff242B30),
      unselectedItemColor: Colors.grey,
      selectedItemColor: Colors.white,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      items: [
        BottomNavigationBarItem(
          icon: ImageIcon(
            AssetImage('assets/icons/left_arrow_icon.png'),
          ),
          label: "Ruta",
        ),
        BottomNavigationBarItem(
          icon: ImageIcon(
            AssetImage('assets/icons/boat_icon.png'),
          ),
          label: "Ruta",
        ),
        BottomNavigationBarItem(
          icon: ImageIcon(
            AssetImage('assets/icons/avatar_icon.png'),
          ),
          label: "Perfil",
        ),
        BottomNavigationBarItem(
          icon: ImageIcon(
            AssetImage('assets/icons/goals_icon.png'),
          ),
          label: "Progreso",
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
        BottomNavigationBarItem(
          icon: ImageIcon(
            AssetImage('assets/icons/right_arrow_icon.png'),
          ),
          label: "Ruta",
        ),
      ],
    );
  }
}

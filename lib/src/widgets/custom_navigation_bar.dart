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
      showSelectedLabels: true,
      showUnselectedLabels: false,
      items: [
        BottomNavigationBarItem(
          icon: Icon(
            Icons.directions_boat,
          ),
          label: "Ruta",
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.alt_route,
          ),
          label: "Progreso",
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.account_circle_outlined,
          ),
          label: "Perfil",
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.coffee_outlined,
          ),
          label: "Cafe",
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.graphic_eq_outlined,
          ),
          label: "Stats",
        ),
      ],
    );
  }
}

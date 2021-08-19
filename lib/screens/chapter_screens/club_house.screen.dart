import 'package:flutter/material.dart';
import 'package:lab_movil_2222/shared/widgets/custom-background.dart';
import 'package:lab_movil_2222/shared/widgets/custom_navigation_bar.dart';
import 'package:lab_movil_2222/themes/colors.dart';

class ClubHouseScreen extends StatelessWidget {
  static const String route = '/clubhouse';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          CustomBackground(backgroundColor: ColorsApp.backgroundRed),
          Center(
            child: Text('ClubHouse Page'),
          ),
        ],
      ),
      bottomNavigationBar: CustomNavigationBar(
        activePage: NavigationBarPages.page4,
      ),
    );
  }
}

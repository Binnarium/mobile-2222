import 'package:flutter/material.dart';
import 'package:lab_movil_2222/chat/ui/screens/list-chats.screen.dart';
import 'package:lab_movil_2222/player/ui/screens/profile.screen.dart';
import 'package:lab_movil_2222/screens/goals.screen.dart';
import 'package:lab_movil_2222/screens/home.screen.dart';
import 'package:lab_movil_2222/screens/welcome.screen.dart';
import 'package:lab_movil_2222/themes/colors.dart';

enum NavigationBarPages {
  page1,
  page2,
  page3,
  page4,
  chat,
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
    return Hero(
      tag: 'navbar',
      child: Container(
        color: Colors2222.black,
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GestureDetector(
              onTap: this.prevPage,
              child: Container(
                child: ImageIcon(
                  AssetImage('assets/icons/left_arrow_icon.png'),
                  color: this.prevPage == null ? Colors2222.black : Colors.grey,
                ),
              ),
            ),
            GestureDetector(
              onTap: () =>
                  Navigator.pushReplacementNamed(context, HomeScreen.route),
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
              onTap: () => Navigator.pushNamed(
                context,
                WelcomeScreen.route,
              ),
              child: Container(
                child: Icon(
                  Icons.info,
                  color: this.activePage == NavigationBarPages.page4
                      ? Colors.white
                      : Colors.grey,
                ),
              ),
            ),

            /// chat button
            GestureDetector(
              onTap: () => Navigator.pushNamed(context, ListChatsScreen.route),
              child: Icon(
                Icons.message,
                color: this.activePage == NavigationBarPages.chat
                    ? Colors2222.white
                    : Colors2222.grey,
              ),
            ),

            /// next page button
            GestureDetector(
              onTap: this.nextPage,
              child: Container(
                child: ImageIcon(
                  AssetImage('assets/icons/right_arrow_icon.png'),
                  color: this.nextPage == null ? Colors2222.black : Colors.grey,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

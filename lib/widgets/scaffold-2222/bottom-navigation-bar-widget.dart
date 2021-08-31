import 'package:flutter/material.dart';
import 'package:lab_movil_2222/chat/ui/screens/list-chats.screen.dart';
import 'package:lab_movil_2222/player/ui/screens/profile.screen.dart';
import 'package:lab_movil_2222/screens/home.screen.dart';
import 'package:lab_movil_2222/screens/welcome.screen.dart';
import 'package:lab_movil_2222/themes/colors.dart';
import 'package:lab_movil_2222/widgets/scaffold-2222/bottom-navigation-bar-item.widget.dart';

enum Lab2222NavigationBarPages {
  home,
  profile,
  information,
  chat,
}

class Lab2222BottomNavigationBar extends StatelessWidget {
  const Lab2222BottomNavigationBar({
    this.activePage = Lab2222NavigationBarPages.home,
    this.nextPage,
    this.prevPage,
  });

  final Lab2222NavigationBarPages activePage;

  final VoidCallback? nextPage;
  final VoidCallback? prevPage;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'navbar',
      child: Container(
        color: Colors2222.black,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Lab2222BottomNavigationBarItem>[
            Lab2222BottomNavigationBarItem(
              onTap: prevPage,
              icon: AssetImage('assets/navbar/chevron-left.png'),
            ),
            Lab2222BottomNavigationBarItem(
              onTap: () =>
                  Navigator.pushReplacementNamed(context, HomeScreen.route),
              icon: AssetImage('assets/navbar/boat.png'),
              active: this.activePage == Lab2222NavigationBarPages.home,
            ),
            Lab2222BottomNavigationBarItem(
              onTap: () => Navigator.pushNamed(context, ProfileScreen.route),
              icon: AssetImage('assets/navbar/user.png'),
              active: this.activePage == Lab2222NavigationBarPages.profile,
            ),
            Lab2222BottomNavigationBarItem(
              onTap: () => Navigator.pushNamed(context, WelcomeScreen.route),
              icon: AssetImage('assets/navbar/info.png'),
              active: this.activePage == Lab2222NavigationBarPages.information,
            ),
            Lab2222BottomNavigationBarItem(
              onTap: () => Navigator.pushNamed(context, ListChatsScreen.route),
              icon: AssetImage('assets/navbar/message-square.png'),
              active: this.activePage == Lab2222NavigationBarPages.chat,
            ),
            Lab2222BottomNavigationBarItem(
              onTap: this.nextPage,
              icon: AssetImage('assets/navbar/chevron-right.png'),
            ),
          ],
        ),
      ),
    );
  }
}

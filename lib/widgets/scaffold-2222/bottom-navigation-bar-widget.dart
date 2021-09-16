import 'package:flutter/material.dart';
import 'package:lab_movil_2222/chat/ui/screens/chats.screen.dart';
import 'package:lab_movil_2222/city/ui/screen/home.screen.dart';
import 'package:lab_movil_2222/player/ui/screens/profile.screen.dart';
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
    Key? key,
    this.activePage = Lab2222NavigationBarPages.home,
    this.nextPage,
    this.prevPage,
  }) : super(key: key);

  final Lab2222NavigationBarPages? activePage;

  final VoidCallback? nextPage;
  final VoidCallback? prevPage;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'navbar',
      child: Container(
        color: Colors2222.black,
        child: SafeArea(
          bottom: true,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Lab2222BottomNavigationBarItem>[
              /// prev page item
              Lab2222BottomNavigationBarItem(
                onTap: prevPage,
                icon: AssetImage('assets/navbar/chevron-left.png'),
                active: true,
              ),

              /// home item
              Lab2222BottomNavigationBarItem(
                onTap: activePage == Lab2222NavigationBarPages.home
                    ? () {}
                    : () => Navigator.pushReplacementNamed(
                        context, HomeScreen.route),
                icon: AssetImage('assets/navbar/boat.png'),
                active: activePage == Lab2222NavigationBarPages.home,
              ),

              /// profile item
              Lab2222BottomNavigationBarItem(
                onTap: activePage == Lab2222NavigationBarPages.profile
                    ? () {}
                    : () => Navigator.pushNamed(context, ProfileScreen.route),
                icon: AssetImage('assets/navbar/user.png'),
                active: activePage == Lab2222NavigationBarPages.profile,
              ),

              /// information item
              Lab2222BottomNavigationBarItem(
                onTap: activePage == Lab2222NavigationBarPages.information
                    ? () {}
                    : () => Navigator.pushNamed(context, WelcomeScreen.route),
                icon: AssetImage('assets/navbar/info.png'),
                active: activePage == Lab2222NavigationBarPages.information,
              ),

              /// chat item
              Lab2222BottomNavigationBarItem(
                onTap: activePage == Lab2222NavigationBarPages.chat
                    ? () {}
                    : () => Navigator.pushNamed(context, ChatsScreen.route),
                icon: AssetImage('assets/navbar/message-square.png'),
                active: activePage == Lab2222NavigationBarPages.chat,
              ),

              /// text page item
              Lab2222BottomNavigationBarItem(
                onTap: nextPage,
                icon: AssetImage('assets/navbar/chevron-right.png'),
                active: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

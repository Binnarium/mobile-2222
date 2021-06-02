import 'package:flutter/material.dart';
import 'package:lab_movil_2222/src/pages/introduction1_page.dart';
import 'package:lab_movil_2222/src/pages/login_page.dart';
import 'package:lab_movil_2222/src/widgets/custom_navigation_bar.dart';

class InitialPage extends StatefulWidget {
  @override
  _InitialPageState createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children: [
          IntroductionPage(),
          LoginPage(),
        ],
      ),
      bottomNavigationBar: CustomNavigationBar(),
    );
  }
}

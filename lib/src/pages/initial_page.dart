import 'package:flutter/material.dart';
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
          //TODO: Aquí poner la primera página
          Center(
            child: Text(
              "Introduction Page (Jossue)",
              style: Theme.of(context)
                  .textTheme
                  .headline5
                  ?.apply(color: Colors.black),
            ),
          ),
          LoginPage(),
        ],
      ),
      bottomNavigationBar: CustomNavigationBar(),
    );
  }
}

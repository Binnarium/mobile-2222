import 'package:flutter/material.dart';
import 'package:lab_movil_2222/src/widgets/custom_navigation_bar.dart';

class InitialPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Initial Page'),
      ),
      bottomNavigationBar: CustomNavigationBar(),
    );
  }
}

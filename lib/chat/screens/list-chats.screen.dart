import 'package:flutter/material.dart';
import 'package:lab_movil_2222/themes/colors.dart';

class ListChatsScreen extends StatelessWidget {
  static const route = "/list-chats";

  const ListChatsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: Colors2222.primary,
      appBar: AppBar(
        title: Text(
          'Comunidades 2222',
          style: textTheme.subtitle1,
        ),
      ),
      body: ListView(
        padding:
            EdgeInsets.symmetric(horizontal: size.width * 0.08, vertical: 64),
        children: [
          ///
        ],
      ),
    );
  }
}

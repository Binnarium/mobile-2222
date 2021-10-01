import 'package:flutter/material.dart';
import 'package:lab_movil_2222/chat/ui/screens/generalChats.screen.dart';
import 'package:lab_movil_2222/chat/ui/screens/groupChats.screen.dart';
import 'package:lab_movil_2222/chat/ui/screens/personalChats.screen.dart';
import 'package:lab_movil_2222/themes/colors.dart';


class ListFolderChat extends StatelessWidget {
  /// constructor
  const ListFolderChat({
    Key? key,
    required this.route,
  }) : super(key: key);

  /// Name of social network
  final String route;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final Size size = MediaQuery.of(context).size;
    final double sidePadding = size.width * 0.08;
    

    return Padding(
        padding: EdgeInsets.fromLTRB(sidePadding, 15, sidePadding, 20),
        child: Material(
          animationDuration: const Duration(seconds: 1),
          color: Colors2222.white,
          type: MaterialType.transparency,
          child: InkWell(
            onTap: () {
              if (route == 'Personal') {
                Navigator.pushNamed(context, PersonalChatsScreen.route);
              } else if (route == 'General') {
                Navigator.pushNamed(context, GeneralChatsScreen.route);
              } else {
                Navigator.pushNamed(context, GroupChatsScreen.route);
              }
            },
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(
                  Icons.folder_shared_rounded,
                  size: 45,
                ),
                Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      'Chat $route',
                      style: textTheme.headline5,
                      textAlign: TextAlign.center,
                    ))
              ],
            ),
          ),
        ));
  }
}

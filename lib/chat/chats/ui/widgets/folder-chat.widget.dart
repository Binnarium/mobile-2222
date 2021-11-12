import 'package:flutter/material.dart';
import 'package:lab_movil_2222/chat/chats/models/chat-kind.enum.dart';
import 'package:lab_movil_2222/chat/chats/ui/screens/personal-chats.screen.dart';
import 'package:lab_movil_2222/chat/ui/widgets/chat-image.widget.dart';
import 'package:lab_movil_2222/themes/colors.dart';

class ListFolderChat extends StatelessWidget {
  /// constructor
  const ListFolderChat({
    Key? key,
    required this.route,
    this.type = 'Personal',
  }) : super(key: key);

  /// Name of social network
  final String route;
  final String type;
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
              if (route == type) {
                Navigator.pushNamed(context, PersonalChatsScreen.route);
              }
            },
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ChatImageWidget(
                  kind: ChatKind.personal,
                  size: 60,
                ),
                Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      'Otros Viajeros',
                      style: textTheme.bodyText1,
                      textAlign: TextAlign.center,
                    ))
              ],
            ),
          ),
        ));
  }
}

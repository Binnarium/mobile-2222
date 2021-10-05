import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lab_movil_2222/chat/chats/models/chat.model.dart';
import 'package:lab_movil_2222/chat/ui/screens/chat-participants.screen.dart';
import 'package:lab_movil_2222/chat/ui/widgets/message-list.widget.dart';
import 'package:lab_movil_2222/chat/ui/widgets/messages-input.dart';
import 'package:lab_movil_2222/themes/colors.dart';
import 'package:lab_movil_2222/widgets/scaffold-2222/scaffold-2222.widget.dart';

class MessagesScreen extends StatefulWidget {
  /// constructor
  const MessagesScreen({
    Key? key,
    required ChatModel chat,
  })  : chat = chat,
        super(key: key);

  /// params
  static const route = '/messages';
  final ChatModel chat;

  @override
  _MessagesScreenState createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final Size size = MediaQuery.of(context).size;

    return Scaffold2222.empty(
      backgroundColor: Colors2222.white,

      /// app bar with back button and direct access to information
      appBar: AppBar(
        backgroundColor: Colors2222.primary,
        titleSpacing: 0,
        title: Text(
          widget.chat.chatName,
          style: textTheme.subtitle1!.copyWith(
            color: Colors2222.white,
          ),
        ),
        actions: <IconButton>[
          IconButton(
            icon: const Icon(Icons.people),
            onPressed: () => Navigator.pushNamed(
              context,
              ChatParticipantsScreen.route,
              arguments: ChatParticipantsScreen(
                chat: widget.chat,
              ),
            ),
          ),
        ],
      ),

      /// page content
      ///
      /// contains message list and message sender
      body: Column(
        children: [
          /// sended messages
          /// take all available spaces
          Expanded(
            child: MessagesList(
              chatModel: widget.chat,
            ),
          ),

          /// send text area
          /// TODO: fix use the service instead of direct access to firebaseAuth
          if (widget.chat.participants
                  .firstWhere((element) =>
                      element.uid == FirebaseAuth.instance.currentUser?.uid)
                  .canSendMessage ==
              true)
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.04,
                vertical: 12,
              ),
              child: MessageTextInput(
                chat: widget.chat,
              ),
            ),
        ],
      ),
    );
  }
}

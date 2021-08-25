import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lab_movil_2222/chat/models/chat.model.dart';
import 'package:lab_movil_2222/chat/screens/chat.screen.dart';
import 'package:lab_movil_2222/shared/widgets/app-loading.widget.dart';
import 'package:lab_movil_2222/shared/widgets/chapter-head-banner_widget.dart';
import 'package:lab_movil_2222/shared/widgets/custom_navigation_bar.dart';
import 'package:lab_movil_2222/themes/colors.dart';

class ListChatsScreen extends StatefulWidget {
  static const route = "/list-chats";

  final Stream<List<ChatModel>> userChats;

  ListChatsScreen({Key? key})
      : this.userChats = FirebaseFirestore.instance
            .collection('chats')
            .snapshots()
            .map((event) =>
                event.docs.map((e) => ChatModel.fromMap(e.data())).toList()),
        super(key: key);

  @override
  _ListChatsScreenState createState() => _ListChatsScreenState();
}

class _ListChatsScreenState extends State<ListChatsScreen> {
  StreamSubscription? _chatsSub;
  List<ChatModel>? chats;
  @override
  void initState() {
    super.initState();
    _chatsSub = this
        .widget
        .userChats
        .listen((event) => this.setState(() => this.chats = event));
  }

  @override
  void dispose() {
    this._chatsSub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      bottomNavigationBar: CustomNavigationBar(
        activePage: NavigationBarPages.chat,
      ),
      backgroundColor: Colors2222.primary,
      // appBar: AppBar(
      //   title: Text(
      //     'Comunidades 2222',
      //     style: textTheme.subtitle1,
      //   ),
      // ),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 10),
            child: ChapterHeadWidget(
              showAppLogo: true,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 40),
            child: Center(
                child: Text('EL CHAT DE 2222',
                    style: textTheme.headline6!.apply(fontSizeFactor: 1.3))),
          ),
          _searchField(size),

          /// if no chats loaded show loading icon
          if (this.chats == null)
            AppLoading()

          /// show a list of all chats
          else
            for (ChatModel chat in this.chats!)
              ListTile(
                ///TODO implementar esta linea cuando funcione lastMessage
                /// trailing: Text('${chat.lastMessage!.sendedDate}'),
                trailing: Text('16:50'),
                leading: CircleAvatar(
                  backgroundImage: AssetImage('assets/icons/avatar_icon.png'),
                ),
                title: Text('${chat.participantsNames}'),
                subtitle: Text(
                  chat.participantsNames,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                onTap: () => Navigator.of(context).pushNamed(
                  ChatScreen.route,
                  arguments: ChatScreen(
                    chat: chat,
                  ),
                ),
              ),
        ],
      ),
    );
  }
}

_searchField(size) {
  return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: size.width * 0.08,
        vertical: 16,
      ),
      child: Row(
        children: [
          /// text input
          Expanded(
            child: TextField(
              textAlignVertical: TextAlignVertical.center,
              cursorColor: Colors2222.black,
              style: TextStyle(color: Colors2222.black),

              decoration: InputDecoration(

                  ///Search Button
                  suffixIcon: IconButton(
                    color: Colors2222.grey,
                    icon: Icon(Icons.search),
                    onPressed: () => 0,
                  ),
                  hintText: 'BUSCAR CONTACTOS',
                  hintStyle: TextStyle(color: Colors2222.grey),
                  fillColor: Colors2222.white,
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors2222.black))),
              // controller: this.widget.myController,
              // onSubmitted: (_) => _sendTextMessage,
            ),
          ),
        ],
      ));
}

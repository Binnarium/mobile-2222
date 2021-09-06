import 'package:flutter/material.dart';
import 'package:lab_movil_2222/assets/video/ui/widgets/video-player.widget.dart';
import 'package:lab_movil_2222/chat/models/message.model.dart';
import 'package:lab_movil_2222/models/asset.dto.dart';

class DetailedMultimediaScreen extends StatefulWidget {
  static const String route = '/detailed-multimedia';
  final MessageModel message;
  const DetailedMultimediaScreen({
    Key? key,
    required MessageModel message,
  })  : this.message = message,
        super(key: key);

  @override
  _DetailedMultimediaScreenState createState() =>
      _DetailedMultimediaScreenState();
}

class _DetailedMultimediaScreenState extends State<DetailedMultimediaScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: (this.widget.message.kind == "MESSAGE#VIDEO")
            ? VideoPlayer(
                video: this.widget.message.asset as VideoDto,
              )
            : Center(child: Image.network(this.widget.message.asset!.url)),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:lab_movil_2222/assets/video/ui/widgets/video-player.widget.dart';
import 'package:lab_movil_2222/chat/models/message.model.dart';
import 'package:lab_movil_2222/models/asset.dto.dart';

class DetailedMultimediaScreen extends StatefulWidget {
  /// constructor
  const DetailedMultimediaScreen({
    Key? key,
    required MessageModel message,
  })  : message = message,
        super(key: key);

  /// params
  static const String route = '/detailed-multimedia';
  final MessageModel message;

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
        child: (widget.message.kind == 'MESSAGE#VIDEO')
            ? VideoPlayer(
                video: widget.message.asset! as VideoDto,
              )
            : Center(child: Image.network(widget.message.asset!.url)),
      ),
    );
  }
}

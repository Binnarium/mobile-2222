import 'package:flutter/material.dart';
import 'package:lab_movil_2222/assets/video/ui/widgets/video-player.widget.dart';
import 'package:lab_movil_2222/models/asset.dto.dart';

class DetailedMultimediaScreen extends StatefulWidget {
  /// constructor
  const DetailedMultimediaScreen({
    Key? key,
    required AssetDto multimedia,
    required bool isVideo,
  })  : multimedia = multimedia,
        isVideo = isVideo,
        super(key: key);

  /// params
  static const String route = '/detailed-multimedia';
  final AssetDto multimedia;
  final bool isVideo;

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
        child: widget.isVideo
            ? VideoPlayer(
                video: widget.multimedia as VideoDto,
              )
            : Center(child: Image.network(widget.multimedia.url)),
      ),
    );
  }
}

import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lab_movil_2222/models/asset.dto.dart';
import 'package:lab_movil_2222/widgets/scaffold-2222/scaffold-2222.widget.dart';

class DetailedMultimediaScreen extends StatefulWidget {
  /// constructor
  DetailedMultimediaScreen({
    Key? key,
    required this.multimedia,
  })  : isVideo = multimedia.runtimeType == VideoDto,
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
    return Scaffold2222.empty(
      backgroundColor: Colors.black,
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            Positioned(
              left: 10,
              top: 10,
              child: IconButton(
                icon: const Icon(Icons.close_rounded),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            Positioned.fill(
              child: widget.isVideo
                  ? _Lab2222BetterPlayer(
                      video: widget.multimedia as VideoDto,
                    )
                  : Center(child: Image.network(widget.multimedia.url)),
            ),
          ],
        ),
      ),
    );
  }
}

class _Lab2222BetterPlayer extends BetterPlayer {
  _Lab2222BetterPlayer({
    Key? key,
    required VideoDto video,
  }) : super(
          key: key,
          controller: BetterPlayerController(
            const BetterPlayerConfiguration(
              fit: BoxFit.contain,
              autoPlay: false,
              allowedScreenSleep: false,
              looping: false,
              deviceOrientationsAfterFullScreen: [
                DeviceOrientation.portraitUp,
              ],
              autoDispose: true,
            ),
            betterPlayerDataSource: BetterPlayerDataSource.network(video.url),
          )..play(),
        );
}

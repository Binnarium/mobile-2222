import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lab_movil_2222/chat/ui/screens/detailed-multimedia.screen.dart';
import 'package:lab_movil_2222/models/asset.dto.dart';
import 'package:lab_movil_2222/themes/colors.dart';
import 'package:url_launcher/url_launcher.dart';

/// Class that creates a video player depending on video URL and the description
/// of the video
class VideoPlayer extends StatefulWidget {
  const VideoPlayer({
    Key? key,

    /// videoDTO
    required this.video,
  }) : super(key: key);

  final VideoDto video;

  @override
  _VideoPlayerState createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<VideoPlayer> {
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        // child: _Lab2222BetterPlayer(video: widget.video)
        child: Stack(
          children: [
            Image(
              image: widget.video.placeholderImage,
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
            const Center(
              child: Icon(
                Icons.play_arrow_rounded,
                size: 150,
                color: Colors.black54,
              ),
            ),

            /// button action
            Positioned.fill(
              child: Material(
                color: Colors2222.transparent,
                child: InkWell(
                  onTap: () => (kIsWeb)
                      ? launch(widget.video.url)
                      : Navigator.push<MaterialPageRoute>(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailedMultimediaScreen(
                              multimedia: widget.video,
                            ),
                          ),
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

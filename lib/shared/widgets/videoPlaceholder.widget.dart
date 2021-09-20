import 'package:flutter/material.dart';
import 'package:lab_movil_2222/chat/ui/screens/detailed-multimedia.screen.dart';
import 'package:lab_movil_2222/models/asset.dto.dart';
import 'package:lab_movil_2222/themes/colors.dart';

class VideoPlaceholderWidget extends StatelessWidget {
  const VideoPlaceholderWidget({
    Key? key,
    required this.video,
  }) : super(key: key);

  final VideoDto video;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Stack(
        children: [
          Image(
            image: video.placeholderImage,
            fit: BoxFit.cover,
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
                onTap: () => Navigator.push<MaterialPageRoute>(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DetailedMultimediaScreen(
                              isVideo: true,
                              multimedia: video,
                            ))),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

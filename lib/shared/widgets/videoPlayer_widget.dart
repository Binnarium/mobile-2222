import 'package:flutter/material.dart';
import 'package:lab_movil_2222/services/Video_settings.dart';
import 'package:lab_movil_2222/themes/textTheme.dart';

/// Class that creates a video player depending on video URL and the description of the video
class VideoPlayerSegment extends StatefulWidget {
  final String? videoUrl;
  final Color color;
  final String? description;
  VideoPlayerSegment(
      {Key? key, this.videoUrl, this.description, required this.color})
      : super(key: key);

  @override
  _VideoPlayerSegment createState() => _VideoPlayerSegment();
}

class _VideoPlayerSegment extends State<VideoPlayerSegment> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    if (this.widget.videoUrl == null) {
      return Text("Video link not available");
    }
    return _videoContent(size, this.widget.description, this.widget.videoUrl!);
  }

  _videoContent(Size size, String? description, String url) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.1, vertical: 30),
      child: Column(
        children: [
          _textContent(size, description),
          VideoDisplay(
              color: this.widget.color, videoUrl: this.widget.videoUrl!),
          SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }

  _textContent(Size size, String? description) {
    return Container(
      padding: EdgeInsets.only(bottom: 30),
      child: Text(
        (description == null) ? '' : description,
        style: korolevFont.bodyText1?.apply(),
      ),
    );
  }
}

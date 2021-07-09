import 'package:audio_session/audio_session.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:lab_movil_2222/screens/chapter_screens/resources.screen.dart';
import 'package:lab_movil_2222/shared/models/FirebaseChapterSettings.model.dart';
import 'package:lab_movil_2222/shared/models/VideoPodcast.model.dart';
import 'package:lab_movil_2222/shared/widgets/chapter-head-banner_widget.dart';
import 'package:lab_movil_2222/shared/widgets/chapter_background_widget.dart';
import 'package:lab_movil_2222/shared/widgets/custom_navigation_bar.dart';
import 'package:lab_movil_2222/themes/textTheme.dart';
import 'package:video_player/video_player.dart';

class ContentScreen extends StatefulWidget {
  static const String route = '/video';
  final FirebaseChapterSettings chapterSettings;

  const ContentScreen({Key? key, required this.chapterSettings})
      : super(key: key);

  @override
  _ContentScreenState createState() => _ContentScreenState();
}

class _ContentScreenState extends State<ContentScreen> {
  @override
  Widget build(BuildContext context) {
    VoidCallback prevPage = () => Navigator.pop(context);
    VoidCallback nextPage = () {
      Navigator.pushNamed(
        context,
        ResourcesScreen.route,
        arguments: ResourcesScreen(
          chapterSettings: this.widget.chapterSettings,
        ),
      );
    };

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: GestureDetector(
          ///To make the horizontal scroll to the next or previous page.
          onPanUpdate: (details) {
            /// left
            if (details.delta.dx > 5) prevPage();

            /// right
            if (details.delta.dx < -5) nextPage();
          },
          child: Stack(
            children: [
              ChapterBackgroundWidget(
                backgroundColor: Color(widget.chapterSettings.primaryColor),
                reliefPosition: 'top-left',
              ),

              /// calls the method who brings the whole firestore query (List<Widget>)
              _stageVideoContent(size, context),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomNavigationBar(
        nextPage: nextPage,
        prevPage: prevPage,
      ),
    );
  }

  _stageVideoContent(Size size, BuildContext context) {
    ///sizing the container to the mobile
    return Container(
      /// builds an initial Listview with the banner at first element
      child: ListView(
        children: [
          ///calls the head of the chapter (logo leaf, banner)
          ChapterHeadWidget(
            chapterName: this.widget.chapterSettings.cityName,
            phaseName: this.widget.chapterSettings.phaseName,
            chapterImgURL: this.widget.chapterSettings.chapterImageUrl,
          ),
          SizedBox(height: 20),

          /// method that makes the query from firestore who brings the whole content
          _pageContent(size),
        ],
      ),
    );
  }

  /// method that returns List<Widget> from firestore depending on content (video, podcast)
  _pageContent(Size size) {
    return FutureBuilder(
        future: _readContents(),
        builder: (BuildContext context,
            AsyncSnapshot<List<VideoPodcastModel>> contents) {
          if (contents.hasError) {
            return Text(contents.error.toString());
          }

          if (contents.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                valueColor: new AlwaysStoppedAnimation<Color>(
                  Colors.white,
                ),
              ),
            );
          }
          List<Widget> contentsTemp = [];

          /// for that builds a specific widget depending on his kind
          for (VideoPodcastModel content in contents.data!) {
            /// if kind == video then returns a video container
            if (content.kind.compareTo("CONTENT#VIDEO") == 0) {
              contentsTemp.add(SizedBox(height: 30));
              contentsTemp
                  .add(_titleContainer(size, content.author, content.title));
              final video = _VideoPlayerSegment(
                videoUrl: content.url,
                description: content.description,
                color: Color(widget.chapterSettings.primaryColor),
              );
              contentsTemp.add(video);
              contentsTemp.add(SizedBox(height: 30));              

              /// if kind == podcast then returns an audio container
            } else if (content.kind.compareTo("CONTENT#PODCAST") == 0) {
              contentsTemp
                  .add(_titleContainer(size, content.author, content.title));
              contentsTemp.add(SizedBox(height: 30));
              contentsTemp.add(_PodcastAudioPlayer(
                audioUrl: content.url,
              ));
              contentsTemp.add(SizedBox(height: 30));
            }
          }
          return Column(
            children: contentsTemp,
          );
        });
  }

  _titleContainer(Size size, String? author, String? title) {
    return UnconstrainedBox(
      child: Container(
        color: Colors.white,
        width: size.width,
        padding:
            EdgeInsets.symmetric(horizontal: size.width * 0.1, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              (author == null) ? '' : author.toUpperCase(),
              style: korolevFont.headline5
                  ?.apply(color: Colors.black, fontSizeFactor: 0.7),
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              (title == null) ? '' : title.toUpperCase(),
              style: korolevFont.headline6?.apply(
                color: Color(widget.chapterSettings.primaryColor),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<List<VideoPodcastModel>> _readContents() async {
    List<dynamic> data = [];
    List<VideoPodcastModel> contents = [];
    await FirebaseFirestore.instance
        .collection('cities')
        .doc(this.widget.chapterSettings.id)
        .collection('pages')
        .doc('content')
        .get()
        .then(
      (DocumentSnapshot documentSnapshot) {
        if (documentSnapshot.exists) {
          data = documentSnapshot.get('content');
          // print('contents temp : $data'.toString());
          for (var i = 0; i < data.length; i++) {
            final contentTemp = new VideoPodcastModel(
              duration: data[i]["duration"],
              path: data[i]["path"],
              kind: data[i]["kind"],
              author: data[i]?["author"],
              name: data[i]["name"],
              format: data[i]?["format"],
              description: data[i]?["description"],
              title: data[i]?["title"],
              url: data[i]["url"],
            );

            contents.add(contentTemp);
          }
        }
      },
    );
    return contents;
  }
}

/// Class that creates a video player depending on video URL and the description of the video
class _VideoPlayerSegment extends StatefulWidget {
  final String videoUrl;
  final Color color;
  final String? description;
  _VideoPlayerSegment(
      {Key? key, required this.videoUrl, this.description, required this.color})
      : super(key: key);

  @override
  __VideoPlayerSegment createState() => __VideoPlayerSegment();
}

class __VideoPlayerSegment extends State<_VideoPlayerSegment> {
  /// controller of the video
  late VideoPlayerController _controller;

  /// initialization of the videoplayer
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    /// initialization of the controller with the given url
    _controller = VideoPlayerController.network(this.widget.videoUrl);
    _initializeVideoPlayerFuture = _controller.initialize();
    super.initState();
  }

  @override
  void dispose() {
    /// dispose of the controller
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return _videoContent(size, this.widget.description, this.widget.videoUrl);
  }

  _videoContent(Size size, String? description, String url) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.1, vertical: 30),
      child: Column(
        children: [
          _textContent(size, description),
          SizedBox(
            height: 50,
          ),

          /// calls the video player
          _videoContainer(size, url),
          SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }

  _textContent(Size size, String? description) {
    return Text(
      (description == null) ? '' : description,
      style: korolevFont.bodyText1?.apply(),
    );
  }

  /// method that builds the video player, given the url
  _videoContainer(Size size, String url) {
    return FutureBuilder(
      future: _initializeVideoPlayerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          /// If VideoPlayerController has ended initialization, uses the data
          /// provided to limit the aspect ratio of the videoplayer
          return Container(
            /// to control the maxHeight of the video
            constraints: BoxConstraints(maxHeight: size.height * 0.35),

            /// the video player
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: <Widget>[
                VideoPlayer(_controller),
                _ControlsOverlay(controller: _controller),
                VideoProgressIndicator(
                  _controller,
                  allowScrubbing: true,
                  colors: VideoProgressColors(playedColor: Colors.white),
                ),
              ],
            ),
          );
        } else {
          // Si el VideoPlayerController todavía se está inicializando, muestra un
          // spinner de carga
          return Center(
              child: CircularProgressIndicator(
            valueColor: new AlwaysStoppedAnimation<Color>(
              Colors.white,
            ),
          ));
        }
      },
    );
  }
}

class _ControlsOverlay extends StatefulWidget {
  const _ControlsOverlay({Key? key, required this.controller})
      : super(key: key);

  static const _examplePlaybackRates = [
    0.5,
    1.0,
    1.5,
    2.0,
  ];

  final VideoPlayerController controller;

  @override
  __ControlsOverlayState createState() => __ControlsOverlayState();
}

class __ControlsOverlayState extends State<_ControlsOverlay> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        AnimatedSwitcher(
          duration: Duration(milliseconds: 200),
          reverseDuration: Duration(milliseconds: 400),
          switchInCurve: Curves.easeIn,
          child: widget.controller.value.isPlaying
              ? SizedBox.shrink()
              : Container(
                  color: Colors.black38,
                  child: Center(
                    child: Icon(
                      Icons.play_arrow,
                      color: Colors.white,
                      size: 100.0,
                    ),
                  ),
                ),
        ),
        GestureDetector(
          onTap: () {
            if (widget.controller.value.position ==
                widget.controller.value.duration) {
              widget.controller.initialize();
              widget.controller.play();
              setState(() {});
            } else {
              widget.controller.value.isPlaying
                  ? widget.controller.pause()
                  : widget.controller.play();
              setState(() {});
            }
          },
        ),
        Align(
          alignment: Alignment.topRight,
          child: PopupMenuButton<double>(
            initialValue: widget.controller.value.playbackSpeed,
            tooltip: 'Playback speed',
            onSelected: (speed) {
              widget.controller.setPlaybackSpeed(speed);
              setState(() {});
            },
            itemBuilder: (context) {
              return [
                for (final speed in _ControlsOverlay._examplePlaybackRates)
                  PopupMenuItem(
                    value: speed,
                    textStyle: TextStyle(color: Colors.black),
                    child: Text('${speed}x'),
                  )
              ];
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(
                // Using less vertical padding as the text is also longer
                // horizontally, so it feels like it would need more spacing
                // horizontally (matching the aspect ratio of the video).
                vertical: 12,
                horizontal: 16,
              ),
              child: Text('${widget.controller.value.playbackSpeed}x'),
            ),
          ),
        ),
      ],
    );
  }
}

class _PodcastAudioPlayer extends StatefulWidget {
  final String audioUrl;
  _PodcastAudioPlayer({Key? key, required this.audioUrl}) : super(key: key);

  @override
  __PodcastAudioPlayerState createState() => __PodcastAudioPlayerState();
}

class __PodcastAudioPlayerState extends State<_PodcastAudioPlayer> {
  final AudioPlayer _player = AudioPlayer();

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    // Inform the operating system of our app's audio attributes etc.
    // We pick a reasonable default for an app that plays speech.
    final session = await AudioSession.instance;
    await session.configure(AudioSessionConfiguration.speech());
    // Listen to errors during playback.
    _player.playbackEventStream.listen((event) {},
        onError: (Object e, StackTrace stackTrace) {
      print('A stream error occurred: $e');
    });
    // Try to load audio from a source and catch any errors.
    try {
      await _player
          .setAudioSource(AudioSource.uri(Uri.parse(this.widget.audioUrl)));
    } catch (e) {
      print("Error loading audio source: $e");
    }
  }

  @override
  void dispose() {
    // Release decoders and buffers back to the operating system making them
    // available for other apps to use.
    _player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _podcastContainer();
  }

  _podcastContainer() {
    return Column(
      children: [
        Material(
            type: MaterialType.circle,
            color: Colors.transparent,
            child: InkResponse(
              onTap: () async {
                if (_player.playing) {
                  print("entró a pause");
                  if (_player.position >= _player.duration!) {
                    print("entro!!!!!!!!!!!!!");
                    _player.seek(Duration.zero);
                    _player.play();
                  } else {
                    _player.pause();
                  }
                } else {
                  print("entró a play");

                  _player.play();
                }
                print('duracion de audio: ${_player.duration}');
                print('player state: ${_player.position}');
              },
              child: Image(
                image: AssetImage('assets/icons/podcast_icon.png'),
              ),
            )),
        SizedBox(height: 20),
        Text(
          'Escucha el podcast',
          style: korolevFont.headline6?.apply(),
        )
      ],
    );
  }
}

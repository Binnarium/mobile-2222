import 'package:flutter/material.dart';
import 'package:lab_movil_2222/screens/chapter_screens/resources.screen.dart';
import 'package:lab_movil_2222/screens/chapter_screens/stageobjectives.screen.dart';
import 'package:lab_movil_2222/shared/models/FirebaseChapterSettings.model.dart';
import 'package:lab_movil_2222/shared/widgets/chapter-head-banner_widget.dart';
import 'package:lab_movil_2222/shared/widgets/chapter_background_widget.dart';
import 'package:lab_movil_2222/shared/widgets/custom_navigation_bar.dart';
import 'package:lab_movil_2222/themes/textTheme.dart';

class StageVideoScreen extends StatelessWidget {
  static const String route = '/video';
  final FirebaseChapterSettings chapterSettings;

  const StageVideoScreen({Key? key, required this.chapterSettings})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    VoidCallback prevPage = () => Navigator.pop(context);
    VoidCallback nextPage = () {
      Navigator.pushNamed(
        context,
        ResourcesScreen.route,
        arguments: ResourcesScreen(
          chapterSettings: this.chapterSettings,
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
                backgroundColor: Color(chapterSettings.primaryColor),
                reliefPosition: 'top-left',
              ),
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
      child: ListView(
        children: [
          ///calls the head of the chapter (logo leaf, banner)
          ChapterHeadWidget(
            chapterName: this.chapterSettings.cityName,
            phaseName: this.chapterSettings.phaseName,
            chapterImgURL: this.chapterSettings.chapterImageUrl,
          ),
          SizedBox(height: 20),
          _videoTitleContainer(size),
          _videoContent(size),
          _videoTitleContainer(size),
          SizedBox(height: 30),
          _podcastContainer(),
          SizedBox(height: 30),
        ],
      ),
    );
  }

  _videoTitleContainer(Size size) {
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
              'Nombre Autor Video'.toUpperCase(),
              style: korolevFont.headline5
                  ?.apply(color: Colors.black, fontSizeFactor: 0.7),
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'TÍTULO DEL VIDEO LOREM IPSUM SIT AM CONSEQUTETUR'.toUpperCase(),
              style: korolevFont.headline6?.apply(
                color: Color(chapterSettings.primaryColor),
              ),
              // maxLines: 2,
              // overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  _videoContent(Size size) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.1, vertical: 30),
      child: Column(
        children: [
          _textContent(size),
          SizedBox(
            height: 50,
          ),
          _videoContainer(),
          SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }

  _textContent(Size size) {
    return Text(
      'Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto\n\n\nSed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto',
      style: korolevFont.bodyText1?.apply(),
    );
  }

  _videoContainer() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: FadeInImage(
        placeholder: AssetImage('assets/gifs/giphy.gif'),
        image: NetworkImage(
            "http://altsolutions.es/wp-content/uploads/2017/02/alt-solutions-subida-de-videos-en-youtube.jpg"),
      ),
    );
  }

  _podcastContainer() {
    return Column(
      children: [
        Material(
            type: MaterialType.circle,
            color: Colors.transparent,
            child: InkResponse(
              onTap: () {
                print('podcast icon pressed');
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

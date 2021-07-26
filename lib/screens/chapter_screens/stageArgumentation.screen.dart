import 'package:flutter/material.dart';
import 'package:lab_movil_2222/screens/chapter_screens/stageobjectives.screen.dart';
import 'package:lab_movil_2222/services/i-load-with-options.service.dart';
import 'package:lab_movil_2222/services/load-arguments-screen-information.service.dart';
import 'package:lab_movil_2222/shared/models/FirebaseChapterSettings.model.dart';
import 'package:lab_movil_2222/shared/widgets/chapter-head-banner_widget.dart';
import 'package:lab_movil_2222/shared/widgets/chapter_background_widget.dart';
import 'package:lab_movil_2222/shared/widgets/custom_navigation_bar.dart';
import 'package:lab_movil_2222/shared/widgets/idea_container_widget.dart';
import 'package:lab_movil_2222/themes/colors.dart';

class StageArgumentationScreen extends StatefulWidget {
  static const String route = '/argumentation';

  final FirebaseChapterSettings chapterSettings;

  const StageArgumentationScreen({
    Key? key,
    required this.chapterSettings,
  }) : super(key: key);

  @override
  _StageArgumentationScreenState createState() =>
      _StageArgumentationScreenState();
}

class _StageArgumentationScreenState extends State<StageArgumentationScreen> {
  List<String>? questions;

  @override
  void initState() {
    super.initState();
    ILoadInformationWithOptions<List<String>, FirebaseChapterSettings> loader =
        LoadArgumentScreenInformationService(
      chapterSettings: this.widget.chapterSettings,
    );
    loader.load().then((value) => this.setState(() => questions = value));
  }

  @override
  Widget build(BuildContext context) {
    VoidCallback prevPage = () => Navigator.pop(context);
    VoidCallback nextPage = () {
      Navigator.pushNamed(
        context,
        StageObjetivesScreen.route,
        arguments: StageObjetivesScreen(
          chapterSettings: this.widget.chapterSettings,
        ),
      );
    };

    Size size = MediaQuery.of(context).size;

    print(size);
    return Scaffold(
      body: GestureDetector(
        onPanUpdate: (panning) {
          /// left
          if (panning.delta.dx > 5) prevPage();

          /// right
          if (panning.delta.dx < -5) nextPage();
        },
        child: Stack(
          children: [
            //widget custom que crea el background con el logo de la izq
            ChapterBackgroundWidget(
              backgroundColor: Color(widget.chapterSettings.primaryColor),
              reliefPosition: 'top-right',
            ),
            //decoración adicional del background
            _backgroundDecoration(size),
            // _ideas(size),
          ],
        ),
      ),
      bottomNavigationBar: CustomNavigationBar(
        nextPage: nextPage,
        prevPage: prevPage,
      ),
    );
  }

  _backgroundDecoration(Size size) {
    return ListView(
      children: [
        SizedBox(
          height: 10,
        ),
        ChapterHeadWidget(
          phaseName: this.widget.chapterSettings.phaseName,
          chapterName: this.widget.chapterSettings.cityName,
          chapterImgURL: this.widget.chapterSettings.chapterImageUrl,
        ),
        if (this.questions != null)
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: CustomBubbleList(
              ideas: this.questions!,
            ),
          )
        else
          Center(
            child: CircularProgressIndicator(
              color: ColorsApp.white,
            ),
          ),
      ],
    );
  }
}

class CustomBubbleList extends StatelessWidget {
  const CustomBubbleList({
    Key? key,
    required this.ideas,
  }) : super(key: key);

  final List<String> ideas;

  @override
  Widget build(BuildContext context) {
    final List<Widget> colItems = [];

    /// List created
    ///
    /// 0,            one item row
    /// 1, 2,         two items row
    /// 3,            one item row
    /// 4,            and so on...
    for (int i = 0; i < this.ideas.length; i++) {
      // single item row
      if (i % 3 == 0) {
        String current = this.ideas[i];
        colItems.add(
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Container(
              constraints: BoxConstraints(maxWidth: 250),
              child: IdeaContainerWidget(
                text: current,
                orientation: i,
              ),
            ),
          ),
        );
        continue;
      }
      if (i % 3 == 1) {
        String current = this.ideas[i];
        colItems.add(
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Row(
              children: [
                Container(
                  constraints: BoxConstraints(maxWidth: 250),
                  child: IdeaContainerWidget(
                    text: current,
                    orientation: i,
                  ),
                ),
                Flexible(child: Container())
              ],
            ),
          ),
        );
        continue;
      }
      String current = this.ideas[i];
      colItems.add(
        Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Row(
            children: [
              Flexible(child: Container()),
              Container(
                constraints: BoxConstraints(maxWidth: 250),
                child: IdeaContainerWidget(
                  text: current,
                  orientation: i,
                ),
              ),
            ],
          ),
        ),
      );
      //   /// multi line item
      //   String item1 = this.ideas[i];
      //   String? item2 = (i + 1 < this.ideas.length) ? this.ideas[i + 1] : null;
      //   colItems.add(
      //     Row(
      //       children: [
      //         Expanded(
      //           child: Padding(
      //             padding: const EdgeInsets.only(bottom: 16),
      //             child: IdeaContainerWidget(
      //               text: item1,
      //               orientation: i,
      //             ),
      //           ),
      //         ),

      //         /// separator
      //         Container(width: 16),
      //         (item2 != null)
      //             ? Expanded(
      //                 child: Padding(
      //                 padding: const EdgeInsets.only(top: 16),
      //                 child: IdeaContainerWidget(
      //                   text: item2,
      //                   orientation: i + 1,
      //                 ),
      //                 ))
      //             : Expanded(child: Container()),
      //       ],
      //     ),
      //   );
      //   i += 2;
      // }
    }

    return Column(
      children: colItems,
    );
  }
}

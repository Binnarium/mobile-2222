import 'package:flutter/material.dart';
import 'package:lab_movil_2222/models/city.dto.dart';
import 'package:lab_movil_2222/models/micro-meso-macro.dto.dart';
import 'package:lab_movil_2222/services/load-micro-meso-macro.service.dart';
import 'package:lab_movil_2222/shared/widgets/app-loading.widget.dart';
import 'package:lab_movil_2222/shared/widgets/app-logo.widget.dart';
import 'package:lab_movil_2222/themes/colors.dart';
import 'package:lab_movil_2222/widgets/scaffold-2222/scaffold-2222.widget.dart';
import 'package:lab_movil_2222/interfaces/i-load-with-options.service.dart';

class MicroMesoMacroScreen extends StatefulWidget {
  static const String route = '/micro_meso_macro';

  final CityDto city;

  final ILoadOptions<MicroMesoMacroDto, CityDto> loader;

  MicroMesoMacroScreen({Key? key, required CityDto city})
      : this.city = city,
        this.loader = LoadMicroMesoMacroService(chapterSettings: city),
        super(key: key);

  @override
  _MicroMesoMacroScreenState createState() => _MicroMesoMacroScreenState();
}

class _MicroMesoMacroScreenState extends State<MicroMesoMacroScreen> {
  MicroMesoMacroDto? microMesoMacroDto;
  @override
  void initState() {
    super.initState();
    this
        .widget
        .loader
        .load()
        .then((value) => this.setState(() => microMesoMacroDto = value));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold2222(
        body: _microMesoMacroBody(size, context),
        city: this.widget.city,
        route: MicroMesoMacroScreen.route);
  }

  _microMesoMacroBody(size, context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    String text1 = microMesoMacroDto?.subtitle.split(" ").first ?? "";
    String text2 =
        microMesoMacroDto?.subtitle.replaceFirst(text1, "").toUpperCase() ?? "";
    if (this.microMesoMacroDto == null) {
      return Center(child: AppLoading());
    } else {
      return LayoutBuilder(builder: (context, constraints) {
        double maxWidth = constraints.maxWidth;
        double maxHeight = constraints.maxHeight;

        /// temporal surrounded container until scaffold2222 allows to change
        /// background color
        /// TODO: Remove Container
        return Container(
          color: Colors2222.red,
          child: Padding(
            padding: EdgeInsets.only(
                left: maxWidth * 0.05,
                right: maxWidth * 0.05,
                top: maxHeight * 0.05),
            child: Column(
              children: [
                Flexible(
                  child: AppLogo(kind: AppImage.animatedAppLogo),
                  flex: 6,
                ),
                SizedBox(
                  height: constraints.maxHeight * 0.1,
                ),
                Flexible(
                  child: Text(
                    microMesoMacroDto?.title.toUpperCase() ?? "",
                    style: textTheme.headline2?.copyWith(fontSize: 48),
                  ),
                  flex: 3,
                ),
                SizedBox(
                  height: constraints.maxHeight * 0.075,
                ),
                Flexible(
                    flex: 5,
                    child: (microMesoMacroDto?.image.url != null)
                        ? Image.network(microMesoMacroDto!.image.url)
                        : AppLoading()),
                SizedBox(
                  height: constraints.maxHeight * 0.1,
                ),
                Flexible(
                  flex: 3,
                  child: Text(text1.toUpperCase(),
                      textAlign: TextAlign.center,
                      style: textTheme.headline2
                          ?.copyWith(fontSize: (maxWidth > 360) ? 30 : 26)),
                ),
                Flexible(
                  flex: 3,
                  child: Text("docente-instituciones".toUpperCase(),
                      textAlign: TextAlign.center,
                      style: textTheme.headline2
                          ?.copyWith(fontSize: (maxWidth > 360) ? 30 : 26)),
                ),
              ],
            ),
          ),
        );
      });
    }
  }
}

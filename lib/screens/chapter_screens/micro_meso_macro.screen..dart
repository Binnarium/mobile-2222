import 'dart:math';

import 'package:flutter/material.dart';
import 'package:lab_movil_2222/interfaces/i-load-with-options.service.dart';
import 'package:lab_movil_2222/models/city.dto.dart';
import 'package:lab_movil_2222/models/micro-meso-macro.dto.dart';
import 'package:lab_movil_2222/services/load-micro-meso-macro.service.dart';
import 'package:lab_movil_2222/shared/widgets/app-loading.widget.dart';
import 'package:lab_movil_2222/shared/widgets/app-logo.widget.dart';
import 'package:lab_movil_2222/themes/colors.dart';
import 'package:lab_movil_2222/widgets/scaffold-2222/scaffold-2222.widget.dart';

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
    TextTheme textTheme = Theme.of(context).textTheme;

    final Size size = MediaQuery.of(context).size;
    return Scaffold2222.city(
      city: this.widget.city,
      route: MicroMesoMacroScreen.route,
      color: Colors2222.red,
      body: (this.microMesoMacroDto == null)
          ? AppLoading()
          : Container(
              width: size.width * 0.9,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  /// app logo
                  AppLogo(
                    kind: AppImage.animatedAppLogo,
                    width: min(size.width * 0.5, 400),
                  ),

                  /// title
                  Text(
                    microMesoMacroDto!.title.toUpperCase(),
                    style: textTheme.headline3!.copyWith(
                      fontWeight: FontWeight.w300,
                      fontSize: 52,
                    ),
                  ),

                  /// image
                  Image.network(
                    microMesoMacroDto!.image.url,
                    width: min(size.width * 0.4, 350),
                  ),

                  /// text
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: textTheme.headline4!.copyWith(
                        fontWeight: FontWeight.w300,
                        fontSize: 28,
                      ),
                      children: [
                        for (String text in this
                            .microMesoMacroDto!
                            .subtitle
                            .toLowerCase()
                            .split('\\n')
                            .map((e) => e.trim()))
                          TextSpan(
                            text: '${text.toUpperCase()}\n',
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}

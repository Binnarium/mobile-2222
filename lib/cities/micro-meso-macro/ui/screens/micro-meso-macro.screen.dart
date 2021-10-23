import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:lab_movil_2222/cities/micro-meso-macro/models/micro-meso-macro.model.dart';
import 'package:lab_movil_2222/cities/micro-meso-macro/services/load-micro-meso-macro.service.dart';
import 'package:lab_movil_2222/cities/micro-meso-macro/ui/widgets/micro-meso-macro-description-text.widget.dart';
import 'package:lab_movil_2222/city/models/city.dto.dart';
import 'package:lab_movil_2222/shared/widgets/app-loading.widget.dart';
import 'package:lab_movil_2222/shared/widgets/app-logo.widget.dart';
import 'package:lab_movil_2222/themes/colors.dart';
import 'package:lab_movil_2222/widgets/scaffold-2222/widgets/scaffold-2222.widget.dart';
import 'package:provider/provider.dart';

class MicroMesoMacroScreen extends StatefulWidget {
  const MicroMesoMacroScreen({
    Key? key,
    required CityModel cityModel,
  })  : city = cityModel,
        super(key: key);

  static const String route = '/micro_meso_macro';

  final CityModel city;

  @override
  _MicroMesoMacroScreenState createState() => _MicroMesoMacroScreenState();
}

class _MicroMesoMacroScreenState extends State<MicroMesoMacroScreen> {
  MicroMesoMacroModel? microMesoMacroModel;

  StreamSubscription? _loadMisoMesoMacroSub;

  LoadMicroMesoMacroService get loadMicroMesoMacroService =>
      Provider.of<LoadMicroMesoMacroService>(context, listen: false);

  @override
  void initState() {
    super.initState();
    _loadMisoMesoMacroSub = loadMicroMesoMacroService.load$(widget.city).listen(
      (misoMesoMacroModel) {
        if (mounted) {
          setState(() {
            microMesoMacroModel = misoMesoMacroModel;
          });
        }
      },
    );
  }

  @override
  void dispose() {
    _loadMisoMesoMacroSub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final Size size = MediaQuery.of(context).size;

    return Scaffold2222.city(
      city: widget.city,
      route: MicroMesoMacroScreen.route,
      color: Colors2222.red,
      body: (microMesoMacroModel == null)
          ? const AppLoading()
          : Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                /// app logo
                AppLogo(
                  kind: AppImage.animatedAppLogo,
                  width: min(size.width * 0.5, 400),
                ),

                /// title
                Text(
                  microMesoMacroModel!.title.toUpperCase(),
                  style: textTheme.headline3!.copyWith(
                    fontWeight: FontWeight.w300,
                    fontSize: 52,
                  ),
                ),

                /// image
                Image.network(
                  microMesoMacroModel!.image.url,
                  width: min(size.width * 0.4, 350),
                ),

                /// text
                MicroMesoMacroDescriptionText(
                  text: microMesoMacroModel!.subtitle,
                ),
              ],
            ),
    );
  }
}

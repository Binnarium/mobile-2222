import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:lab_movil_2222/cities/micro-meso-macro/models/micro-meso-macro.model.dart';
import 'package:lab_movil_2222/cities/micro-meso-macro/services/load-micro-meso-macro.service.dart';
import 'package:lab_movil_2222/cities/micro-meso-macro/ui/widgets/micro-meso-macro-description-text.widget.dart';
import 'package:lab_movil_2222/interfaces/i-load-with-options.service.dart';
import 'package:lab_movil_2222/models/city.dto.dart';
import 'package:lab_movil_2222/shared/widgets/app-loading.widget.dart';
import 'package:lab_movil_2222/shared/widgets/app-logo.widget.dart';
import 'package:lab_movil_2222/themes/colors.dart';
import 'package:lab_movil_2222/widgets/scaffold-2222/scaffold-2222.widget.dart';
import 'package:provider/provider.dart';

class MicroMesoMacroScreen extends StatefulWidget {
  static const String route = '/micro_meso_macro';

  final CityDto city;

  MicroMesoMacroScreen({
    Key? key,
    required CityDto city,
  })  : this.city = city,
        super(key: key);

  @override
  _MicroMesoMacroScreenState createState() => _MicroMesoMacroScreenState();
}

class _MicroMesoMacroScreenState extends State<MicroMesoMacroScreen> {
  MicroMesoMacroModel? microMesoMacroModel;
  StreamSubscription? _loadMisoMesoMacroSub;

  @override
  void initState() {
    super.initState();

    LoadMicroMesoMacroService loadMicroMesoMacroService =
        Provider.of<LoadMicroMesoMacroService>(this.context, listen: false);

    this._loadMisoMesoMacroSub =
        loadMicroMesoMacroService.load$(this.widget.city).listen(
      (misoMesoMacroModel) {
        if (this.mounted)
          this.setState(() {
            this.microMesoMacroModel = misoMesoMacroModel;
          });
      },
    );
  }

  @override
  void dispose() {
    this._loadMisoMesoMacroSub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    final Size size = MediaQuery.of(context).size;
    return Scaffold2222.city(
      city: this.widget.city,
      route: MicroMesoMacroScreen.route,
      color: Colors2222.red,
      body: (this.microMesoMacroModel == null)
          ? AppLoading()
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
                  text: this.microMesoMacroModel!.subtitle,
                ),
              ],
            ),
    );
  }
}

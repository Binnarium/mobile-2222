import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lab_movil_2222/themes/colors.dart';

// ignore: use_key_in_widget_constructors
class DaysLeftWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //tamaño de la pantalla
    final size = MediaQuery.of(context).size;
    //llamando al cuerpo
    return _introductionBody(context, size);
  }
}

FutureBuilder<String> _introductionBody(BuildContext context, Size size) {
  final TextTheme textTheme = Theme.of(context).textTheme;
  //Creando el Scroll

  double daysLeftSize = size.height * 0.0011;
  if (size.height < 550) {
    daysLeftSize = size.height * 0.0014;
  }
  if (size.height < 650) {
    daysLeftSize = size.height * 0.0011;
  }
  return FutureBuilder(
    future: _daysLeftReading(),
    builder: (BuildContext context, AsyncSnapshot<String> days) {
      if (days.hasError) {
        return Text(days.error.toString());
      }
      if (days.connectionState == ConnectionState.waiting) {
        return const Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(
              Colors2222.red,
            ),
          ),
        );
      }
      if (days.hasData) {
        return Column(
          children: [
            //Texto cambiar por funcionalidad de cuenta de días
            Text('FALTAN',
                style: textTheme.headline6
                    ?.apply(fontSizeFactor: size.height * 0.001)),
            SizedBox(height: size.height * 0.01),
            //Texto cambiar por funcionalidad de cuenta de días

            Text(days.data! + ' DÍAS',
                style:
                    textTheme.headline3?.apply(fontSizeFactor: daysLeftSize)),

            //Texto cambiar por funcionalidad de cuenta de días
            SizedBox(height: size.height * 0.005),
            Text('PARA ACABAR EL VIAJE',
                style: textTheme.headline6
                    ?.apply(fontSizeFactor: size.height * 0.001)),
          ],
        );
      }
      return const Text('Error loading daysleft _configuration_');
    },
  );
}

Future<String> _daysLeftReading() async {
  final snap = await FirebaseFirestore.instance
      .collection('application')
      .doc('_configuration_')
      .get();

  if (!snap.exists) {
    ErrorDescription('Document _configuration_ does not exists');
  }

  // ignore: cast_nullable_to_non_nullable
  final Map<String, dynamic> payload = snap.data() as Map<String, dynamic>;
  final DateTime date =
      (payload['courseFinalizationDate'] as Timestamp).toDate();
  final Duration daysLeft = date.difference(DateTime.now());
  return daysLeft.inDays.toString();
}

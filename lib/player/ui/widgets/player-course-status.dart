import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lab_movil_2222/player/models/course-status.enum.dart';
import 'package:lab_movil_2222/themes/colors.dart';

/// Representation of course status
/// Depending on the status this widget will display
/// - [CourseStatus.notStarted] message with the course is next to start
/// - [CourseStatus.inProgress] remaining days til the course finalized, of course finalized
/// - [CourseStatus.approvedContinueNextPhaseWithContentAccess] finalized course and message of having approved the course
/// - [CourseStatus.approvedCanNotContinueNextPhaseNoContentAccess] finalized course with message not cant continue next phase
class PlayerCourseStatus extends StatelessWidget {
  const PlayerCourseStatus({
    Key? key,
    required this.status,
  }) : super(key: key);

  final CourseStatus status;

  @override
  Widget build(BuildContext context) {
    /// in progress day counter
    if (status == CourseStatus.inProgress) return const _DaysCounter();

    ///  not started yet
    if (status == CourseStatus.notStarted)
      return const Center(
        child: Text(
          'El viaje aún no ha empezado',
          textAlign: TextAlign.center,
        ),
      );

    /// approved course, and continue next phase
    if ([
      CourseStatus.approvedContinueNextPhaseWithContentAccess,
      CourseStatus.approvedCanContinueNextPhaseNoContentAccess
    ].contains(status))
      return const Center(
        child: Text(
          'Continuas a la siguiente fase de los 200',
          textAlign: TextAlign.center,
        ),
      );

    /// approved and obtained certification, but no continue next phase
    if (status == CourseStatus.approvedCanNotContinueNextPhase)
      return const Center(
        child: Text(
          'Aprobaste el curso, pronto recibiras tu certificado',
          textAlign: TextAlign.center,
        ),
      );

    /// not approved
    if (status == CourseStatus.notApproved)
      return const Center(
        child: Text(
          'No has aprobado el curso',
          textAlign: TextAlign.center,
        ),
      );

    /// not identifier, by default return days counter
    return const _DaysCounter();
  }
}

class _DaysCounter extends StatelessWidget {
  const _DaysCounter({Key? key}) : super(key: key);

  Future<String> _daysLeftReading() async {
    final snap = await FirebaseFirestore.instance
        .collection('application')
        .doc('_configuration_')
        .get();

    if (!snap.exists) {
      ErrorDescription('Document _configuration_ does not exists');
    }

    final Map<String, dynamic> payload = snap.data() as Map<String, dynamic>;
    final DateTime date =
        (payload['courseFinalizationDate'] as Timestamp).toDate();
    final Duration daysLeft = date.difference(DateTime.now());
    return daysLeft.inDays.toString();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
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

              Text(
                  (int.parse(days.data!) >= 0)
                      ? (days.data! + ' DÍAS')
                      : '0 DÍAS',
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
}

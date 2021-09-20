import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lab_movil_2222/cities/clubhouse/models/clubhouse.model.dart';
import 'package:lab_movil_2222/themes/colors.dart';
import 'package:url_launcher/url_launcher.dart';

class ClubhouseCard extends StatelessWidget {
  const ClubhouseCard({
    Key? key,
    required this.clubhouseModel,
  }) : super(key: key);

  final ClubhouseModel clubhouseModel;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        /// coffee image
        const Padding(
          padding: EdgeInsets.only(bottom: 8.0),
          child: Image(
            image: AssetImage('assets/icons/clubhouse_activity_icon.png'),
          ),
        ),

        /// event name
        Padding(
          padding: const EdgeInsets.only(bottom: 4.0),
          child: Text(
            clubhouseModel.name,
            style: textTheme.subtitle2,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            textAlign: TextAlign.center,
          ),
        ),

        /// date
        Text(
          DateFormat('EEE, MM/dd-HH:mm').format(clubhouseModel.date),
          style: textTheme.button,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          textAlign: TextAlign.center,
        ),

        /// date
        if (clubhouseModel.uploaderDisplayName != null)
          Text(
            clubhouseModel.uploaderDisplayName!,
            style: textTheme.button,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            textAlign: TextAlign.center,
          ),

        /// open button

        Center(
          child: OutlinedButton.icon(
            style: OutlinedButton.styleFrom(
              primary: Colors2222.white,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            ),
            icon: const Icon(Icons.bookmark_add),
            onPressed: () => launch(clubhouseModel.clubhouseUrl),
            label: const Text(
              'Agendar',
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
        ),
      ],
    );
  }
}

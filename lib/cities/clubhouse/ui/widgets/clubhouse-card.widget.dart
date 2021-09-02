import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lab_movil_2222/cities/clubhouse/models/clubhouse.model.dart';
import 'package:lab_movil_2222/themes/colors.dart';
import 'package:url_launcher/url_launcher.dart';

class ClubhouseCard extends StatelessWidget {
  final ClubhouseModel clubhouseModel;

  const ClubhouseCard({
    Key? key,
    required this.clubhouseModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(this.clubhouseModel.uploaderDisplayName);
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        /// coffee image
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Image(
            image: AssetImage('assets/icons/clubhouse_activity_icon.png'),
          ),
        ),

        /// event name
        Padding(
          padding: const EdgeInsets.only(bottom: 4.0),
          child: Text(
            this.clubhouseModel.name,
            style: textTheme.subtitle2,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            textAlign: TextAlign.center,
          ),
        ),

        /// date
        Text(
          DateFormat('EEE, MM/dd-HH:mm').format(this.clubhouseModel.date),
          style: textTheme.button,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          textAlign: TextAlign.center,
        ),

        /// date
        if (this.clubhouseModel.uploaderDisplayName != null)
          Text(
            this.clubhouseModel.uploaderDisplayName!,
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
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            ),
            icon: Icon(Icons.bookmark_add),
            onPressed: () => launch(this.clubhouseModel.clubhouseUrl),
            label: Text(
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

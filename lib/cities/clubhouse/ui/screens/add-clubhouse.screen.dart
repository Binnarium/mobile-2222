import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lab_movil_2222/cities/clubhouse/models/clubhouse.model.dart';
import 'package:lab_movil_2222/cities/clubhouse/services/create-clubhouse.service.dart';
import 'package:lab_movil_2222/cities/clubhouse/services/load-user-clubhouse.service.dart';
import 'package:lab_movil_2222/cities/clubhouse/ui/widgets/clubhouse-event-card.widget.dart';
import 'package:lab_movil_2222/cities/clubhouse/ui/widgets/clubhouse-explanation.widget.dart';
import 'package:lab_movil_2222/cities/clubhouse/ui/widgets/clubhouse-section-title.widget.dart';
import 'package:lab_movil_2222/home-map/models/city.dto.dart';
import 'package:lab_movil_2222/shared/widgets/app-loading.widget.dart';
import 'package:lab_movil_2222/themes/colors.dart';
import 'package:lab_movil_2222/widgets/decorated-background/background-decoration.widget.dart';
import 'package:lab_movil_2222/widgets/form/text-form-field-2222.widget.dart';
import 'package:lab_movil_2222/widgets/scaffold-2222/widgets/scaffold-2222.widget.dart';
import 'package:provider/provider.dart';

class AddClubhouseScreen extends StatefulWidget {
  const AddClubhouseScreen({
    Key? key,
    required this.city,
  }) : super(key: key);

  static const String route = '/add-clubhouse';
  final CityModel city;

  @override
  _AddClubhouseScreenState createState() => _AddClubhouseScreenState();
}

class _AddClubhouseScreenState extends State<AddClubhouseScreen> {
  String? clubhouseUrl;

  StreamSubscription? clubhousesSub;
  StreamSubscription? createClubhousesSub;

  List<ClubhouseModel>? clubhouses;

  final TextEditingController _addClubhouseController = TextEditingController();

  LoadUserClubhouseService get _loadUserClubhouseService =>
      Provider.of<LoadUserClubhouseService>(context, listen: false);
  CreateClubhouseService get _createClubhouseService =>
      Provider.of<CreateClubhouseService>(context, listen: false);

  @override
  void initState() {
    super.initState();
    clubhousesSub =
        _loadUserClubhouseService.load$(widget.city).listen((event) {
      setState(() {
        clubhouses = event;
      });
    });
  }

  @override
  void dispose() {
    clubhousesSub?.cancel();
    createClubhousesSub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final Size size = MediaQuery.of(context).size;

    return Scaffold2222.empty(
      backgroundColor: widget.city.color,
      backgrounds: const [BackgroundDecorationStyle.topRight],
      appBar: AppBar(
        title: Text(
          'Agrega tu Evento Clubhouse',
          style: textTheme.subtitle1!.copyWith(
            color: Colors2222.white,
          ),
        ),
        primary: true,
        backgroundColor: widget.city.color,
        titleSpacing: 0,
      ),
      body: ListView(
        children: [
          /// add event input
          Padding(
            padding: EdgeInsets.only(
              top: 34,
              bottom: 20,
              left: size.width * 0.08,
              right: size.width * 0.08,
            ),
            child: TextFormField222(
              primaryColor: widget.city.color,
              controller: _addClubhouseController,
              label: 'Enlace de evento clubhouse',
              keyboardType: TextInputType.url,
              prefixIcon: Icons.search,
              onValueChanged: (value) => clubhouseUrl = value,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors2222.black,
                  elevation: 5,
                ),
                onPressed: _createClubhouse,
                child: const Text('Agregar Evento'),
              ),
            ),
          ),

          /// page content
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: 30.0,
              horizontal: size.width * 0.08,
            ),
            child: const ClubhouseExplanationWidget(),
          ),

          /// next clubhouse title
          const Padding(
            padding: EdgeInsets.only(bottom: 34.0),
            child: ClubhouseSectionTitle(
              title: 'Tus eventos creados',
            ),
          ),

          /// page content
          if (clubhouses == null)
            const AppLoading()
          else
            Padding(
              padding: EdgeInsets.only(
                bottom: 20,
                left: size.width * 0.04,
                right: size.width * 0.04,
              ),
              child: (clubhouses!.isEmpty)
                  ? const Center(
                      child: Text('No hay clubhouse creados'),
                    )
                  : GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: size.width * 0.04,
                        mainAxisSpacing: size.width * 0.04,
                      ),
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: clubhouses!.length,
                      itemBuilder: (context, index) => ClubhouseCard(
                        clubhouseModel: clubhouses![index],
                      ),
                    ),
            ),
        ],
      ),
    );
  }

  void _createClubhouse() {
    if (clubhouseUrl == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Se esta guardando el evento',
          ),
        ),
      );
      return;
    }

    if (createClubhousesSub != null) return;

    createClubhousesSub = _createClubhouseService
        .create$(city: widget.city, url: clubhouseUrl!)
        .listen((created) {
      if (created) {
        clubhouseUrl = null;
        _addClubhouseController.clear();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Evento guardado',
            ),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'No se pudo guardar el evento',
            ),
          ),
        );
      }
    }, onDone: () {
      createClubhousesSub!.cancel();
      createClubhousesSub = null;
    });
  }
}

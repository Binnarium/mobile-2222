import 'dart:async';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lab_movil_2222/cities/clubhouse/models/clubhouse.model.dart';
import 'package:lab_movil_2222/cities/clubhouse/models/create-clubhouse.model.dart';
import 'package:lab_movil_2222/cities/clubhouse/services/load-available-clubhouse.service.dart';
import 'package:lab_movil_2222/cities/clubhouse/ui/widgets/clubhouse-card.widget.dart';
import 'package:lab_movil_2222/cities/clubhouse/ui/widgets/clubhouse-section-title.widget.dart';
import 'package:lab_movil_2222/models/city.dto.dart';
import 'package:lab_movil_2222/shared/widgets/app-loading.widget.dart';
import 'package:lab_movil_2222/shared/widgets/markdown.widget.dart';
import 'package:lab_movil_2222/themes/colors.dart';
import 'package:lab_movil_2222/widgets/decorated-background/background-decoration.widget.dart';
import 'package:lab_movil_2222/widgets/form/text-form-field-2222.widget.dart';
import 'package:lab_movil_2222/widgets/header-logos.widget.dart';
import 'package:lab_movil_2222/widgets/scaffold-2222/scaffold-2222.widget.dart';

const String description = """Agenda de eventos según temáticas de cada ciudad. 
    1) Ve a Clubhouse y organiza un evento;
    2) Copia el enlace, pégalo aquí, lo agregas a la agenda y obtienes un premio; 
    ) Disfruta y aprende con tus colegas docentes.""";

class ClubhouseScreen extends StatefulWidget {
  static const String route = '/chapterClubhouse';
  final CityDto city;

  const ClubhouseScreen({Key? key, required this.city}) : super(key: key);

  @override
  _ClubhouseScreenState createState() => _ClubhouseScreenState();
}

class _ClubhouseScreenState extends State<ClubhouseScreen> {
  StreamSubscription? clubhousesSub;

  List<ClubhouseModel>? clubhouses;
  final TextEditingController _addClubhouseController = TextEditingController();

  @override
  void initState() {
    super.initState();
    this.clubhousesSub =
        LoadAvailableClubhouseService(this.widget.city).listen((event) {
      this.setState(() {
        this.clubhouses = event;
      });
    });
  }

  @override
  void deactivate() {
    this.clubhousesSub?.cancel();
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final Size size = MediaQuery.of(context).size;

    return Scaffold2222.city(
      city: this.widget.city,
      backgrounds: [BackgroundDecorationStyle.topRight],
      route: ClubhouseScreen.route,
      body: ListView(
        children: [
          /// icon item
          Padding(
            padding: const EdgeInsets.only(bottom: 50.0),
            child: LogosHeader(
              showStageLogoCity: this.widget.city,
            ),
          ),

          /// page header
          Center(
            child: Container(
              padding: const EdgeInsets.only(bottom: 24.0),
              width: min(300, size.width * 0.8),
              child: Text(
                "CLUBHOUSE",
                style: textTheme.headline3!.copyWith(
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),

          /// page content
          Padding(
            padding: EdgeInsets.only(
              bottom: 30.0,
              left: size.width * 0.08,
              right: size.width * 0.08,
            ),
            child: Markdown2222(
              data: description,
              contentAlignment: WrapAlignment.center,
            ),
          ),

          /// next clubhouse title
          Padding(
            padding: const EdgeInsets.only(bottom: 34.0),
            child: ClubhouseSectionTitle(
              title: 'Eventos en las próximas 24 horas',
            ),
          ),

          /// page content
          (this.clubhouses == null)
              ? AppLoading()
              : Padding(
                  padding: EdgeInsets.only(
                    bottom: 20,
                    left: size.width * 0.04,
                    right: size.width * 0.04,
                  ),
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: size.width * 0.04,
                      mainAxisSpacing: size.width * 0.04,
                    ),
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: this.clubhouses!.length,
                    itemBuilder: (context, index) => ClubhouseCard(
                      clubhouseModel: this.clubhouses![index],
                    ),
                  ),
                ),

          Padding(
            padding: const EdgeInsets.only(bottom: 34.0),
            child: ClubhouseSectionTitle(
              title: 'Agrega tu evento',
            ),
          ),

          Padding(
            padding: EdgeInsets.only(
              bottom: 20,
              left: size.width * 0.08,
              right: size.width * 0.08,
            ),
            child: TextFormField222(
              primaryColor: this.widget.city.color,
              controller: this._addClubhouseController,
              label: 'Enlace clubhouse',
              keyboardType: TextInputType.url,
              prefixIcon: Icons.search,
              onValueChanged: (value) => this.clubhouseUrl = value,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 20),
            child: Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors2222.black,
                  elevation: 5,
                ),
                child: Text('Agregar clubhouse'),
                onPressed: () async {
                  if (this.clubhouseUrl == null) return;
                  final FirebaseFirestore _fFirestore =
                      FirebaseFirestore.instance;
                  final FirebaseAuth _fAuth = FirebaseAuth.instance;
                  final CreateClubhouseModel createClubhouseModel =
                      CreateClubhouseModel(
                    cityId: this.widget.city.id,
                    clubhouseUrl: this.clubhouseUrl!,
                    id: this._generateId(size: 15),
                    uploaderId: _fAuth.currentUser!.uid,
                  );

                  await _fFirestore
                      .collection('clubhouse')
                      .doc(createClubhouseModel.id)
                      .set(createClubhouseModel.toMap());

                  this.clubhouseUrl = null;
                  this._addClubhouseController.clear();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _generateId({int size = 10}) {
    const _chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    Random _rnd = Random();

    String id = String.fromCharCodes(
      Iterable.generate(
        size,
        (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length)),
      ),
    );
    return id;
  }

  String? clubhouseUrl;
}

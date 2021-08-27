import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lab_movil_2222/screens/home.screen.dart';
import 'package:lab_movil_2222/shared/widgets/app-logo.widget.dart';
import 'package:lab_movil_2222/themes/colors.dart';
import 'package:lab_movil_2222/user/models/register-form.model.dart';
import 'package:lab_movil_2222/user/models/registered-player.model.dart';
import 'package:lab_movil_2222/user/widgets/login.screen.dart';
import 'package:lab_movil_2222/widgets/decorated-background/background-decoration.widget.dart';
import 'package:lab_movil_2222/widgets/form/text-form-field-2222.widget.dart';

class RegisterScreen extends StatefulWidget {
  static const String route = '/register';

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final RegisterFormModel _formValue = RegisterFormModel.empty();

  ///página de login donde pide usuario y contraseña
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    final TextTheme textTheme = Theme.of(context).textTheme;

    ///safeArea para dispositivos con pantalla notch
    return Form(
      key: this._formKey,
      child: Scaffold(
        backgroundColor: Colors2222.red,
        body: BackgroundDecoration(
          backgroundDecorationsStyles: [BackgroundDecorationStyle.bottomRight],
          child: ListView(
            padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.08, vertical: 64),
            children: [
              /// app logo
              Padding(
                padding: const EdgeInsets.only(bottom: 40),
                child: Center(
                  child: AppLogo(
                    kind: AppImage.defaultAppLogo,
                    width: min(350, size.width * 0.6),
                  ),
                ),
              ),

              /// App Title
              Padding(
                padding: const EdgeInsets.only(bottom: 32),
                child: Text(
                  'Lab Móvil 2222'.toUpperCase(),
                  style: textTheme.headline4,
                  textAlign: TextAlign.center,
                ),
              ),

              /// subtitle
              Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: Text(
                  'Crea tu cuenta y comienza tu aventura',
                  style: textTheme.headline6,
                  textAlign: TextAlign.center,
                ),
              ),

              /// email input
              Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: TextFormField222(
                  label: 'Correo Electrónico',
                  keyboardType: TextInputType.emailAddress,
                  onValueChanged: (email) => this._formValue.email = email!,
                  validator: (email) {
                    bool emailValid = RegExp(
                            r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$')
                        .hasMatch(email!);
                    if (!emailValid) return 'Correo electrónico invalido';
                    return null;
                  },
                ),
              ),

              /// password
              Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: TextFormField222.password(
                  label: 'Contraseña',
                  onValueChanged: (password) =>
                      this._formValue.password = password!,
                  validator: (value) {
                    final int numberCaracteres = 6;
                    if (value == null || value.isEmpty) {
                      return 'Ingresa una contraseña valida';
                    }
                    if (value.length < numberCaracteres) {
                      return 'La contraseña debe tener al menos $numberCaracteres caracteres';
                    }
                    return null;
                  },
                ),
              ),

              /// validate password
              Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: TextFormField222.password(
                  label: 'Validar Contraseña',
                  onValueChanged: (password) =>
                      this._formValue.validatePassword = password!,
                  validator: (password) {
                    if (this._formValue.password == null ||
                        this._formValue.password != password)
                      return 'Las contraseñas no coinciden';
                    return null;
                  },
                ),
              ),

              /// register button
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors2222.black,
                  elevation: 5,
                ),
                child: Text('REGISTRATE AHORA'),
                onPressed: () async {
                  if (this._formKey.currentState!.validate()) {
                    this._formKey.currentState!.save();
                    try {
                      /// validate user is registered
                      final inscribed = await FirebaseFirestore.instance
                          .collection('inscribed-players')
                          .doc(this._formValue.email!)
                          .get();

                      if (!inscribed.exists)
                        throw ErrorDescription(
                            'No estas inscrito para participar del viaje');

                      final RegisteredPlayer registeredPlayer =
                          RegisteredPlayer(
                        email: inscribed.data()!['email'],
                        name: inscribed.data()!['name'],
                        lastName: inscribed.data()!['lastName'],
                      );

                      /// create account with email and password
                      final credentials = await FirebaseAuth.instance
                          .createUserWithEmailAndPassword(
                              email: this._formValue.email!,
                              password: this._formValue.password!);

                      if (credentials.user == null)
                        throw ErrorDescription('No se pudo iniciar Sesión');

                      /// configure account information
                      final String displayName =
                          '${registeredPlayer.name} ${registeredPlayer.lastName}';
                      await credentials.user!.updateDisplayName(displayName);

                      /// create player profile
                      await FirebaseFirestore.instance
                          .collection('players')
                          .doc(credentials.user!.uid)
                          .set({
                        'email': this._formValue.email!,
                        'displayName': displayName,
                        'uid': credentials.user!.uid,
                      });

                      /// add to group
                      /// TODO: move to function
                      await FirebaseFirestore.instance
                          .collection('chats')
                          .doc('ZRncSssBoxIbApvXO9Vr')
                          .update({
                        'participantsUids':
                            FieldValue.arrayUnion([credentials.user!.uid]),
                        'participants': FieldValue.arrayUnion([
                          {
                            'displayName': displayName,
                            'uid': credentials.user!.uid,
                          }
                        ]),
                      });

                      /// complete navigation and notify user
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(' Bienvenido ${registeredPlayer.name}'),
                      ));

                      Navigator.pushReplacementNamed(context, HomeScreen.route);
                    } on FirebaseAuthException catch (e) {
                      /// email already in use
                      if (e.code == 'email-already-in-use') {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(
                              'Ya existe una cuenta usando este correo electrónico'),
                          action: SnackBarAction(
                            label: 'Inicia Sesión',
                            onPressed: () => Navigator.pushReplacementNamed(
                                context, LoginScreen.route),
                          ),
                        ));
                      }

                      /// show snackbar with default message
                      else
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(e.code),
                        ));
                    } on ErrorDescription catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(e.valueToString()),
                      ));
                    }
                  }
                },
              ),

              /// already have an account button
              ///
              /// back button to replace current screen with login screen
              TextButton(
                onPressed: () => Navigator.pop(context),
                style: TextButton.styleFrom(primary: Colors2222.white),
                child: Text('¿Ya tienes una cuenta? Inicia Sesión!'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

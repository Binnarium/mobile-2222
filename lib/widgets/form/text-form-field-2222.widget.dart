import 'package:flutter/material.dart';
import 'package:lab_movil_2222/themes/colors.dart';

class TextFormField222 extends StatelessWidget {
  /// description of the input form
  final String label;

  /// hide content of input text
  final bool obscureText;

  /// keyboard type used to input text
  final TextInputType? keyboardType;

  /// function triggered when value of form changes
  final void Function(String?)? onValueChanged;

  /// validator function
  final String? Function(String?)? validator;

  /// TODO: add docs
  final IconData? prefixIcon;

  final Color primaryColor;

  /// TODO: add docs
  final TextEditingController? controller;

  TextFormField222({
    Key? key,
    this.obscureText = false,
    this.keyboardType,
    required this.onValueChanged,
    required this.label,
    this.validator,
    this.prefixIcon,
    this.controller,
    this.primaryColor = Colors2222.red,
  }) : super(key: key);

  TextFormField222.password({
    Key? key,
    required this.onValueChanged,
    required this.label,
    this.prefixIcon,
    this.controller,
    this.validator,
    this.primaryColor = Colors2222.red,
  })  : this.keyboardType = TextInputType.name,
        this.obscureText = true,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextStyle inputStyle = Theme.of(context).textTheme.bodyText2!;
    final TextStyle overlineStyle = Theme.of(context).textTheme.overline!;
    final BorderRadius borderRadius = BorderRadius.circular(4);

    return TextFormField(
      controller: this.controller,
      obscureText: this.obscureText,
      onChanged: this.onValueChanged,
      validator: this.validator,
      keyboardType: this.keyboardType,

      /// decorate input to match 2222 style
      cursorColor: this.primaryColor,

      /// style inner text
      style: inputStyle.copyWith(color: Colors2222.black),

      /// style form input
      decoration: InputDecoration(
        /// label text
        ///
        /// when focus disable floating effect
        labelText: this.label,
        floatingLabelBehavior: FloatingLabelBehavior.never,

        /// icon decoration
        prefixIcon: (this.prefixIcon == null)
            ? null
            : Icon(
                this.prefixIcon,
                color: this.primaryColor,
              ),

        /// style background
        fillColor: Colors2222.white,
        filled: true,

        /// style info
        errorStyle: overlineStyle.copyWith(color: Colors2222.white),
        labelStyle: inputStyle.copyWith(color: Colors2222.black),

        /// border styles
        border: OutlineInputBorder(
          borderRadius: borderRadius,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: borderRadius,
          borderSide: BorderSide(color: Colors2222.black),
        ),
      ),
    );
  }
}

import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:lab_movil_2222/themes/colors.dart';
import 'package:lab_movil_2222/widgets/markdown/markdown.widget.dart';

/// Container with the PubPub code to be copied
class ContributionCodeCopy extends StatelessWidget {
  const ContributionCodeCopy({
    Key? key,
    required this.codeExplanation,
    required this.primaryColor,
    required String pubCode,
  })  : playerCode = 'C2222-$pubCode',
        super(key: key);

  final String codeExplanation;

  final String playerCode;

  final Color primaryColor;

  String? get codeMessage =>
      codeExplanation.replaceAll(RegExp('SHOW-CODE'), playerCode);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    /// card like style
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: size.width * 0.04,
        vertical: size.width * 0.04,
      ),

      /// card like decoration
      decoration: BoxDecoration(
        color: Colors2222.white,
        borderRadius: BorderRadius.circular(8),
      ),
      alignment: Alignment.center,
      child: Column(
        children: [
          /// markdown content
          Markdown2222(
            data: codeMessage!,
            textColor: Colors2222.black,
            primaryColor: primaryColor,
            selectable: true,
          ),

          const SizedBox(height: 12),

          /// copy button
          OutlinedButton.icon(
            icon: const Icon(Icons.copy_all_rounded),
            label: const Text('Copiar'),
            style: OutlinedButton.styleFrom(primary: primaryColor),
            onPressed: () => copyCode(context),
          ),
        ],
      ),
    );
  }

  /// function to copy the [playerCode] to the user clipboard
  Future<void> copyCode(BuildContext context) async {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    try {
      await FlutterClipboard.copy(playerCode);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Código copiado'),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No se pudo copiar el código'),
        ),
      );
    }
  }
}

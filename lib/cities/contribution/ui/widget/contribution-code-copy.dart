import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:lab_movil_2222/themes/colors.dart';
import 'package:lab_movil_2222/widgets/markdown/markdown.widget.dart';

class ContributionCodeCopy extends StatelessWidget {
  const ContributionCodeCopy({
    Key? key,
    required this.codeExplanation,
    required String pubCode,
  })  : playerCode = 'C2222-$pubCode',
        super(key: key);

  final String codeExplanation;

  final String playerCode;

  String? get codeMessage =>
      codeExplanation.replaceAll(RegExp('SHOW-CODE'), playerCode);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: size.width * 0.04,
        vertical: size.width * 0.04,
      ),
      decoration: BoxDecoration(
        color: Colors2222.white,
        borderRadius: BorderRadius.circular(8),
      ),
      alignment: Alignment.center,
      child: Column(
        children: [
          Markdown2222(
            data: codeMessage!,
            color: Colors2222.black,
          ),

          /// copy button
          OutlinedButton.icon(
            onPressed: () {
              FlutterClipboard.copy(playerCode).then((result) {
                const snackBar = SnackBar(
                  content: Text('Código copiado'),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              });
            },
            style: OutlinedButton.styleFrom(
              primary: Colors2222.primary,
            ),
            label: const Text('Copiar'),
            icon: const Icon(
              Icons.copy_all_rounded,
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:lab_movil_2222/shared/widgets/markdown.widget.dart';

const approveText = """
## Premios mínimos necesarios para aspirar a seguir en Sharngri-la

### 17 puntos!

Si subes los 5 pdfs del proyecto + hacen una contribución para cada una de los 11 ciudades + organizar 1 un clubhouse, el número es 17 premios. 


### Puntos extras

Obtén puntos extras de compañeros de grupo y participar en clubhouse extras
""";

class ApproveText extends StatelessWidget {
  const ApproveText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WorkloadMarkdown(
      workload: approveText,
    );
  }
}

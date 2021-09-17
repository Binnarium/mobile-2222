class TeamModel {
  TeamModel.fromMap(Map<String, dynamic> payload)
      : teamText = payload['teamText'] as String? ??
            'No hay texto de la ficha de equipo';

  final String teamText;
}

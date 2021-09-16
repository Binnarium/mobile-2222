class TeamModel {
  final String teamText;

  TeamModel.fromMap(Map<String, dynamic> payload)
      : teamText = payload['teamText'] as String? ??
            'No hay texto de la ficha de equipo';
}

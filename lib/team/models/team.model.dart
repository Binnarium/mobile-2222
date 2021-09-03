class TeamModel {
  final String teamText;

  TeamModel.fromMap(Map<String, dynamic> payload)
      : this.teamText =
            payload['teamText'] ?? 'No hay texto de la ficha de equipo';
}

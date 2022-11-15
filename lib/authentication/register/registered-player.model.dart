/// model of a player inscribed to access the application
class PlayerInscription {
  PlayerInscription({
    required this.email,
    required this.name,
    required this.lastName,
    required this.identification,
    required this.playerType,
  });

  PlayerInscription.fromMap(Map<String, dynamic> data)
      : email = data['email'] as String,
        name = data['name'] as String,
        lastName = data['lastName'] as String,
        identification = data['identification'] as String,
        playerType = data['playerType'] as String?;

  final String email;
  final String name;
  final String identification;
  final String lastName;
  final String? playerType;

  String get displayName {
    return '${name.trim()} ${lastName.trim()}';
  }
}

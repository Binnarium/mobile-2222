/// model of a player inscribed to access the application
class PlayerInscription {
  final String email;
  final String name;
  final String lastName;

  // ignore: sort_constructors_first
  PlayerInscription({
    required this.email,
    required this.name,
    required this.lastName,
  });

  // ignore: sort_constructors_first
  PlayerInscription.fromMap(Map<String, dynamic> data)
      : email = data['email'] as String,
        name = data['name'] as String,
        lastName = data['lastName'] as String;
}

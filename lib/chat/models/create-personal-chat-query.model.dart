class CreatePersonalChatQueryModel {
  /// constructor
  CreatePersonalChatQueryModel({
    required this.playerOne,
    required this.playerTwo,
  });

  /// params
  final String playerOne;
  final String playerTwo;

  Map<String, dynamic> toMap() {
    return <String, String>{
      'playerTwo': playerTwo,
      'playerOne': playerOne,
    };
  }
}

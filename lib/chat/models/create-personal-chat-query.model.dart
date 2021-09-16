class CreatePersonalChatQueryModel {
  final String playerOne;
  final String playerTwo;

  CreatePersonalChatQueryModel({
    required this.playerOne,
    required this.playerTwo,
  });

  Map<String, dynamic> toMap() {
    return <String, String>{
      'playerTwo': playerTwo,
      'playerOne': playerOne,
    };
  }
}

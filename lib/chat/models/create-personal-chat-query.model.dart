class CreatePersonalChatQueryModel {
  final String playerOne;
  final String playerTwo;

  CreatePersonalChatQueryModel({
    required this.playerOne,
    required this.playerTwo,
  });

  Map<String, dynamic> toMap() {
    return {
      'playerTwo': this.playerTwo,
      'playerOne': this.playerOne,
    };
  }
}

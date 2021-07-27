class LoginDto {
  final String pageTitle;
  final String profundityText;
  final String teamText;
  final Map<String, dynamic> welcomeVideo;

  LoginDto._({
    required this.pageTitle,
    required this.profundityText,
    required this.welcomeVideo,
    required this.teamText,
  });

  static LoginDto fromJson(Map<String, dynamic> payload) {
    return LoginDto._(
      pageTitle: payload["pageTitle"],
      profundityText: payload["profundityText"],
      welcomeVideo: payload["welcomeVideo"],
      teamText: payload["teamText"],
    );
  }
}

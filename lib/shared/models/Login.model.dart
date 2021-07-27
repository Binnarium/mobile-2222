class LoginDto {
  final String pageTitle;
  final String profundityText;
  final String teamText;
  final String workloadText;
  final Map<String, dynamic> welcomeVideo;

  LoginDto._(
      {required this.pageTitle,
      required this.profundityText,
      required this.welcomeVideo,
      required this.teamText,
      required this.workloadText
      });


  static LoginDto fromJson(Map<String, dynamic> payload) {
    String? pageTitle = payload['pageTitle'];
    String? profundityText = payload['profundityText'];
    Map<String, dynamic>? welcomeVideo = payload['welcomeVideo'];
    String? teamText = payload['teamText'];
    String? workloadText = payload['workloadText'];
    pageTitle == null ? pageTitle="Falta ingresar Texto": pageTitle=pageTitle;
    profundityText == null ? profundityText="Falta ingresar Texto": profundityText=profundityText;
    welcomeVideo == null ? welcomeVideo=Map(): welcomeVideo=welcomeVideo;
    teamText == null ? teamText="Falta ingresar Texto": teamText=teamText;
    workloadText == null ? workloadText="Falta ingresar Texto": workloadText=workloadText; 
    return LoginDto._(
      pageTitle: pageTitle,
      profundityText: profundityText,
      welcomeVideo: welcomeVideo,
      teamText: teamText,
      workloadText: workloadText
    );
  }
}

class FirebaseChapterSettings {
  String id;
  int primaryColor;
  String phaseName;
  String cityName;
  String chapterImageUrl;
  int? stage;
  Map<String, dynamic>? enabledPages;

  FirebaseChapterSettings({
    required this.id,
    required this.primaryColor,
    required this.phaseName,
    required this.cityName,
    required this.chapterImageUrl,
    this.enabledPages,
    this.stage,
  });

  static FirebaseChapterSettings fromJson(Map<String, dynamic> json) =>
      FirebaseChapterSettings(
        id: json["id"],
        primaryColor: json["configuration"]["colorHex"],
        phaseName: "etapa " + json["stage"].toString(),
        cityName: json["name"],
        chapterImageUrl: json["iconUrl"],
        enabledPages: json["enabledPages"],
        stage: json["stage"],
      );
}

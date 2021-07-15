class FirebaseChapterSettings {
  String id;
  int primaryColor;
  String phaseName;
  String cityName;
  String chapterImageUrl;
  Map<String, dynamic>? enabledPages;

  FirebaseChapterSettings._({
    required this.id,
    required this.primaryColor,
    required this.phaseName,
    required this.cityName,
    required this.chapterImageUrl,
    this.enabledPages,
  });

  static FirebaseChapterSettings fromJson(Map<String, dynamic> json) =>
      FirebaseChapterSettings._(
        id: json["id"],
        primaryColor: json["configuration"]["colorHex"],
        phaseName: "etapa " + json["stage"].toString(),
        cityName: json["name"],
        chapterImageUrl: json["iconUrl"],
        enabledPages: json["enabledPages"],
      );
}

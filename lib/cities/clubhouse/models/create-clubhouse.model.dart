class CreateClubhouseModel {
  final String id;
  final String cityId;
  final String clubhouseUrl;
  final String uploaderId;

  CreateClubhouseModel({
    required this.clubhouseUrl,
    required this.cityId,
    required this.uploaderId,
    required this.id,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'cityId': cityId,
      'clubhouseUrl': clubhouseUrl,
      'uploaderId': uploaderId,
    };
  }
}

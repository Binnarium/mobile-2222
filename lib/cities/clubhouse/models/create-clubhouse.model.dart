class CreateClubhouseModel {
  /// constructor
  CreateClubhouseModel({
    required this.clubhouseUrl,
    required this.cityId,
    required this.uploaderId,
    required this.id,
  });

  /// params
  final String id;
  final String cityId;
  final String clubhouseUrl;
  final String uploaderId;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'cityId': cityId,
      'clubhouseUrl': clubhouseUrl,
      'uploaderId': uploaderId,
    };
  }
}

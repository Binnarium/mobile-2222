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
    return {
      "id": this.id,
      "cityId": this.cityId,
      "clubhouseUrl": this.clubhouseUrl,
      "uploaderId": this.uploaderId,
    };
  }
}

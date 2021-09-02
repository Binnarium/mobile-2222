class ClubhouseModel {
  final String clubhouseUrl;
  final String clubhouseId;
  final DateTime date;
  final String name;
  final String cityId;
  final String uploaderId;
  final DateTime scraped;
  final String id;
  final String? uploaderDisplayName;

  ClubhouseModel({
    required this.clubhouseUrl,
    required this.clubhouseId,
    required this.date,
    required this.name,
    required this.cityId,
    required this.uploaderId,
    required this.scraped,
    required this.id,
    required this.uploaderDisplayName,
  });
}

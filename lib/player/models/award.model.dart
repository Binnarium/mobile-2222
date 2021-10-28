class AwardModel {
  AwardModel({
    required this.cityId,
    required this.obtained,
    this.sender,
  });
  
  AwardModel.fromMap(final Map<String, dynamic> payload)
      : cityId = payload['cityId'] as String?,
        obtained = payload['obtained'] as bool? ?? false,
        sender = payload['sender'] as String?;

  final String? cityId;
  final bool obtained;
  final String? sender;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'cityId': cityId,
      'obtained': obtained,
      if (sender != null) 'sender': sender,
    };
  }
}

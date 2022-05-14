/// Better video model
///
/// this model represents a video with more information that can be used,
class BetterVideoModel {
  BetterVideoModel({
    required this.hdUrl,
    required this.previewUrl,
    required this.sdUrl,
  });

  BetterVideoModel.fromMap(final Map<String, dynamic> payload)
      : hdUrl = payload['hdUrl'] as String?,
        sdUrl = payload['sdUrl'] as String?,
        previewUrl = payload['previewUrl'] as String?;

  final String? hdUrl;
  final String? sdUrl;
  final String? previewUrl;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'hdUrl': hdUrl,
      'sdUrl': sdUrl,
      'previewUrl': previewUrl,
    };
  }
}

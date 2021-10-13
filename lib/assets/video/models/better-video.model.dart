/// Better video model
///
/// this model represents a video with more information that can be used,
class BetterVideoModel {
  BetterVideoModel.fromMap(final Map<String, dynamic> payload)
      : vimeoId = payload['vimeoId'] as String?,
        isProcessed = (payload['isProcessed'] as bool?) == true,
        name = payload['name'] as String,
        path = payload['path'] as String,
        url = payload['url'] as String;

  final bool isProcessed;
  final String? vimeoId;
  final String name;
  final String path;
  final String url;
}

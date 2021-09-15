class SearchChatResponseModel {
  final String id;
  final String? name;
  final List<String> participantsUids;
  final List<String> participantsNames;

  SearchChatResponseModel.fromMap(Map<String, dynamic> map)
      : id = map['id'] as String,
        name = map['name'] as String?,
        participantsNames = (map['participantsNames'] as List)
            .map((dynamic e) => e as String)
            .toList(),
        participantsUids = (map['participantsUids'] as List)
            .map((dynamic e) => e as String)
            .toList();
}

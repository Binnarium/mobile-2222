class SearchChatResponseModel {
  final String id;
  final String? name;
  final List<String> participantsUids;
  final List<String> participantsNames;

  SearchChatResponseModel.fromMap(Map<String, dynamic> map)
      : this.id = map['id'],
        this.name = map['name'] ?? null,
        this.participantsNames =
            (map['participantsNames'] as List).map((e) => e as String).toList(),
        this.participantsUids =
            (map['participantsUids'] as List).map((e) => e as String).toList();
}

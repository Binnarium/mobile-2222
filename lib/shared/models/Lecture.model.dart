class LecturesDto {
  final String? about;
  final String? author;
  final String? coverUrl;
  final String? name;
  final String? link;
  final int? publishedDate;
  LecturesDto._({
    this.about,
    this.author,
    this.coverUrl,
    this.name,
    this.link,
    this.publishedDate,
  });

  static LecturesDto fromJson(Map<String, dynamic> payload) {
    return LecturesDto._(
      about: payload['about'],
      author: payload['author'],
      coverUrl: payload['cover']['url'],
      name: payload['name'],
      link: payload['link'],
      publishedDate: payload['publishedYear'],
    );
  }
}

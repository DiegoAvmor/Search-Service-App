class SearchResult {
  String name;
  String description;
  int ranking;

  SearchResult({this.name, this.description, this.ranking});

  factory SearchResult.fromJson(Map<String, dynamic> json) => SearchResult(
      name: json["name"],
      description: json["description"],
      ranking: json["ranking"]);
}

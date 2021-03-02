class SearchResult {
  String _name;
  String _description;
  int _ranking;

  SearchResult({name, description, ranking});

  String get name => this._name;

  set name(String value) => this._name = value;

  get description => this._description;

  set description(value) => this._description = value;

  get ranking => this._ranking;

  set ranking(value) => this._ranking = value;
}

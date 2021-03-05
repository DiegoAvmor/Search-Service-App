import 'package:rxdart/rxdart.dart';

class ServiceBloc {
  final _searchFlagController = BehaviorSubject<bool>();
  final _searchInputController = BehaviorSubject<String>();

  //Searchable
  Stream<bool> get search => _searchFlagController.stream;
  Function(bool) get changeSearchStatus => _searchFlagController.sink.add;
  bool get lastSearchFlagStatus => _searchFlagController.value;

  //Input
  Stream<String> get input => _searchInputController.stream;
  Function(String) get changeInput => _searchInputController.sink.add;
  String get lastInput => _searchInputController.value;

  dipose() {
    _searchInputController.close();
    _searchFlagController.close();
  }
}

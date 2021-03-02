import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:service_search_app/services/search_service.dart';
import 'validators/search_validator.dart';

class SearchBloc with SearchValidator {
  final _serviceController = BehaviorSubject<List<SearchService>>();
  final _dateController = BehaviorSubject<DateTime>();
  final _checkboxController = BehaviorSubject<Map<int, bool>>();

  Stream<DateTime> get date => _dateController.stream.transform(validateDate);
  Function(DateTime) get changeDate => _dateController.sink.add;

  Stream<Map<int, bool>> get mapModelCheckbox => _checkboxController.stream;
  Function(Map<int, bool>) get setCheckbox => _checkboxController.sink.add;

  Stream<List<SearchService>> get service =>
      _serviceController.stream.transform(validateServices);

  Function(List<SearchService>) get changeServices =>
      _serviceController.sink.add;

  dipose() {
    _serviceController.close();
    _dateController.close();
    _checkboxController.close();
  }
}

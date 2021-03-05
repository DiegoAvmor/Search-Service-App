import 'dart:async';
import 'dart:collection';
import 'package:rxdart/rxdart.dart';
import 'package:service_search_app/models/service_item.dart';
import 'package:service_search_app/providers/service_provider.dart';
import 'validators/search_validator.dart';

class SearchBloc with SearchValidator {
  final _dateController = BehaviorSubject<DateTime>();
  final _checkboxController = BehaviorSubject<Map<int, bool>>();
  //Repository
  final ServiceProvider provider = ServiceProvider();

  List<ServiceItem> currentServices = [];
  Map<int, ServiceItem> mapServiceCollection = HashMap<int, ServiceItem>();

  SearchBloc() {
    currentServices = provider.getServiceItems();
    for (var i = 0; i < currentServices.length; i++) {
      mapServiceCollection[i] = currentServices[i];
    }
    // Insert initial data in controller
    _checkboxController.stream.listen(_setCheckboxHandler);
  }

  _setCheckboxHandler(Map<int, bool> newMapCheckbox) {
    // New checkbox value for the itemModel id
    int id = newMapCheckbox.entries.elementAt(0).key;
    bool check = newMapCheckbox.entries.elementAt(0).value;
    if (mapServiceCollection.containsKey(id)) {
      mapServiceCollection[id].selected = check;
    }
  }

  List<ServiceItem> getSelectedServices() {
    try {
      List<ServiceItem> selectedServices = [];
      for (var selection in mapServiceCollection.entries) {
        if (selection.value.selected) {
          selectedServices.add(mapServiceCollection[selection.key]);
        }
      }
      return selectedServices;
    } catch (e) {
      return [];
    }
  }

  //Date
  Stream<DateTime> get date => _dateController.stream.transform(validateDate);
  Function(DateTime) get changeDate => _dateController.sink.add;
  DateTime get lastDateSelected => _dateController.value;

  //CheckBox
  Stream<Map<int, bool>> get mapModelCheckbox => _checkboxController.stream;
  Function(Map<int, bool>) get setCheckbox => _checkboxController.sink.add;
  Map<int, bool> get lastServiceSelected => _checkboxController.value;

  dipose() {
    _dateController.close();
    _checkboxController.close();
  }
}

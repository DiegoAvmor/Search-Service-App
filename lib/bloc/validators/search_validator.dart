import 'dart:async';
import 'package:service_search_app/services/search_service.dart';

class SearchValidator {
  final validateServices =
      StreamTransformer<List<SearchService>, List<SearchService>>.fromHandlers(
    handleData: (services, sink) {
      if (services.isNotEmpty) {
        sink.add(services);
      } else {
        sink.addError("No services selected");
      }
    },
  );

  final validateDate = StreamTransformer<DateTime, DateTime>.fromHandlers(
    handleData: (date, sink) {
      if (date != null) {
        sink.add(date);
      } else {
        sink.addError("No date selected");
      }
    },
  );
}

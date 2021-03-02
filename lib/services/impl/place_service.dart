import 'dart:developer' as developer;
import 'package:service_search_app/models/search_result.dart';
import 'package:service_search_app/services/search_service.dart';

class PlaceService extends SearchService {
  @override
  List<SearchResult> searchItem(String input) {
    // TODO: implement searchItem
    List<SearchResult> results = [];
    try {
      results = this.itemRepository.searchPlace(input);
      return results;
    } catch (e) {
      developer.log(e.toString());
      return results;
    }
  }
}

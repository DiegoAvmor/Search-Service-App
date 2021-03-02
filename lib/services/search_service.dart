import 'package:service_search_app/models/search_result.dart';

abstract class SearchService {
  List<SearchResult> searchItem(String input);
}

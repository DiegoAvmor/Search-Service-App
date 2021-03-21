import 'package:flutter/material.dart';
import 'package:service_search_app/models/search_result.dart';

abstract class SearchService {
  Future<List<SearchResult>> searchItem(String input);

  String getName();
  Icon getIcon();
}

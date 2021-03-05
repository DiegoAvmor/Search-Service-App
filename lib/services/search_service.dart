import 'package:flutter/material.dart';
import 'package:service_search_app/models/search_result.dart';
import 'package:service_search_app/repository/item_repository.dart';

abstract class SearchService {
  ItemRepository _itemRepository = new ItemRepository();
  ItemRepository get itemRepository => this._itemRepository;

  List<SearchResult> searchItem(String input);

  String getName();
  Icon getIcon();
}

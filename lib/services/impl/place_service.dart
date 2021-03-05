import 'dart:developer' as developer;
import 'package:flutter/material.dart';
import 'package:service_search_app/models/search_result.dart';
import 'package:service_search_app/services/search_service.dart';

class PlaceService extends SearchService {
  final String _name = 'Places';
  final Icon _icon = Icon(
    Icons.place,
    size: 35,
  );

  static final PlaceService _inst = PlaceService._internal();

  PlaceService._internal();

  factory PlaceService() {
    return _inst;
  }

  @override
  Future<List<SearchResult>> searchItem(String input) async {
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

  @override
  String getName() {
    return this._name;
  }

  @override
  Icon getIcon() {
    return this._icon;
  }
}

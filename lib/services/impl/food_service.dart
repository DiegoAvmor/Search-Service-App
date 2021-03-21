import 'dart:developer' as developer;
import 'package:flutter/material.dart';
import 'package:service_search_app/models/search_result.dart';
import 'package:service_search_app/providers/Database.dart';
import 'package:service_search_app/services/search_service.dart';

class FoodService extends SearchService {
  final String _name = 'Food';
  final Icon _icon = Icon(
    Icons.food_bank_rounded,
    size: 35,
  );
  static final FoodService _inst = FoodService._internal();

  FoodService._internal();

  factory FoodService() {
    return _inst;
  }
  @override
  Future<List<SearchResult>> searchItem(String input) async {
    try {
      return DBProvider.db.getAllFoodByName(input);
    } catch (e) {
      developer.log(e.toString());
      return [];
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

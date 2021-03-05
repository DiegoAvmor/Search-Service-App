import 'dart:developer' as developer;
import 'package:flutter/material.dart';
import 'package:service_search_app/models/search_result.dart';
import 'package:service_search_app/services/search_service.dart';

class MusicService extends SearchService {
  final String _name = 'Music';
  final Icon _icon = Icon(
    Icons.music_note_rounded,
    size: 35,
  );
  static final MusicService _inst = MusicService._internal();

  MusicService._internal();

  factory MusicService() {
    return _inst;
  }
  @override
  List<SearchResult> searchItem(String input) {
    // TODO: implement searchItem
    List<SearchResult> results = [];
    try {
      results = this.itemRepository.searchMusic(input);
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

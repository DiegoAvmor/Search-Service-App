import 'dart:developer' as developer;
import 'package:flutter/material.dart';
import 'package:service_search_app/models/search_result.dart';
import 'package:service_search_app/providers/Database.dart';
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
  Future<List<SearchResult>> searchItem(String input) async {
    try {
      return DBProvider.db.getAllMusicByName(input);
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

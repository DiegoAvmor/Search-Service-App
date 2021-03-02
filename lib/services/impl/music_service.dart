import 'dart:developer' as developer;
import 'package:service_search_app/models/search_result.dart';
import 'package:service_search_app/services/search_service.dart';

class MusicService extends SearchService {
  final String _name = 'Music';
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
}

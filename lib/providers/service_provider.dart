import 'package:flutter/material.dart';
import 'package:service_search_app/models/service_item.dart';
import 'package:service_search_app/services/impl/food_service.dart';
import 'package:service_search_app/services/impl/music_service.dart';
import 'package:service_search_app/services/impl/place_service.dart';
import 'package:service_search_app/services/search_service.dart';

class ServiceProvider {
  List<SearchService> services = [
    PlaceService(),
    MusicService(),
    FoodService(),
  ];

  List<ServiceItem> getServiceItems() {
    List<ServiceItem> items = [];
    for (var i = 0; i < services.length; i++) {
      items.add(
        ServiceItem(
          icon: services[i].getIcon(),
          name: services[i].getName(),
          service: services[i],
        ),
      );
    }
    return items;
  }
}

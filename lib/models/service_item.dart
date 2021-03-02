import 'package:flutter/material.dart';
import 'package:service_search_app/services/search_service.dart';

class ServiceItem {
  String name;
  bool selected = false;
  Icon icon;
  SearchService service;

  ServiceItem({this.name, this.icon, this.service});
}

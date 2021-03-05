import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:service_search_app/bloc/search_bloc.dart';
import 'package:service_search_app/models/service_item.dart';
import 'dart:developer' as developer;

import 'package:service_search_app/services/search_service.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<ServiceItem> services = [];
  DateTime dateSelected;
  bool isSearching = false;

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<SearchBloc>(context);
    dateSelected = bloc.lastDateSelected;
    services = bloc.getSelectedServices();
    return Scaffold(
      appBar: AppBar(
        title: !isSearching
            ? Text('Start your search')
            : TextField(
                autofocus: true,
                decoration: InputDecoration(
                    hintText: 'Search',
                    hintStyle: TextStyle(color: Colors.white, fontSize: 20),
                    border: InputBorder.none,
                    icon: Icon(
                      Icons.search,
                      color: Colors.white,
                    )),
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
        actions: [
          IconButton(
            icon: isSearching ? Icon(Icons.cancel) : Icon(Icons.search),
            onPressed: () {
              setState(() {
                isSearching = !isSearching;
              });
            },
          )
        ],
      ),
    );
  }
}

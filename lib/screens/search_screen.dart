import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:service_search_app/bloc/search_bloc.dart';
import 'package:service_search_app/bloc/service_bloc.dart';
import 'package:service_search_app/models/search_result.dart';
import 'package:service_search_app/models/service_item.dart';
import 'dart:developer' as developer;

import 'package:service_search_app/services/search_service.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final ServiceBloc serviceBloc = new ServiceBloc();
  bool isSearching = false;

  ListTile createTileFromResult(SearchResult result) {
    return ListTile(
      title: Text(result.name),
    );
  }

  List<ListTile> _genDummys(int amount) {
    List<ListTile> dummy = [];
    for (var i = 0; i < amount; i++) {
      dummy.add(createTileFromResult(new SearchResult(name: "Busqueda #$i")));
    }
    return dummy;
  }

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<SearchBloc>(context);
    final List<ServiceItem> serviceItems = bloc.getSelectedServices();
    final DateTime dateSelected = bloc.lastDateSelected;

    return Scaffold(
      appBar: AppBar(
        title: StreamBuilder(
          stream: serviceBloc.search,
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data) {
              return TextField(
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
                onSubmitted: (input) {
                  serviceBloc.changeInput(input);
                },
              );
            } else {
              return Text('Start your search');
            }
          },
        ),
        actions: [
          IconButton(
            icon: isSearching ? Icon(Icons.cancel) : Icon(Icons.search),
            onPressed: () {
              setState(() {
                isSearching = !isSearching;
                serviceBloc.changeSearchStatus(isSearching);
              });
            },
          )
        ],
      ),
      body: StreamBuilder(
        stream: serviceBloc.input,
        builder: (context, snapshot) {
          developer.log(snapshot.data.toString());
          if (snapshot.hasData && serviceBloc.lastSearchFlagStatus) {
            return ListView.builder(
              itemCount: serviceItems.length,
              itemBuilder: (context, int index) {
                return FutureBuilder(
                  future: serviceItems[index]
                      .service
                      .searchItem(serviceBloc.lastInput),
                  builder: (context, snapshot) {
                    developer.log(snapshot.data.toString());
                    if (snapshot.hasData /*&& snapshot.data.length > 0*/) {
                      return Column(
                        children: _genDummys(6),
                      );
                    } else {
                      return Container(
                        alignment: Alignment.center,
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                );
              },
            );
          }
          return Container(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.search_rounded,
                  size: 50,
                ),
                Text(
                  'Realice una busqueda',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

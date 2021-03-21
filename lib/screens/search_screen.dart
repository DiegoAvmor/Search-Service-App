import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:service_search_app/bloc/search_bloc.dart';
import 'package:service_search_app/bloc/service_bloc.dart';
import 'package:service_search_app/models/search_result.dart';
import 'package:service_search_app/models/service_item.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final ServiceBloc serviceBloc = new ServiceBloc();
  bool isSearching = false;

  Color _rankColorSelector(int ranking) {
    if (ranking <= 5) {
      return Colors.red;
    }
    if (ranking > 5 && ranking <= 7) {
      return Colors.yellow;
    }
    return Colors.green;
  }

  List<Card> createTileFromResult(List<SearchResult> results, Icon resultIcon) {
    List<Card> serviceList = [];
    results.forEach((result) {
      serviceList.add(
        Card(
          child: ListTile(
            leading: resultIcon,
            title: Text(result.name),
            subtitle: Text(result.description),
            trailing: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _rankColorSelector(result.ranking),
              ),
              child: Center(
                child: Text(
                  result.ranking.toString(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ),
      );
    });
    return serviceList;
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
                serviceBloc.changeInput(null);
              });
            },
          )
        ],
      ),
      body: StreamBuilder(
        stream: serviceBloc.input,
        builder: (context, snapshot) {
          if (snapshot.hasData && serviceBloc.lastSearchFlagStatus) {
            return ListView.builder(
              itemCount: serviceItems.length,
              itemBuilder: (context, int index) {
                return FutureBuilder(
                  future: serviceItems[index]
                      .service
                      .searchItem(serviceBloc.lastInput),
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                        return Container(
                          alignment: Alignment.center,
                          child: CircularProgressIndicator(),
                        );
                        break;
                      case ConnectionState.done:
                        if (snapshot.hasData && snapshot.data.length > 0) {
                          return Column(
                            children: createTileFromResult(
                                snapshot.data, serviceItems[index].icon),
                          );
                        } else {
                          return Container();
                        }
                        break;
                      default:
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
                Text(
                  '╚(•⌂•)╝',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 35,
                  ),
                ),
                Text(
                  'Well, nothing was found.',
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

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:service_search_app/bloc/search_bloc.dart';
import 'package:service_search_app/services/impl/food_service.dart';
import 'package:service_search_app/services/impl/music_service.dart';
import 'package:service_search_app/services/impl/place_service.dart';
import 'package:service_search_app/services/search_service.dart';
import 'dart:developer' as developer;

class HomeScreen extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<HomeScreen> {
  final DateFormat formatter = DateFormat('yyyy-MM-dd');
  DateTime selectedDate;

  List<SearchService> services = [];

  Map<String, bool> checkBoxList = {
    'Place': false,
    'Food': false,
    'Music': false
  };

  List<SearchService> _addService(SearchService service) {
    services.add(service);
    return services;
  }

  List<SearchService> _removeService(SearchService oldService) {
    services.removeWhere((service) => service == oldService);
    return services;
  }

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<SearchBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Main'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              Navigator.pushNamed(context, '/search');
            },
          )
        ],
      ),
      body: Container(
        margin: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: EdgeInsets.all(40),
                  child: Placeholder(
                    fallbackHeight: 40,
                    fallbackWidth: 40,
                  ),
                ),
                Flexible(
                  child: Text(
                    'Please add the events main information. Date is very important in order to give you amazing results',
                    textAlign: TextAlign.justify,
                    style: TextStyle(fontSize: 15),
                  ),
                ),
              ],
            ),
            ListTile(
              leading: Icon(
                Icons.calendar_today_sharp,
                color: Colors.red,
                size: 30,
              ),
              title: Text("Event Date"),
              subtitle: Text(selectedDate == null
                  ? "No date selected"
                  : formatter.format(selectedDate)),
              onTap: () {
                showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime.now().add(
                    new Duration(days: 600),
                  ),
                ).then((newdate) {
                  setState(() {
                    selectedDate = newdate;
                  });
                });
              },
            ),
            StreamBuilder(
              stream: bloc.service,
              builder: (context, snapshot) {
                return Column(
                  children: [
                    CheckboxListTile(
                      title: Text('Place'),
                      controlAffinity: ListTileControlAffinity.leading,
                      value: checkBoxList['Place'],
                      secondary: Icon(
                        Icons.place,
                        size: 35,
                      ),
                      onChanged: (bool value) {
                        setState(() {
                          checkBoxList['Place'] = value;
                          services = value
                              ? _addService(PlaceService())
                              : _removeService(PlaceService());
                          bloc.changeServices(services);
                        });
                      },
                    ),
                    CheckboxListTile(
                      title: Text('Food'),
                      controlAffinity: ListTileControlAffinity.leading,
                      value: checkBoxList['Food'],
                      secondary: Icon(
                        Icons.food_bank,
                        size: 35,
                      ),
                      onChanged: (bool value) {
                        setState(() {
                          checkBoxList['Food'] = value;
                          services = value
                              ? _addService(FoodService())
                              : _removeService(FoodService());
                          bloc.changeServices(services);
                        });
                      },
                    ),
                    CheckboxListTile(
                      title: Text('Music'),
                      controlAffinity: ListTileControlAffinity.leading,
                      value: checkBoxList['Music'],
                      secondary: Icon(
                        Icons.library_music,
                        size: 35,
                      ),
                      onChanged: (bool value) {
                        setState(() {
                          checkBoxList['Music'] = value;
                          services = value
                              ? _addService(MusicService())
                              : _removeService(MusicService());
                          bloc.changeServices(services);
                        });
                      },
                    )
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

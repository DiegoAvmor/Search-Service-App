import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:service_search_app/bloc/search_bloc.dart';
import 'package:service_search_app/models/service_item.dart';
import 'package:service_search_app/providers/service_provider.dart';
import 'package:service_search_app/services/search_service.dart';
import 'dart:developer' as developer;

class HomeScreen extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<HomeScreen> {
  final DateFormat formatter = DateFormat('yyyy-MM-dd');
  final ServiceProvider provider = new ServiceProvider();

  StreamBuilder buildCheckBox(SearchBloc bloc, ServiceItem service, int index) {
    return StreamBuilder(
      stream: bloc.mapModelCheckbox,
      builder: (context, snapshot) {
        return CheckboxListTile(
          title: Text(service.name),
          controlAffinity: ListTileControlAffinity.leading,
          value: snapshot.hasData,
          onChanged: (bool value) {},
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final serviceItems = provider.getServiceItems();
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
            StreamBuilder(
              stream: bloc.date,
              builder: (context, snapshot) {
                return ListTile(
                  leading: Icon(
                    Icons.calendar_today_sharp,
                    color: Colors.red,
                    size: 30,
                  ),
                  title: Text("Event Date"),
                  subtitle: Text(snapshot.hasData
                      ? formatter.format(snapshot.data)
                      : 'No date Selected'),
                  onTap: () {
                    showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(
                        new Duration(days: 600),
                      ),
                    ).then(bloc.changeDate);
                  },
                );
              },
            ),
            for (var i = 0; i < serviceItems.length; i++)
              buildCheckBox(bloc, serviceItems.elementAt(i), i)
            /*
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
            ),*/
          ],
        ),
      ),
    );
  }
}

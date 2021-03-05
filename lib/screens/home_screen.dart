import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:service_search_app/bloc/search_bloc.dart';
import 'package:service_search_app/models/service_item.dart';

class HomeScreen extends StatelessWidget {
  final DateFormat formatter = DateFormat('yyyy-MM-dd');

  StreamBuilder buildCheckBox(SearchBloc bloc, ServiceItem service, int index) {
    return StreamBuilder(
      stream: bloc.mapModelCheckbox,
      builder: (context, snapshot) {
        return CheckboxListTile(
          title: Text(bloc.mapServiceCollection[index].name),
          secondary: bloc.mapServiceCollection[index].icon,
          controlAffinity: ListTileControlAffinity.leading,
          value: bloc.mapCheckboxCollection[index],
          onChanged: (bool value) =>
              bloc.setCheckbox(<int, bool>{index: value}),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<SearchBloc>(context);
    final serviceItems = bloc.currentServices;
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
              buildCheckBox(bloc, serviceItems[i], i)
          ],
        ),
      ),
    );
  }
}

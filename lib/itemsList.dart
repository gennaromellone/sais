import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import 'itemPage.dart';
//import 'package:mytiluse/itemPage.dart';

const String apiBase= 'https://api.meteo.uniparthenope.it';
const List<String> status_label = ['Dato non disponibile', 'Rischio nullo', 'Rischio basso', 'Rischio medio', 'Rischio elevato'];
//const List<String> locations = ["VET0130", "VET0020", "VET0021", "VET0072", "VET0071", "VET0100", "VET0062", "VET0150", "VET0055", "VET0054", "VET0056", "VET0051", "VET0050", "VET0053", "VET0052", "VET0121", "VET0123", "VET0122", "VET0125", "VET0124", "VET0000", "VET0031", "VET0030", "VET0140", "VET0061", "VET0063", "VET0064", "VET0110", "VET0010", "VET0160", "VET0057", "VET0042", "VET0041"];

class Sais{
  String? dateTime;
  int? index;

  Sais({this.dateTime, this.index});
}
class Rows {
  int? id;
  String? name;
  double? lat;
  double? lon;
  List<Sais>? status;

  Rows({this.id, this.name, this.lat, this.lon, this.status});
}



Future<List> getItems(bool isLogged, String date, locations) async {
  List<Rows> list = <Rows>[];
  final response = await http.get(Uri.parse(apiBase + "/apps/sais/index"));
  if (response.statusCode == 200) {

    var data = jsonDecode(response.body);

    var features = data['sam3']['features'];
    for (int i=0; i < features.length; i++){
      var id = int.parse(features[i]['properties']['id']);
      var lat = features[i]['geometry']['coordinates'][1];
      var lon = features[i]['geometry']['coordinates'][0];
      var name = features[i]['properties']['name'];
      //var area = 'Bagnoli/Pozzuoli';
      var alert_status = features[i]['properties']['sais'];
      List<Sais> alerts = <Sais>[];
      for(var x=0; x < alert_status.length; x++){
        alerts.add(Sais(dateTime: alert_status[x]['dateTime'], index: alert_status[x]['index']));
      }

      var item = Rows(id: id, name:name, lat:lat, lon: lon, status: alerts);
      //var item = Row(id: id, name: name, area: scs, status: status);
      print(item);
      list.add(item);
    }
  }

  return list;
}

class ListLayout extends StatefulWidget {
  final String date;
  final List<String> locations;

  ListLayout({required this.date, required this.locations});

  @override
  _ListLayoutState createState() => _ListLayoutState();
}

class _ListLayoutState extends State<ListLayout> {
  void refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var date = formatData(widget.date);
    var locations = widget.locations;
    return Scaffold(
        body: Center(
          child: FutureBuilder(
              future: getItems(true, date, locations),
              builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
                if (snapshot.hasData){
                  var items = snapshot.data;
                  return ListView.builder(
                    itemBuilder: (BuildContext context, int index) {
                      var item = items![index];
                      return Card(
                        child: ListTile(
                          onTap: (){
                            Navigator.push(
                             context,
                              MaterialPageRoute(builder: (context) => ItemPage(item: item, date: date)),
                            );
                          },
                          title: Text(item.name),
                          subtitle: Text(item.name),
                          //leading: Image(image: AssetImage('resources/status/' + item.status[0].index.toString() + '.png'),height: 50,),
                        ),
                      );
                    },
                    itemCount: items == null ? 0 : items.length,
                  );
                }
                else if (snapshot.hasError){
                  return Text("${snapshot.error}");
                }
                // By default, show a loading spinner
                return CircularProgressIndicator();
              }
          ),
        )
    );
  }

  String formatData(data){
    final _date = DateTime.parse(data);
    final DateFormat formatter = DateFormat('yyyyMMdd HH00');
    final String formattedDate = formatter.format(_date).replaceAll(" ", "Z");

    return formattedDate;
  }
}
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import 'itemPage.dart';

const String apiBase= 'https://api.meteo.uniparthenope.it';
//const List<String> status_label = ['Dato non disponibile', 'Rischio nullo', 'Rischio basso', 'Rischio medio', 'Rischio elevato'];
const List<String> status_label = ['Very Low', 'Low', 'Medium', 'High', 'Very High'];


class Sais{
  String? dateTime;
  int? index;

  Sais({this.dateTime, this.index});
}
class Rows {
  int? id;
  String? name;
  String? area;
  double? lat;
  double? lon;
  List<Sais>? status;

  Rows({this.id, this.name, this.area , this.lat, this.lon, this.status});
}
String convertDatetime(date){

  DateTime dt = DateTime.parse(date.replaceAll("Z", " "));
  String dateFormat = DateFormat('EEEE dd-MM-yyyy hh:mm').format(dt);

  return dateFormat + " UTC";
}

Future<List> getItems() async {
  List<Rows> list = <Rows>[];
  final response = await http.get(Uri.parse(apiBase + "/apps/sais/index"));
  print(response.statusCode);
  if (response.statusCode == 200) {

    var data = jsonDecode(response.body);

    var features = data['sam3']['features'];
    for (int i=0; i < features.length; i++){
      var id = int.parse(features[i]['properties']['id']);
      var lat = features[i]['geometry']['coordinates'][1];
      var lon = features[i]['geometry']['coordinates'][0];
      var name = features[i]['properties']['name'];
      var area = features[i]['properties']['area'];
      var alert_status = features[i]['properties']['sais'];
      List<Sais> alerts = <Sais>[];
      for(var x=0; x < alert_status.length; x++){
        alerts.add(Sais(dateTime: convertDatetime(alert_status[x]['dateTime']) , index: alert_status[x]['index']));
      }
      var item = Rows(id: id, name:name, area:area ?? '', lat:lat, lon: lon, status: alerts);
      //var item = Row(id: id, name: name, area: scs, status: status);
      list.add(item);
    }

  }
  else{

    print("ERROR");
  }
  list.sort((a, b) => a.name!.compareTo(b.name!));
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

    return Scaffold(
        body: Center(
          child: FutureBuilder(
              future: getItems(),
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
                              MaterialPageRoute(builder: (context) => ItemPage(item: item)),
                            );
                          },
                          title: Text(item.name),
                          subtitle: Text(item.area),
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
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import 'itemsList.dart';


class ItemPage extends StatefulWidget{
  final Rows item;
  final String date;

  const ItemPage({required this.item, required this.date});

  @override
  ItemPageState createState() => ItemPageState();

}
class ItemPageState extends State<ItemPage>{



  static const TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);


  @override
  void initState() {

    super.initState();
  }



  void _onItemTapped(int index) {
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: Color.fromRGBO(0, 96, 160, 1.0),
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.item.name!,
              style: TextStyle(color: Colors.white, fontSize: 16.0),
            ),

          ],
        ),
        actions: <Widget>[new Icon(Icons.more_vert)],
      ),


      body: Container(
        child: Column(
          children: [
            Expanded(
                flex: 1,
                child:
                FlutterMap(
                  options: MapOptions(
                    center: LatLng(widget.item.lat!, widget.item.lon!),
                    zoom: 13.0,
                  ),
                  layers: [
                    TileLayerOptions(
                      urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                      subdomains: ['a', 'b', 'c'],
                      attributionBuilder: (_) {
                        return Text("© OpenStreetMap contributors");
                      },
                    ),
                    MarkerLayerOptions(
                      markers: [
                        Marker(
                          width: 30.0,
                          height: 30.0,
                          point: LatLng(widget.item.lat!, widget.item.lon!),
                          builder: (ctx) =>
                              Icon(Icons.pin_drop)
                        ),
                      ],
                    ),
                  ],
                )
            ),
            Expanded(
              flex: 3,
              child:  ListView.builder(
              itemCount: widget.item.status!.length,
              itemBuilder: (BuildContext context, int index) {
                var it = widget.item.status![index].index;
                return SizedBox(
                  height: 35,
                  child: Card(
                    semanticContainer: true,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: SizedBox(
                      height: 35,
                      child: Row(
                          children: [
                            Expanded(flex:3, child: Image(image: AssetImage('resources/status/'+ it.toString() +'.png'),height: 20,)),
                            Expanded(flex: 7,child: Text(widget.item.status![index].dateTime!.toString())),
                            Expanded(flex:10,child: Text(status_label[it!]))


                          ]
                      ),
                    ),
                  ),
                );
              },

            ),)
          ],
        )

    )
    );
  }
}
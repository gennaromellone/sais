import 'package:flutter/material.dart';
import 'dart:developer';
import 'package:date_time_picker/date_time_picker.dart';
import 'about.dart';

import 'itemsList.dart';


class Sais extends StatefulWidget{
  //final bool isLogged;

  //Sais({required this.isLogged});
  Sais();

  @override
  _SaisState createState() => _SaisState();

}

class _SaisState extends State<Sais>{
  String text = "Update";
  List<String> vetLocations = ["VET0130", "VET0020", "VET0021", "VET0072", "VET0071", "VET0100", "VET0062", "VET0150", "VET0055", "VET0054", "VET0056", "VET0051", "VET0050", "VET0053", "VET0052", "VET0121", "VET0123", "VET0122", "VET0125", "VET0124", "VET0000", "VET0031", "VET0030", "VET0140", "VET0061", "VET0063", "VET0064", "VET0110", "VET0010", "VET0160", "VET0057", "VET0042", "VET0041"];

  var date = DateTime.now().toString();
  static const TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  void refresh() {
    setState(() {});
  }

  List<Widget> _widgetOptions = <Widget>[
    ListLayout(date: DateTime.now().toString(), locations: []),
  ];

  @override
  void initState() {
    _widgetOptions = <Widget>[
      ListLayout(date: DateTime.now().toString(), locations: vetLocations),
    ];
    super.initState();
  }

  void _handleRefresh(val) {
    print(val);
    setState(() {
      _widgetOptions = <Widget>[
        ListLayout(date: val, locations: vetLocations),
      ];
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('SAIS', style: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic, fontFamily: 'Georgia'),),
        backgroundColor: Color.fromRGBO(0, 96, 160, 1.0),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.info),
            tooltip: 'About',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AboutPage()),
                //MaterialPageRoute(builder: (context) => ItemPage(title: "Test")),
              );
            },
          )
        ],
      ),
      body: Container(
          child: Column(mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                Expanded(
                  flex: 10,
                  child: Center( child: _widgetOptions.elementAt(0),),
                ),
                // Draw legend
                Expanded(
                  flex: 2,
                  child: Container(
                      alignment: Alignment.centerLeft,
                    child:  Column(
                      children: [
                      const Text("Codici della previsione inondazione: ", style: TextStyle(
                        fontSize: 12.0
                        )
                      ),
                        Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Expanded(
                            child: Row (
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                    child:
                                Row(children: [
                                  Image.asset('resources/status/0.png',height: 15,),
                                  SizedBox(width: 25),
                                  Text(status_label[0], style: TextStyle(
                                      fontSize: 12.0
                                  )),
                                ],)
                                ),
                                Expanded(
                                    child:
                                    Row(children: [
                                      Image.asset('resources/status/3.png',height: 15,),
                                      SizedBox(width: 25),
                                      Text(status_label[3], style: TextStyle(
                                          fontSize: 12.0
                                      )),
                                    ],)
                                ),

                              ]),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Expanded(
                            child: Row (
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                      child:
                                      Row(children: [
                                        Image.asset('resources/status/1.png',height: 15,),
                                        SizedBox(width: 25),
                                        Text(status_label[1], style: TextStyle(
                                            fontSize: 12.0
                                        )),
                                      ],)
                                  ),
                                  Expanded(
                                      child:
                                      Row(children: [
                                        Image.asset('resources/status/4.png',height: 15,),
                                        SizedBox(width: 25),
                                        Text(status_label[4], style: TextStyle(
                                            fontSize: 12.0
                                        )),
                                      ],)
                                  ),

                                ]),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Expanded(
                            child: Row (
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                      child:
                                      Row(children: [
                                        Image.asset('resources/status/2.png',height: 15,),
                                        SizedBox(width: 25),
                                        Text(status_label[2], style: TextStyle(
                                            fontSize: 12.0
                                        )),
                                      ],)
                                  ),
                                ]),
                          ),
                        ),
                      ]
                    )
                  ),
                ),
              ]
          )
      )
    );
  }

}
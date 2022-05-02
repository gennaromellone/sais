import 'package:flutter/material.dart';
import 'itemsList.dart';
import 'main.dart';

class Team {
  String name;
  String picture;
  String role;
  String mail;

  Team({required this.name, required this.picture, required this.role, required this.mail});
}

List<Team> getTeam(){

  List<Team> list = <Team>[];

  list.add(Team(name: 'Raffaele Montella', picture: 'resources/team/rmontella_64x64.png', role: 'Project Leader', mail: 'raffaele.montella@uniparthenope.it'));
  list.add(Team(name: 'Diana Di Luccio', picture: 'resources/team/ddiluccio_64x64.png', role: 'Data Manager', mail: 'diana.diluccio@uniparthenope.it'));

  list.add(Team(name: 'Gennaro Mellone', picture: 'resources/team/gmellone_64x64.png', role: 'Developer', mail: 'gennaro.mellone@uniparthenope.it'));
  list.add(Team(name: 'Ciro Giuseppe De Vita', picture: 'resources/team/cgdevita_64x64.png', role: 'Developer', mail: 'cirogiuseppe.devita@uniparthenope.it'));

  return list;
}

class AboutPage extends StatelessWidget {
  final List<Team> items = getTeam();

  AboutPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("About", style: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic, fontFamily: 'Georgia'),),
        backgroundColor: Color.fromRGBO(0, 96, 160, 1.0),
      ),
      body:
      Container(
        child: Column(
          children: <Widget> [
            Container(
                padding: EdgeInsets.only(left: 20,top: 50),
                child:  Column(
                  children: const [
                    Text('SAIS',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: 'Aleo',
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.bold,
                            fontSize: 25.0,
                            color: Colors.black
                        )
                    ),
                    Text("https://meteo.uniparthenope.it/sais", style: TextStyle(
                        fontSize: 16.0
                    ),
                    ),
                    Text(""),
                    Text("Dipartimento di Scienze e Tecnologie", style: TextStyle(
                        fontSize: 16.0
                    ),
                    ),
                    Text("Università degli Studi di Napoli 'Parthenope'", style: TextStyle(
                        fontSize: 16.0
                    ),
                    )
                  ],
                )

            ),
            Image.asset('resources/saisLogo.png', height: 300,),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: const Text("Le valutazioni di rischio si riferiscono unicamente alle azioni sulle spiagge delle onde da vento e non possono tenere in conto di altri effetti naturali o antropici quali frane, tsunami, passaggio di natanti. Tantomeno si applicano al rischio per i bagnanti in acqua. ", style: TextStyle(
                  fontSize: 12.0
              )),
            ),
            const Text('Team: ',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: 'Aleo',
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.bold,
                    fontSize: 25.0,
                    color: Colors.black
                )
            ),

            Expanded(
              flex: 4,
                child: ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (BuildContext context, int index) {
                    var item = items[index];

                    return ListTile(
                      onTap: (){
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('Contact at: ' + item.mail),
                        ));
                      },

                      title: Text(item.name),
                      subtitle: Text(item.role ),
                      leading: Image(image: AssetImage(item.picture),height: 50,),
                    );
                  },

                )
            ),
            Expanded(
              flex: 2,
              child: Container(
                  alignment: Alignment.centerLeft,
                  child:  Column(
                      children: [
                        const Text("Codici della previsione inondazione: ", style: TextStyle(
                            fontSize: 12.0
                        )),

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
          ],
        ),
      ),

    );
  }
}

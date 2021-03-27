import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rick_and_morty/presentation/custom_icons_icons.dart';
import 'package:rick_and_morty/screens/persondetails/loader.dart';

class PersonDetailsPage extends StatefulWidget {
  PersonDetailsPage({Key key, this.id}) : super(key: key);
  final int id;

  @override
  _State createState() => _State(id: id);
}

class _State extends State<PersonDetailsPage> {
  _State({this.id}) : super();

  bool progress = false;
  int id;
  PersonDetails person;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() async {
    progress = false;
    var personInfo = await loadPerson(id);
    setState(() {
      person = personInfo;
    });
    progress = true;
  }

  @override
  Widget build(BuildContext context) {
    var widget;
    if (person != null)
      widget =
        Align(
          alignment: Alignment.topCenter,
          child: SafeArea(
            child: Column(
              children: [
                GestureDetector(
                  child: Container(
                    height: 250.0,
                    width: 250.0,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.fill,
                          image: NetworkImage(person.avatar)
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(125.0)),
                    )
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 8.0, bottom: 12.0),
                  child: Column(
                    children: [
                      Text(
                          person.name.toUpperCase(),
                          style: TextStyle(
                            fontSize: 24
                          ),
                      ),
                      Text(
                          person.species,
                          style: TextStyle(
                              fontSize: 20,
                              fontStyle: FontStyle.italic,
                              color: Colors.grey[500],
                          ),
                      ),
                    ]
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 8.0, right: 8.0),
                  child: Row(
                      children: [
                        SizedBox(width: 50),
                        Column(
                            children: [
                              Text(
                                person.gender,
                                style: TextStyle(
                                    fontSize: 20
                                ),
                              ),
                              Text(
                                "Gender",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.blue[300],
                                ),
                              ),
                            ]
                        ),

                        SizedBox(width: 50),

                        Column(
                            children: [
                              Text(
                                person.status,
                                style: TextStyle(
                                    fontSize: 20
                                ),
                              ),
                              Text(
                                "Status",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.blue[300],
                                ),
                              ),
                            ]
                        ),

                        SizedBox(width: 50),

                        Column(
                            children: [
                              Text(
                                person.created,
                                style: TextStyle(
                                    fontSize: 20
                                ),
                              ),
                              Text(
                                "Created",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.blue[300],
                                ),
                              ),
                            ]
                        ),
                      ]
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20.0),
                  child:TextButton (
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              side: BorderSide(color: Colors.grey[500])
                          )
                      )
                    ),
                    child: Text(
                      person.locationName,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                      ),
                    ),
                  )
                ),
              ],
            ),
          ),
        );

    return Scaffold(
      appBar: AppBar(
        title: person != null ? Text("${person.name}") : Text(""),
      ),
      body: widget,
    );
  }

  Icon getStatusIcon() {
    switch(person.status){
      case "Alive":{
        return Icon(CustomIcons.angel_wings, size: 200);
      }
      break;
      case "Dead":{
        return Icon(CustomIcons.book_dead, size: 200);
      }
      break;

      default: {
        return Icon(CustomIcons.uncertainty, size: 200);
      }
      break;
    }
  }
}
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;


class Person{
  int id;
  String name;
  String status;
  String icon;
}

Future<List<Person>> loadPersons() async{
  var response = await http.get(Uri.parse("https://rickandmortyapi.com/api/character"));
  List<Person> persons = [];

  if (response.statusCode == 200){
    var jsonResponse = convert.jsonDecode(response.body);
    List<dynamic> resultsLists = jsonResponse["results"];

    for(var result in resultsLists){
      Person person = Person();
      person.id = result["id"];
      person.name  = result["name"];
      person.status = result["status"];
      person.icon = result["image"];
      persons.add(person);
    }
  }

  return persons;
}

Future<List<Person>> filteringPersons(Map<String, String> filterParams) async{

  var uri = Uri.https('rickandmortyapi.com', '/api/character/', filterParams);
  var response = await http.get(uri);
  List<Person> persons = [];

  if (response.statusCode == 200){
    var jsonResponse = convert.jsonDecode(response.body);
    List<dynamic> resultsLists = jsonResponse["results"];

    for(var result in resultsLists){
      Person person = Person();
      person.id = result["id"];
      person.name  = result["name"];
      person.status = result["status"];
      person.icon = result["image"];

      persons.add(person);
    }
  }

  return persons;
}


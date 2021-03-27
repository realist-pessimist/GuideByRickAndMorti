import 'package:easy_loader/easy_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rick_and_morty/alertdialog/FilterDialog.dart';
import 'package:rick_and_morty/screens/persondetails/person_details_page.dart';
import 'package:rick_and_morty/screens/personlist/loader.dart';




class PersonListPage extends StatefulWidget {
  PersonListPage({Key key}) : super(key: key);

  @override
  _PersonListPageState createState() => _PersonListPageState();
}

class _PersonListPageState extends State<PersonListPage> {
  var searchView = new TextEditingController();
  bool progress = false;
  bool firstSearch = true;
  String query = "";
  List<Person> filterList = [];
  List<Person> persons = [];

  FilterDialog filterDialog;

  @override
  void initState() {
    super.initState();
    loadData();
    filterDialog = FilterDialog(this.filterData);
  }

  _PersonListPageState(){
    searchView.addListener(() {
      if (searchView.text.isEmpty){
        setState(() {
          firstSearch = true;
          query ="";
        });
      }
      else{
        setState(() {
          firstSearch = false;
          query = searchView.text;
        });
      }
    });
  }

  void loadData() async {
    progress = false;
    var personList = await loadPersons();
    setState(() {
      persons = personList;
    });
    progress = true;
  }

  void filterData(Map<String, String> filterParams) async {
    Navigator.of(context).pop();
    FocusScope.of(context).unfocus();
    progress = false;
    var personList = await filteringPersons(filterParams);
    setState(() {
      persons = personList;
    });
    progress = true;
  }

  void navigateToDetails(int personId) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PersonDetailsPage(id: personId),
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SafeArea(
            child: RefreshIndicator(
              child: new Column(
                children:<Widget>[
                  createSearchView(),
                  firstSearch? createListView() : performSearch()
                ],
              ),
              onRefresh: (){
                return Future.delayed(
                    Duration(seconds: 1),
                    (){
                      query = "";
                      searchView.text = "";
                      FocusScope.of(context).unfocus();
                      loadData();
                    },
                );
              },
            ),
          ),
          Visibility(
            child: EasyLoader(image: AssetImage('assets/animations/custom_preloader.gif'), iconSize: 200.0),
            visible: !progress,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () => openFilterDialog(context),
          backgroundColor: Colors.black,
          tooltip: 'Increment',
          child: Icon(Icons.filter_alt_sharp),
      ),
    );
  }

  Widget createSearchView() {
    return new Container(
      margin: const EdgeInsets.only(left: 16.0),
      child: new TextField(
        controller: searchView,
        decoration: InputDecoration(
          icon: Icon(Icons.search),
          hintText: "Search",
          hintStyle: new TextStyle(
              color: Colors.grey[300],
          ),
        ),
        textAlign: TextAlign.left,
      ),
    );
  }

  Widget createListView() {
    return new Flexible(
        child: Container(
          margin: const EdgeInsets.only(left: 6.0),
          child: new ListView.builder(
            physics: const AlwaysScrollableScrollPhysics(),
            itemCount: persons.length,
            itemBuilder: (BuildContext context, int index) {
              return new GestureDetector(
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundImage: NetworkImage(persons[index].icon),
                    ),
                    Padding(
                      padding: EdgeInsets.all(15),
                      child: Text(
                        persons[index].name,
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ],
                ),
                onTap: () => navigateToDetails(persons[index].id),
              );
            }),
        ),
    );
  }

  Widget performSearch() {
    filterList.clear();
    for (int i = 0; i < persons.length; i++) {
      var item = persons[i];

      if (item.name.toLowerCase().contains(query.toLowerCase())) {
        filterList.add(item);
      }
    }
    return createFilteredListView();
  }

  Widget createFilteredListView() {
    return new Flexible(
      child: new ListView.builder(
          physics: const AlwaysScrollableScrollPhysics(),
          itemCount: filterList.length,
          itemBuilder: (BuildContext context, int index) {
            return new GestureDetector(
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundImage: NetworkImage(filterList[index].icon),
                  ),
                  Padding(
                    padding: EdgeInsets.all(15),
                    child: Text(
                      filterList[index].name,
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                ],
              ),
              onTap: () => navigateToDetails(filterList[index].id),
            );
          }),
    );
  }

  void openFilterDialog(context) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return alert dialog object
        return filterDialog;
      },
    );
  }
}
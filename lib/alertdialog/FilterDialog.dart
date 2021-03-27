import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class FilterDialog extends StatefulWidget {
  Function filterData;
  FilterDialog(this.filterData);

  @override
  _FilterDialogState createState() => new _FilterDialogState();
}

class _FilterDialogState extends State<FilterDialog> {

  String _value1;
  String _value2;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: new Text('Select filtering params'),
      content: Container(
        height: 200.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            new Row(
              children: <Widget>[
                DropdownButton<String>(
                    hint: Text("Select status"),
                    value: _value1,
                    items: [
                      DropdownMenuItem(
                        child: Text('Alive'),
                        value: 'alive',
                      ),
                      DropdownMenuItem(
                        child: Text('Dead'),
                        value: 'dead',
                      ),
                      DropdownMenuItem(
                          child: Text('Unknown'),
                          value: 'unknown'
                      ),
                    ],
                    onChanged: (String value) {
                      setState(() {
                        _value1 = value;
                      });
                    }),
              ],
            ),
            new SizedBox(
              height: 20.0,
            ),
            new Row(
              children: <Widget>[
                DropdownButton<String>(
                    hint: Text("Select gender"),
                    value: _value2,
                    items: [
                      DropdownMenuItem(
                        child: Text('Male'),
                        value: 'male',
                      ),
                      DropdownMenuItem(
                        child: Text('Female'),
                        value: 'female',
                      ),
                      DropdownMenuItem(
                          child: Text('Genderless'),
                          value: 'genderless'
                      ),
                      DropdownMenuItem(
                          child: Text('Unknown'),
                          value: 'unknown'
                      ),
                    ],
                    onChanged: (String value) {
                      setState(() {
                        _value2 = value;
                      });
                    }),
              ],
            ),
            new SizedBox(
              height: 20.0,
            ),
            new Row(
              children: <Widget>[
                ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.black) ),
                  child: Text("Filter out"),
                  onPressed: () => this.widget.filterData({'status': _value1, 'gender': _value2}),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
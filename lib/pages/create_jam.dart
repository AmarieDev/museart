import 'package:flutter/material.dart';
import 'package:flutter_application/pages/jams_page.dart';

import '../reusable_widgets/multi_select.dart';
import '../reusable_widgets/my_icon_text_field.dart';
import '../reusable_widgets/my_padding.dart';

class CreateJamPage extends StatefulWidget {
  const CreateJamPage({Key? key}) : super(key: key);

  @override
  State<CreateJamPage> createState() => _CreateJamPageState();
}

class _CreateJamPageState extends State<CreateJamPage> {
  List<String> _selectedInstruments = [];
  List<String> _selectedGenres = [];
  final List<String> _instuments = [
    'Guitar',
    'Drums',
    'Bass',
    'Piano',
    'Saxophone',
  ];
  final List<String> _genres = [
    'Rock',
    'Metal',
    'Funk',
    'Jazz',
    'Rap',
  ];
  late int _buttonState;
  final int _kInstrumentsState = 1;
  final int _kGenreState = 2;

  void _showMultiSelect() async {
    final List<String>? results = await showDialog(
      context: context,
      builder: (BuildContext context) {
        if (_buttonState == _kInstrumentsState) {
          return MultiSelect(
            items: _instuments,
            selectedItems: _selectedInstruments,
          );
        } else if (_buttonState == _kGenreState) {
          return MultiSelect(
            items: _genres,
            selectedItems: _selectedGenres,
          );
        } else {
          return const AlertDialog(
            title: Text('State Error'),
            content: Text('Undefined State!'),
          );
        }
      },
    );

    // Update UI
    if (results != null) {
      setState(() {
        if (_buttonState == _kInstrumentsState) {
          _selectedInstruments = results;
        } else if (_buttonState == _kGenreState) {
          _selectedGenres = results;
        } else {
          throw Error();
        }
      });
    }
  }

  bool isSwitched = false;
  bool value = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // backgroundColor: const Color(0xffF5EFF5),
        body: SingleChildScrollView(
          child: Column(children: [
            const MyPadding(
              child: CreateJamTextField(
                hintText: "Title",
                icon: Icon(Icons.text_fields_rounded),
              ),
            ),
            const MyPadding(
              child: CreateJamTextField(
                hintText: "Date",
                icon: Icon(Icons.date_range),
              ),
            ),
            const MyPadding(
              child: CreateJamTextField(
                hintText: "Time",
                icon: Icon(Icons.timelapse_rounded),
              ),
            ),
            const MyPadding(
              child: CreateJamTextField(
                hintText: "Location",
                icon: Icon(
                  Icons.location_on_rounded,
                ),
              ),
            ),

            MyPadding(
              child: TextFormField(
                keyboardType: TextInputType.multiline,
                maxLines: 4,
                minLines: 3,
                decoration: InputDecoration(
                  hintText: "Description",
                  fillColor: Colors.grey,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            MyPadding(
              child: ListTile(
                title: const Text("Private"),
                leading: Switch(
                  value: isSwitched,
                  onChanged: (value) {
                    setState(() {
                      isSwitched = value;
                    });
                  },
                ),
              ),
            ),
            MyPadding(
              child: ElevatedButton(
                onPressed: () {
                  _buttonState = _kInstrumentsState;
                  _showMultiSelect();
                },
                child: const Text('Select Instruments'),
              ),
            ),
            Wrap(
              children: _selectedInstruments
                  .map((e) => Chip(
                        label: Text(e),
                      ))
                  .toList(),
            ),
            const Divider(
              height: 30,
            ),
            // display selected items
            MyPadding(
              child: ElevatedButton(
                onPressed: () {
                  _buttonState = _kGenreState;
                  _showMultiSelect();
                },
                child: const Text('Select Genre'),
              ),
            ),

            Wrap(
              children: _selectedGenres
                  .map((e) => Chip(
                        label: Text(e),
                      ))
                  .toList(),
            ),
            const Divider(
              height: 30,
            ),
            // display selected items
            const SizedBox(
              height: 128,
            ),
          ]),
        ),
        bottomSheet: Container(
          height: 70,
          color: const Color(0xffC0A0C1),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Theme.of(context).colorScheme.secondary,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => JamsPage()),
                  );
                },
                child: const Text("Cancel"),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => JamsPage(),
                    ),
                  );
                },
                child: const Text("Create"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

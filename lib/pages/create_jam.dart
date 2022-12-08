import 'package:flutter/material.dart';
import 'package:flutter_application/pages/jams_page.dart';

import '../reusable_widgets/multi_select.dart';
import '../reusable_widgets/my_icon_text_field.dart';
import '../reusable_widgets/my_padding.dart';
import '../data_models/jam.dart';
import 'package:flutter_application/providers/jams_provider.dart';
import "package:provider/provider.dart";

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
  var newJam =
      Jam(id: "", title: "", date: "", time: "", location: "", description: "");
  final _form = GlobalKey<FormState>();
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

  void _saveForm() {
    _form.currentState?.save();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // backgroundColor: const Color(0xffF5EFF5),
        body: Form(
          key: _form,
          child: SingleChildScrollView(
            child: Column(children: [
              MyPadding(
                child: CreateJamTextField(
                    hintText: "Title",
                    icon: const Icon(Icons.text_fields_rounded),
                    keybType: TextInputType.text,
                    save: (val) {
                      newJam.title = val!;
                    }),
              ),
              MyPadding(
                child: CreateJamTextField(
                  hintText: "Date",
                  icon: const Icon(Icons.date_range),
                  keybType: TextInputType.datetime,
                  save: (val) {
                    newJam.date = val!;
                  },
                ),
              ),

              MyPadding(
                child: CreateJamTextField(
                  hintText: "Time",
                  icon: const Icon(Icons.timelapse_rounded),
                  keybType: TextInputType.datetime,
                  save: (val) {
                    newJam.time = val!;
                  },
                ),
              ),

              MyPadding(
                child: CreateJamTextField(
                    hintText: "Location",
                    icon: const Icon(
                      Icons.location_on_rounded,
                    ),
                    keybType: TextInputType.streetAddress,
                    save: (val) {
                      newJam.location = val!;
                    }),
              ),

              MyPadding(
                child: TextFormField(
                  onSaved: (value) {
                    newJam.description = value!;
                  },
                  keyboardType: TextInputType.multiline,
                  maxLines: 3,
                  minLines: 2,
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
                  _saveForm();
                  final jamsData =
                      Provider.of<JamsProvider>(context, listen: false);

                  jamsData.addJam(newJam);
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

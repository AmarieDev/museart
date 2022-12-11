import 'package:flutter/material.dart';
import 'package:flutter_application/pages/jams_page.dart';

import '../reusable_widgets/multi_select.dart';
import '../reusable_widgets/my_icon_text_field.dart';
import '../reusable_widgets/my_padding.dart';
import '../data_models/jam.dart';
import 'package:flutter_application/providers/jams_provider.dart';
import "package:provider/provider.dart";
import 'package:intl/intl.dart';

class CreateJamPage extends StatefulWidget {
  const CreateJamPage({Key? key}) : super(key: key);
  static const routName = "/create-jam";

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
  TextEditingController dateInput = TextEditingController();
  TextEditingController timeInput = TextEditingController();
  var newJam = Jam(
    id: "",
    title: "",
    date: "",
    time: "",
    location: "",
    description: "",
    maxJamers: 2,
    prefreableGenres: [],
    prefreableInstruments: [],
  );
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

  bool isFormValid() {
    final isValid = _form.currentState?.validate();
    if (isValid != null && isValid) {
      return true;
    } else {
      return false;
    }
  }

  void _saveForm() {
    final isValid = _form.currentState?.validate();
    if (isFormValid()) {
      _form.currentState?.save();
    }
  }

  @override
  void initState() {
    dateInput.text = ""; //set the initial value of text field
    timeInput.text = ""; //set the initial value of text field
    super.initState();
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
                child: TextFormField(
                  validator: (value) {
                    if (value != null && value.isEmpty) {
                      return "This input field can't be empty!";
                    }
                    return null;
                  },
                  textInputAction: TextInputAction.next,
                  controller: dateInput, //editing controller of this TextField
                  decoration: const InputDecoration(
                      icon: Icon(Icons.calendar_today), //icon of text field
                      labelText: "Enter Date" //label text of field
                      ),
                  readOnly:
                      true, //set it true, so that user will not able to edit text
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(
                            2000), //DateTime.now() - not to allow to choose before today.
                        lastDate: DateTime(2101));
                    if (pickedDate != null) {
                      String formattedDate =
                          DateFormat('yyyy-MM-dd').format(pickedDate);

                      setState(() {
                        dateInput.text =
                            formattedDate; //set output date to TextField value.
                      });
                    } else {
                      print("Date is not selected");
                    }
                  },
                  onSaved: (val) => (newJam.date = val!),
                ),
              ),
              MyPadding(
                child: TextFormField(
                  validator: (value) {
                    if (value != null && value.isEmpty) {
                      return "This input field can't be empty!";
                    }
                    return null;
                  },
                  textInputAction: TextInputAction.next,
                  controller: timeInput, //editing controller of this TextField
                  decoration: const InputDecoration(
                      icon: Icon(Icons.timelapse_rounded), //icon of text field
                      labelText: "Enter Time" //label text of field
                      ),
                  readOnly:
                      true, //set it true, so that user will not able to edit text
                  onTap: () async {
                    TimeOfDay? pickedTime = await showTimePicker(
                      initialTime: TimeOfDay.now(),
                      context: context,
                    );
                    if (pickedTime != null) {
                      setState(() {
                        timeInput.text = pickedTime
                            .format(context)
                            .toString(); //set output time to TextField value.
                      });
                    } else {
                      print("Date is not selected");
                    }
                  },
                  onSaved: (val) => (newJam.time = val!),
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
                  validator: (value) {
                    if (value != null && value.isEmpty) {
                      return "This input field can't be empty!";
                    }
                    return null;
                  },
                  onSaved: (value) {
                    newJam.description = value!;
                  },
                  textInputAction: TextInputAction.next,
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
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text("Max. Jamers"),
                    const SizedBox(
                      width: 30,
                    ),
                    SizedBox(
                      width: 44,
                      height: 50,
                      child: TextFormField(
                        validator: (value) {
                          if (value != null && value.isEmpty) {
                            return "This input field can't be empty!";
                          }
                          return null;
                        },
                        onSaved: (newValue) =>
                            (newJam.maxJamers = int.parse(newValue!)),
                        style: const TextStyle(fontSize: 14.0),
                        keyboardType: TextInputType.number,
                        maxLength: 2,
                        decoration: const InputDecoration(
                          counterText: "",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              MyPadding(
                child: Row(children: [
                  const Text("Private"),
                  const SizedBox(
                    width: 53,
                  ),
                  Switch(
                    value: isSwitched,
                    onChanged: (value) {
                      setState(() {
                        isSwitched = value;
                      });
                    },
                  ),
                ]),
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
                  Navigator.of(context).pushNamed(
                    JamsPage.routName,
                  );
                },
                child: const Text("Cancel"),
              ),
              ElevatedButton(
                onPressed: () {
                  if (isFormValid()) {
                    _saveForm();
                    final jamsData =
                        Provider.of<JamsProvider>(context, listen: false);
                    newJam.isPrivate = isSwitched;

                    newJam.prefreableGenres =
                        _selectedGenres.isEmpty ? ["any"] : _selectedGenres;
                    newJam.prefreableInstruments = _selectedInstruments.isEmpty
                        ? ["any"]
                        : _selectedInstruments;

                    jamsData.addJam(newJam);
                    Navigator.of(context).pushNamed(
                      JamsPage.routName,
                    );
                  }
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

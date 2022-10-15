import 'package:flutter/material.dart';
import 'multi_select.dart';

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
    'Base',
    'Piano',
    'Saxsaphone',
  ];
  final List<String> _genres = [
    'Rock',
    'Metal',
    'Funk',
    'Jazz',
    'Rap',
  ];
  int _buttonState = 0;
  final int _kInstrumentsState = 1;
  final int _kGenreState = 2;

  void _showMultiSelect(List<String> items) async {
    final List<String>? results = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return MultiSelect(items: items);
      },
    );

    // Update UI
    if (results != null) {
      setState(() {
        if (_buttonState == _kInstrumentsState) {
          _selectedInstruments = results;
        } else if (_buttonState == _kGenreState) {
          _selectedGenres = results;
        }
      });
    }
  }

  bool isSwitched = false;
  bool value = false;

  @override
  Widget build(BuildContext context) {
    String? dropdownValue;
    return SafeArea(
      child: Scaffold(
        // backgroundColor: const Color(0xffF5EFF5),
        body: SingleChildScrollView(
          child: Column(children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 32, vertical: 8),
              child: CreateJamTextField(
                hintText: "Title",
                icon: Icon(Icons.text_fields_rounded),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 32, vertical: 8),
              child: CreateJamTextField(
                hintText: "Date",
                icon: Icon(Icons.date_range),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 32, vertical: 8),
              child: CreateJamTextField(
                hintText: "Time",
                icon: Icon(Icons.timelapse_rounded),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 32, vertical: 8),
              child: CreateJamTextField(
                hintText: "Location",
                icon: Icon(
                  Icons.location_on_rounded,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 25),
              child: ListTile(
                leading: const Text("Private"),
                trailing: Switch(
                  value: isSwitched,
                  onChanged: (value) {
                    setState(() {
                      isSwitched = value;
                    });
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
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
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 40),
              child: ElevatedButton(
                onPressed: () {
                  _buttonState = _kInstrumentsState;
                  _showMultiSelect(_instuments);
                },
                child: const Text('Select Instruments'),
              ),
            ),
            const Divider(
              height: 30,
            ),
            // display selected items
            Wrap(
              children: _selectedInstruments
                  .map((e) => Chip(
                        label: Text(e),
                      ))
                  .toList(),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 40),
              child: ElevatedButton(
                onPressed: () {
                  _buttonState = _kGenreState;
                  _showMultiSelect(_genres);
                },
                child: const Text('Select Genre'),
              ),
            ),
            const Divider(
              height: 30,
            ),
            // display selected items
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
                    MaterialPageRoute(
                        builder: (context) => const CreateJamPage()),
                  );
                },
                child: const Text("Cancel"),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CreateJamPage(),
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

class CreateJamTextField extends StatelessWidget {
  const CreateJamTextField({
    required this.hintText,
    required this.icon,
    Key? key,
  }) : super(key: key);
  final String hintText;
  final Icon icon;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        icon: icon,
        border: const UnderlineInputBorder(),
        labelText: hintText,
      ),
    );
  }
}

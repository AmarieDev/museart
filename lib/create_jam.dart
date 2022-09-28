import 'package:flutter/material.dart';

class CreateJamPage extends StatefulWidget {
  const CreateJamPage({Key? key}) : super(key: key);

  @override
  State<CreateJamPage> createState() => _CreateJamPageState();
}

class _CreateJamPageState extends State<CreateJamPage> {
  bool isSwitched = false;
  bool value = false;
  bool _secValue = false;
  bool _firstValue = false;
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
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 40),
              child: Theme(
                data: Theme.of(context).copyWith(
                  //canvasColor: Theme.of(context).colorScheme.secondary,
                  backgroundColor: Colors.grey,
                ),
                child: DropdownButton<String>(
                  value: dropdownValue,
                  hint: const Text("Genre"),
                  dropdownColor: Colors.grey,

                  isExpanded: true,
                  icon: const Icon(Icons.keyboard_arrow_down_outlined),
                  elevation: 16,
                  // style: const TextStyle(color: Colors.deepPurple),
                  underline: Container(),
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownValue = newValue!;
                    });
                  },
                  items: <String>['Rock', 'Metal', 'Pop', 'Rap']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      alignment: AlignmentDirectional.centerStart,
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
            ),
            DropdownButton<String>(
              items: [
                DropdownMenuItem(
                  child: Row(
                    children: <Widget>[
                      Checkbox(
                        onChanged: null,
                        value: _firstValue,
                      ),
                      const Text('First'),
                    ],
                  ),
                ),
                DropdownMenuItem(
                  child: Row(
                    children: <Widget>[
                      Checkbox(
                        onChanged: null,
                        value: _secValue,
                      ),
                      const Text('Second'),
                    ],
                  ),
                )
              ],
              onChanged: null,
              hint: const Text('Select value'),
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
            )),
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

import 'package:flutter/material.dart';
import 'package:flutter_application/data_models/user.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../providers/user_provider.dart';

class UserDataForm extends StatefulWidget {
  const UserDataForm({Key? key}) : super(key: key);

  @override
  State<UserDataForm> createState() => _UserDataFormState();
}

class _UserDataFormState extends State<UserDataForm> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  String _proficiency = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Profile'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            TextFormField(
              initialValue: _name,
              decoration: const InputDecoration(labelText: 'Name'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a name';
                }
                return null;
              },
              onSaved: (value) => _name = value!,
            ),
            TextFormField(
              initialValue: _proficiency,
              decoration: const InputDecoration(labelText: 'Proficiency'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a proficiency';
                }
                return null;
              },
              onSaved: (value) => _proficiency = value!,
            ),
            ElevatedButton(
              onPressed: () {
                _submitForm();
                Navigator.of(context).pushNamed('home');
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }

  void _submitForm() async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    if (_formKey.currentState != null) {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState?.save();
      }

      final userId = authProvider.getCurrentUserId();
      final authToken = authProvider.token;
      userProvider.user = User(
        name: _name,
        proficiency: _proficiency,
      );
      userProvider.setUserData(userId, authToken);
    }
  }
}

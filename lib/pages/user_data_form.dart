import 'package:flutter/material.dart';
import 'package:flutter_application/data_models/user.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../providers/user_provider.dart';

class UserDataForm extends StatefulWidget {
  UserDataForm({Key? key}) : super(key: key);

  @override
  State<UserDataForm> createState() => _UserDataFormState();
}

class _UserDataFormState extends State<UserDataForm> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  String _proficiency = '';
  String _profileImageUrl = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Profile'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            TextFormField(
              initialValue: _name,
              decoration: InputDecoration(labelText: 'Name'),
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
              decoration: InputDecoration(labelText: 'Proficiency'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a proficiency';
                }
                return null;
              },
              onSaved: (value) => _proficiency = value!,
            ),
            TextFormField(
              initialValue: _profileImageUrl,
              decoration: InputDecoration(labelText: 'Profile Image URL'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a url';
                }
                return null;
              },
              onSaved: (value) => _profileImageUrl = value!,
            ),
            ElevatedButton(
              onPressed: _submitForm,
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
          profileImageUrl: _profileImageUrl);
      userProvider.setUserData(userId, authToken);
    }
  }
}

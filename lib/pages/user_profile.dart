import 'package:flutter/material.dart';
import 'package:flutter_application/reusable_widgets/my_padding.dart';
import 'package:flutter_application/reusable_widgets/my_text_field.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../providers/user_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final authProv = Provider.of<AuthProvider>(context, listen: false);
    File? _image;

    void _getImage() async {
      XFile? image = await ImagePicker().pickImage(
          source: ImageSource.gallery, imageQuality: 50, maxWidth: 200);
      setState(() {
        _image = File(image!.path);
      });
      userProvider.uploadProfileImage(
        _image!,
        authProv.getCurrentUserId(),
        authProv.token,
      );
    }

    userProvider.fetchUserData(authProv.getCurrentUserId(), authProv.token);
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(left: 16, top: 25, right: 16),
        child: GestureDetector(
          onTap: () {
            _getImage();
            FocusScope.of(context).unfocus();
          },
          child: ListView(
            children: [
              Center(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10.0),
                      width: MediaQuery.of(context).size.width / 4,
                      height: MediaQuery.of(context).size.width / 4,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        image: DecorationImage(
                          image: NetworkImage(
                              userProvider.user.profileImageUrl.toString()),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 15,
                      right: 15,
                      child: CircleAvatar(
                        backgroundColor: Colors.black54,
                        child: IconButton(
                          splashColor: const Color(0xffFF8383),
                          hoverColor: const Color(0xff81BDFF),
                          splashRadius: 500,
                          icon: const Icon(
                            Icons.edit,
                            color: Colors.white,
                          ),
                          onPressed: () {},
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 35,
              ),
              MyPadding(
                  child: MyTextField(
                inputType: TextInputType.none,
                hintText: userProvider.user.name ?? '',
                readOnly: true,
                save: (val) {},
              )),
              MyPadding(
                  child: MyTextField(
                      inputType: TextInputType.none,
                      hintText: "ammar.mresh@gmail.com",
                      readOnly: true,
                      save: (val) {})),
              MyPadding(
                  child: MyTextField(
                      inputType: TextInputType.none,
                      hintText: "04.05.1998",
                      readOnly: true,
                      save: (val) {})),
              MyPadding(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacementNamed("/");

                    authProv.logout();
                  },
                  child: const Text("logout"),
                ),
              ),
              const SizedBox(
                height: 35,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

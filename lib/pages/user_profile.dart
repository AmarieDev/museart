import 'package:flutter/material.dart';
import 'package:flutter_application/reusable_widgets/my_padding.dart';
import 'package:flutter_application/reusable_widgets/my_text_field.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../providers/user_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final authProv = Provider.of<AuthProvider>(context, listen: false);
    File? _image;

    Future<void> _getImage() async {
      XFile? image = await ImagePicker().pickImage(
          source: ImageSource.gallery, imageQuality: 50, maxWidth: 200);
      if (image != null) {
        setState(() {
          _image = File(image.path);
        });
        userProvider.uploadProfileImage(
          _image!,
          authProv.getCurrentUserId(),
          authProv.token,
        );
      }
    }

    userProvider.fetchUserData(authProv.getCurrentUserId(), authProv.token);
    return FutureBuilder(
      future: userProvider.fetchUserData(
          authProv.getCurrentUserId(), authProv.token),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Scaffold(
            body: Container(
              padding: const EdgeInsets.only(left: 16, top: 25, right: 16),
              child: GestureDetector(
                onTap: () {},
                child: ListView(
                  children: [
                    Center(
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10.0),
                            width: 90,
                            height: 90,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                              image: DecorationImage(
                                image: NetworkImage(userProvider.user != null
                                    ? userProvider.user!.profileImageUrl
                                        .toString()
                                    : "https://cdn.pixabay.com/photo/2017/11/15/09/28/music-player-2951399_960_720.jpg"),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(40, 4, 0, 0),
                            child: CircleAvatar(
                              backgroundColor: Colors.black54,
                              child: IconButton(
                                splashColor: const Color(0xffFF8383),
                                hoverColor: const Color(0xff81BDFF),
                                splashRadius: 25,
                                icon: const Icon(
                                  Icons.edit,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  _getImage();
                                  FocusScope.of(context).unfocus();
                                },
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
                      hintText: userProvider.user?.name ?? '',
                      readOnly: true,
                      save: (val) {},
                    )),
                    MyPadding(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pushReplacementNamed("/");
                          userProvider.user = null;
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
        } else {
          // If the future is still running, return the loading indicator
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}

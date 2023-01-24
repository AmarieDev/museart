import 'package:flutter/material.dart';
import 'package:flutter_application/providers/user_provider.dart';
import 'package:flutter_application/reusable_widgets/my_padding.dart';
import 'package:flutter_application/reusable_widgets/my_text_field.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<UserProvider>(context, listen: false);
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(left: 16, top: 25, right: 16),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: FutureBuilder(
              future: prov.getUserName(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    return ListView(
                      children: [
                        Center(
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(10.0),
                                width: MediaQuery.of(context).size.width / 4,
                                height: MediaQuery.of(context).size.width / 4,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                  image: DecorationImage(
                                    image:
                                        AssetImage('assets/images/david.jpg'),
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
                          hintText: snapshot.data,
                          readOnly: true,
                          save: (val) {},
                        )),
                        MyPadding(
                            child: MyTextField(
                          inputType: TextInputType.none,
                          hintText: "Mresh",
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

                              Provider.of<AuthProvider>(context, listen: false)
                                  .logout();
                            },
                            child: const Text("logout"),
                          ),
                        ),
                        const SizedBox(
                          height: 35,
                        ),
                      ],
                    );
                  }
                } else {
                  return const Scaffold(
                    body: Center(child: CircularProgressIndicator()),
                  );
                }
              }),
        ),
      ),
    );
  }
}

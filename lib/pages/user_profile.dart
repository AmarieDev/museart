import 'package:flutter/material.dart';
import 'package:flutter_application/reusable_widgets/my_padding.dart';
import 'package:flutter_application/reusable_widgets/my_text_field.dart';

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(left: 16, top: 25, right: 16),
        child: GestureDetector(
          onTap: () {
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
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        image: DecorationImage(
                          image: AssetImage('assets/images/david.jpg'),
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
                hintText: "Ammar",
                readOnly: true,
              )),
              MyPadding(
                  child: MyTextField(
                hintText: "Mresh",
                readOnly: true,
              )),
              MyPadding(
                  child: MyTextField(
                hintText: "ammar.mresh@gmail.com",
                readOnly: true,
              )),
              MyPadding(
                  child: MyTextField(
                hintText: "04.05.1998",
                readOnly: true,
              )),
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

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:samaki_social_app/widgets/pallete.dart';




class buttonInput extends StatelessWidget {
  const buttonInput({Key? key, required this.buttonName}) : super(key: key);

  final String buttonName;


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: kBlue.withOpacity(0.5),
        ),
        height: size.height * 0.08,
        width: size.width * 0.8,
        child: ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, 'profile_screen');
          },
          child: Text(buttonName,
            style: kBodyText.copyWith(fontWeight: FontWeight.bold),
          ),
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black54.withOpacity(0.5)),
        ));
  }
}

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:samaki_social_app/widgets/pallete.dart';


class InviteFriends extends StatelessWidget {
  const InviteFriends({
    Key? key,
    required this.icon,

  }) : super(key: key);

  final IconData icon;


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Container(
          height: size.height * 0.08,
          width: size.width * 0.8,
          decoration: BoxDecoration(
              color: Colors.grey[500]?.withOpacity(0.5),
              borderRadius: BorderRadius.circular(16)),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(children: [
                Container(
                  child: Icon(
                    Icons.face_retouching_natural,
                    size: 28,
                    color: kWhite,
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Container(
                    child: Text(
                      'InviteFriends',
                      style: kBodyText,
                    )),
                SizedBox(
                  width: 60,
                ),
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    (Icons.arrow_forward_ios),
                    color: kWhite,
                  ),
                ),
              ]),
            ),
          )),
    );
  }
}

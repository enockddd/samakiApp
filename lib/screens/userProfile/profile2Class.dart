
import 'package:flutter/material.dart';

import '../../widgets/background_image.dart';
import '../../widgets/followersInput.dart';
import '../../widgets/invite_friendsInput.dart';
import '../../widgets/logout.dart';
import '../../widgets/pallete.dart';
import '../../widgets/privercyInput.dart';
import '../../widgets/settingsInput.dart';


class profile_class extends StatelessWidget {
  const profile_class({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        backgroundImage(
          image: 'images/1.jpg',
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height:KSpacingUnit*5 ,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Padding(
                      padding: const EdgeInsets.all(0.8),
                      child:  IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.arrow_back_ios),
                        color: kWhite,
                      ),
                    ),

                    Column(
                      children: [
                        Stack(
                          children: [
                            CircleAvatar(
                              radius:KSpacingUnit*6 ,
                              backgroundImage: AssetImage('images/4.jpg'),
                            ),

                            IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: Container
                                (
                                  height: size.height*5,
                                  width: size.width*5,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.black54
                                  ),
                                  child: Icon(Icons.edit)),
                              color: kWhite,
                            ),
                          ],
                        ),
                        SizedBox(height:20,),
                        Text("Enock Damas",
                          style: kBodyText,
                        ),
                        Text("Enockdamas9@gmail.com",
                            style:kBodyText

                        ),
                      ],
                    ),

                    Padding(
                      padding: const EdgeInsets.all(0.8),
                      child:  IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.sunny),
                        color: kWhite,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20,),

                privercyInputfield(
                  icon: Icons.privacy_tip,
                ),

                InviteFriends(
                  icon: Icons.privacy_tip,
                ),

                Followers(
                  icon: Icons.follow_the_signs,
                ),

                settingsfield(
                  icon: Icons.settings,
                ),

                logout(
                  icon: Icons.logout,
                ),


                //Followers
              ],
            ),
          ),
        )
      ],
    );
  }
}

















// class profile_class extends StatelessWidget {
//   const profile_class({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Scaffold(
//       body: Column(
//         children: [
//           SizedBox(height:KSpacingUnit*5 ,),
//            Row(
//              mainAxisAlignment: MainAxisAlignment.spaceBetween,
//              crossAxisAlignment: CrossAxisAlignment.start,
//              children: [
//                SizedBox(width: KSpacingUnit*3, ),
//                Icon(
//                    FontAwesomeIcons.arrowLeft,
//                  size:size.height * 0.08 ,
//                )
//              ],
//            )
//         ],
//       ),
//     );
//   }
// }

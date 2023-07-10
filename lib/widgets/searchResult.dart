import 'package:flutter/material.dart';
import '../models/user3.dart';
import '../screens/ProfileScreenCurrentUserClass.dart';
import '../screens/search/searchProfile.dart';


class SearchResult extends StatelessWidget {
  final List<Users3> searchResults;


  const SearchResult({Key? key, required this.searchResults}) : super(key: key);


  @override

  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Column(
        children: [
          for (Users3 user in searchResults)
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    // Handle the tap on a search result user,ProfileScreen(userId:_userId,image: _image,username: _username),
                    // You can navigate to the user's profile or perform other actions
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProfileScreenSearch(userId:user.user_id,image: user.profile_picture,username: user.username,email:user.email),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage(
                        user.profile_picture ?? 'https://example.com/default.jpg',
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 4),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: Column(
                      children: [
                        Text(
                          user.username ?? 'User',
                          style: TextStyle(color: Colors.white),
                        ),
                        Text(
                          user.email ?? '',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                )

              ],
            ),
        ],
      ),
    );
  }
}

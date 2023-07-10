import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class otherProfile extends StatefulWidget {
  final String? image;
  final String? username;
  final String? userId; // Add the userId parameter
  final String? email;

  otherProfile({this.image, this.username, this.userId , this.email});

  @override
  _otherProfileState createState() => _otherProfileState();
}

class _otherProfileState extends State<otherProfile> {
  Future<List<Map<String, dynamic>>>? _futurePosts;
  String? email;

  @override
  void initState() {
    super.initState();
    _futurePosts = fetchPosts();
  }

  Future<List<Map<String, dynamic>>> fetchPosts() async {
    List<Map<String, dynamic>> posts = [];

    FirebaseFirestore db = FirebaseFirestore.instance; // Firebase Firestore instance
    CollectionReference postsRef = db.collection('posts'); // Reference to the posts collection

    QuerySnapshot querySnapshot = await postsRef.where('user_id', isEqualTo: widget.userId).get(); // Get documents where the 'id' field matches the userId
    for (var doc in querySnapshot.docs) {
      Map<String, dynamic> postData = doc.data() as Map<String, dynamic>;
      posts.add(postData);

      // Print the post data
      print('Post Data:');
      postData.forEach((key, value) {
        print('$key: $value');
      });
      print('---------------------------------');
    }

    return posts;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Samaki'),
      // ),
      body: Column(
        children: [
          Container(
            width: 420,  // Set the desired width
            height: 150, // Set the desired height
            child: Card(
              child: Container(
                height: 100,
                child: Column(
                  children: [
                    Container(//that despaly profile,username,email
                      alignment: Alignment.centerLeft,
                      child: Align(
                        alignment: Alignment.center,
                        child: CircleAvatar(
                          radius: 30,
                          backgroundImage: NetworkImage(
                            widget.image ?? 'https://example.com/default.jpg',
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 4),
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            widget.username ?? 'Enock Damas',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16, // Adjust the font size as needed
                            ),
                          ),
                          Text(
                            widget.email ?? 'Enock Damas',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16, // Adjust the font size as needed
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

              ),
            ),
          ),


          SizedBox(width: 40,),

          Expanded(
            child: SizedBox(
              child: Card(
                child: Expanded(
                  child: SingleChildScrollView(
                    child: Container(
                      child: FutureBuilder<List<Map<String, dynamic>>>(
                        future: _futurePosts,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else {
                            return GridView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                mainAxisSpacing: 4,
                                crossAxisSpacing: 4,
                              ),
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index) {
                                return Image.network(
                                  snapshot.data![index]['content_url'],
                                  fit: BoxFit.cover,
                                );
                              },
                            );
                          }
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )

        ],
      ),
    );
  }
}



// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
//
//
// class otherProfile extends StatefulWidget {
//   final String? image;
//   final String? username;
//   final String? userId; // Add the userId parameter
//   final  String? email;
//   otherProfile({this.image, this.username, this.userId, this.email});
//
//   @override
//   _otherProfileState createState() => _otherProfileState();
// }
//
// class _otherProfileState extends State<otherProfile> {
//   Future<List<Map<String, dynamic>>>? _futurePosts;
//
//   @override
//   void initState() {
//     super.initState();
//     _futurePosts = fetchPosts();
//   }
//
//   Future<List<Map<String, dynamic>>> fetchPosts() async {
//     List<Map<String, dynamic>> posts = [];
//
//     FirebaseFirestore db = FirebaseFirestore.instance; // Firebase Firestore instance
//     CollectionReference postsRef = db.collection('posts'); // Reference to the posts collection
//
//     QuerySnapshot querySnapshot = await postsRef.where('user_id', isEqualTo: widget.userId).get(); // Get documents where the 'id' field matches the userId
//     for (var doc in querySnapshot.docs) {
//       Map<String, dynamic> postData = doc.data() as Map<String, dynamic>;
//       posts.add(postData);
//
//       // Print the post data
//       print('Post Data:');
//       postData.forEach((key, value) {
//         print('$key: $value');
//       });
//       print('---------------------------------');
//     }
//
//     return posts;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return
//        Container(
//         child: Column(
//           children: [
//             Padding(
//               padding: EdgeInsets.only(top: 60.0),
//               child: Container(
//                 height: 100,
//                 child: Column(
//                   children: [
//                     CircleAvatar(
//                       radius: 30,
//                       backgroundImage: NetworkImage(
//                         widget.image ?? 'https://example.com/default.jpg',
//                       ),
//                     ),
//                     SizedBox(height: 4),
//                     Text(
//                       widget.email ?? 'Enock Damas',
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 16, // Adjust the font size as needed
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//
//             Expanded(
//               child: SingleChildScrollView(
//                child: Container(
//                 child: FutureBuilder<List<Map<String, dynamic>>>(
//                   future: _futurePosts,
//                   builder: (context, snapshot) {
//                     if (snapshot.connectionState == ConnectionState.waiting) {
//                       return Center(child: CircularProgressIndicator());
//                     } else if (snapshot.hasError) {
//                       return Text('Error: ${snapshot.error}');
//                     } else {
//                       return Padding(
//                         padding: EdgeInsets.only(top: 60.0), // Adjust the padding as needed
//                         child: GridView.builder(
//                           physics: NeverScrollableScrollPhysics(), // Disable scrolling of the GridView
//                           shrinkWrap: true,
//                           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                             crossAxisCount: 3,
//                             mainAxisSpacing: 4,
//                             crossAxisSpacing: 4,
//                           ),
//                           itemCount: snapshot.data!.length,
//                           itemBuilder: (context, index) {
//                             return Image.network(snapshot.data![index]['content_url'], fit: BoxFit.cover);
//                           },
//                         ),
//                       );
//                     }
//                   },
//                 ),
//               ),
//             ),
//     )
//           ],
//         ),
//       );
//
//   }
//
// }

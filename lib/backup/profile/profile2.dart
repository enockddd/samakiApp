// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
//
//
// class userProfile extends StatefulWidget {
//   final String? image;
//   final String? username;
//   final String? userId; // Add the userId parameter
//
//   userProfile({this.image, this.username, this.userId});
//
//   @override
//   _userProfileState createState() => _userProfileState();
// }
//
// class _userProfileState extends State<userProfile> {
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
//     QuerySnapshot querySnapshot = await postsRef.get(); // Get all documents in the posts collection
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
//     return SingleChildScrollView( // Wrap the Column with SingleChildScrollView
//       child: Column(
//         children: [
//           Container(
//             height: 100,
//             child: ListView.builder(
//               scrollDirection: Axis.horizontal,
//               itemCount: 10,
//               itemBuilder: (context, index) {
//                 return Container(
//                   height: 100, // Set a fixed height for the inner container
//                   margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
//                   child: Column(
//                     children: [
//                       CircleAvatar(
//                         radius: 30,
//                         backgroundImage: NetworkImage(
//                           widget.image ?? 'https://example.com/default.jpg',
//                         ),
//                       ),
//                       SizedBox(height: 4),
//                       Text(
//                         widget.username ?? 'User',
//                         style: TextStyle(color: Colors.white),
//                       ),
//                     ],
//                   ),
//                 );
//               },
//             ),
//           ),
//           Container(
//             child: FutureBuilder<List<Map<String, dynamic>>>(
//               future: _futurePosts,
//               builder: (context, snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return Center(child: CircularProgressIndicator());
//                 } else if (snapshot.hasError) {
//                   return Text('Error: ${snapshot.error}');
//                 } else {
//                   return Padding(
//                     padding: EdgeInsets.only(top: 60.0), // Adjust the padding as needed
//                     child: SingleChildScrollView(
//                       child: GridView.builder(
//                         physics: NeverScrollableScrollPhysics(), // Disable scrolling of the GridView
//                         shrinkWrap: true,
//                         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                           crossAxisCount: 3,
//                           mainAxisSpacing: 4,
//                           crossAxisSpacing: 4,
//                         ),
//                         itemCount: snapshot.data!.length,
//                         itemBuilder: (context, index) {
//                           return Image.network(snapshot.data![index]['content_url'], fit: BoxFit.cover);
//                         },
//                       ),
//                     ),
//                   );
//                 }
//               },
//             ),
//           )
//
//         ],
//       ),
//     );
//   }
// }

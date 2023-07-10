// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// import '../../widgets/background_image.dart';
// import '../imageRetreave/imagesByids.dart';
//
// class HomeFeed extends StatefulWidget {
//   final String? image;
//   final String? username;
//   final String? imageId;
//
//   HomeFeed({this.image, this.username, this.imageId});
//
//   @override
//   _HomeFeedState createState() => _HomeFeedState();
// }
//
// class _HomeFeedState extends State<HomeFeed> {
//   Future<List<Map<String, dynamic>>>? _futurePosts;
//
//   Future<String> _getImageUrlFromSharedPreferences() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String imageUrl = prefs.getString('image') ?? 'https://example.com/default.jpg';
//     return imageUrl;
//   }
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
//     FirebaseFirestore db = FirebaseFirestore.instance;
//     CollectionReference postsRef = db.collection('posts');
//
//     QuerySnapshot querySnapshot = await postsRef.get();
//     for (var doc in querySnapshot.docs) {
//       Map<String, dynamic> postData = doc.data() as Map<String, dynamic>;
//       postData['id'] = doc.id;
//       posts.add(postData);
//
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
//     return Stack(
//       children: [
//         backgroundImage(
//           image: "assets/images/1.jpg",
//         ),
//         Column(
//           children: [
//             Container(
//               height: 100,
//               child: ListView.builder(
//                 scrollDirection: Axis.horizontal,
//                 itemCount: 10,
//                 itemBuilder: (context, index) {
//                   return Container(
//                     margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
//                     child: Column(
//                       children: [
//                         CircleAvatar(
//                           radius: 30,
//                           backgroundImage: NetworkImage(widget.image ??
//                               'https://example.com/default.jpg'),
//                         ),
//                         SizedBox(height: 4),
//                         SizedBox(height: 4),
//                         Text(
//                           widget.username ?? 'User',
//                           style: TextStyle(color: Colors.white),
//                         ),
//                       ],
//                     ),
//                   );
//                 },
//               ),
//             ),
//             FutureBuilder<List<Map<String, dynamic>>>(
//               future: _futurePosts,
//               builder: (context, snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return Center(child: CircularProgressIndicator());
//                 } else if (snapshot.hasError) {
//                   return Text('Error: ${snapshot.error}');
//                 } else {
//                   return Expanded(
//                     child: ListView.builder(
//                       itemCount: snapshot.data!.length,
//                       itemBuilder: (context, index) {
//                         final String imageId = snapshot.data![index]['user_id'];
//                         Image.network(snapshot.data![index]
//                         ['content_url']); // Retrieve the image ID
//
//                         return GestureDetector(
//                           onTap: () {
//                             final String docId = snapshot.data![index]['id'];
//                             final String? img = snapshot.data![index]['content_url'];
//                             print('Document ID: $docId');
//                             Navigator.of(context).push(
//                               MaterialPageRoute(
//                                 builder: (context) => ImageById(documentId: docId, image: img),
//                               ),
//                             );
//                           },
//                           child: Stack(
//                             children: [
//                               backgroundImage(
//                                 image: "assets/images/1.jpg",
//                               ),
//                               Card(
//                                 color: Colors.transparent,
//                                 child: Column(
//                                   children: [
//                                     ListTile(
//                                       leading: CircleAvatar(
//                                         radius: 30,
//                                         backgroundImage: NetworkImage(widget.image ??
//                                             'https://example.com/default.jpg'),
//                                       ),
//                                       title: Text(
//                                           snapshot.data![index]['username'] ??
//                                               'Username',
//                                           style:
//                                           TextStyle(color: Colors.white)),
//                                     ),
//                                     Container(
//                                       child: Image.network(
//                                         snapshot.data![index]['content_url'],
//                                         fit: BoxFit.cover,
//                                         errorBuilder: (context, error, stackTrace) {
//                                           print(error);  // Log the error for debugging purposes
//                                           return Image.asset('assets/images/placeholder.jpg');  // Display a placeholder image on error
//                                         },
//                                       ),
//                                     ),
//                                     Padding(
//                                       padding: const EdgeInsets.all(8.0),
//                                       child: Column(
//                                         children: [
//                                           Row(
//                                             children: [
//                                               SizedBox(width: 8), // space between avatar and text
//                                               Expanded(
//                                                 child: Text(snapshot.data![index]['username'] ?? 'User', style: TextStyle(color: Colors.white)),
//                                               ),
//                                               OutlinedButton(
//                                                 onPressed: () {
//                                                   // handle follow action here
//                                                 },
//                                                 child: Text('Follow', style: TextStyle(color: Colors.white)),
//                                                 style: OutlinedButton.styleFrom(
//                                                   side: BorderSide(color: Colors.white),
//                                                 ),
//                                               ),
//                                             ],
//                                           ),
//                                           SizedBox(height: 4), // space between row and description
//                                           Text(snapshot.data![index]['description'] ?? '', style: TextStyle(color: Colors.white)),
//                                           SizedBox(height: 4), // space between description and likes/comments count
//                                           Row(
//                                             children: [
//                                               Icon(Icons.favorite, color: Colors.red),
//                                               Text(snapshot.data![index]['likes'].toString() ?? '0', style: TextStyle(color: Colors.white)),
//                                               SizedBox(width: 16), // space between likes count and comments count
//                                               Icon(Icons.comment, color: Colors.white),
//                                               Text(snapshot.data![index]['comments'].toString() ?? '0', style: TextStyle(color: Colors.white)),
//                                             ],
//                                           ),
//                                           SizedBox(height: 4), // space between likes/comments count and text field
//                                           Padding(
//                                             padding: const EdgeInsets.all(8.0),
//                                             child: Row(
//                                               children: [
//                                                 FutureBuilder<String>(
//                                                   future: _getImageUrlFromSharedPreferences(),
//                                                   builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
//                                                     if (snapshot.connectionState == ConnectionState.waiting) {
//                                                       return CircularProgressIndicator();
//                                                     } else {
//                                                       return CircleAvatar(
//                                                         radius: 30,
//                                                         backgroundImage: NetworkImage(snapshot.data!),
//                                                       );
//                                                     }
//                                                   },
//                                                 ),
//                                                 SizedBox(width: 8), // space between avatar and text field
//                                                 Expanded( // to ensure TextField takes up remaining space
//                                                   child: TextField(
//                                                     decoration: InputDecoration(
//                                                       border: OutlineInputBorder(),
//                                                       hintText: 'Add comment...',
//                                                       hintStyle: TextStyle(color: Colors.white.withOpacity(0.6)),
//                                                       filled: true,
//                                                       fillColor: Colors.white24,
//                                                     ),
//                                                     style: TextStyle(color: Colors.white),
//                                                   ),
//                                                 ),
//                                               ],
//                                             ),
//                                           ),
//
//                                         ],
//                                       ),
//                                     ),
//
//                                   ],
//                                 ),
//                               ),
//                               Positioned(
//                                 top: 8,
//                                 right: 8,
//                                 child: Column(
//                                   mainAxisAlignment: MainAxisAlignment.start,
//                                   crossAxisAlignment: CrossAxisAlignment.end,
//                                   children: [
//                                     SizedBox(height: 8),
//                                     Container(
//                                       decoration: BoxDecoration(
//                                         shape: BoxShape.circle,
//                                         color: Colors.black.withOpacity(0.5),
//                                       ),
//                                       child: IconButton(
//                                         icon: Icon(Icons.favorite),
//                                         color: Colors.white,
//                                         onPressed: () {
//                                           // Handle like action
//                                         },
//                                       ),
//                                     ),
//                                     SizedBox(height: 8),
//                                     Container(
//                                       decoration: BoxDecoration(
//                                         shape: BoxShape.circle,
//                                         color: Colors.black.withOpacity(0.5),
//                                       ),
//                                       child: IconButton(
//                                         icon: Icon(Icons.comment),
//                                         color: Colors.white,
//                                         onPressed: () {
//                                           // Handle comment action
//                                         },
//                                       ),
//                                     ),
//                                     SizedBox(height: 8),
//                                     Container(
//                                       decoration: BoxDecoration(
//                                         shape: BoxShape.circle,
//                                         color: Colors.black.withOpacity(0.5),
//                                       ),
//                                       child: IconButton(
//                                         icon: Icon(Icons.share),
//                                         color: Colors.white,
//                                         onPressed: () {
//                                           // Handle share action
//                                         },
//                                       ),
//                                     ),
//                                     SizedBox(height: 8),
//                                     Container(
//                                       decoration: BoxDecoration(
//                                         shape: BoxShape.circle,
//                                         color: Colors.black.withOpacity(0.5),
//                                       ),
//                                       child: IconButton(
//                                         icon: Icon(Icons.message),
//                                         color: Colors.white,
//                                         onPressed: () {
//                                           // Handle message action
//                                         },
//                                       ),
//                                     ),
//                                     SizedBox(height: 8),
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                         );
//                       },
//                     ),
//                   );
//                 }
//               },
//             ),
//           ],
//         ),
//       ],
//     );
//   }
// }
//
// ///////////////////////////////////////////////////////////////videos////////////////////////////////
// // class HomeFeedVideo extends StatefulWidget {
// //   final String? image;
// //   final String? username;
// //
// //   HomeFeedVideo({this.image, this.username});
// //
// //   @override
// //   _HomeFeedVideoState createState() => _HomeFeedVideoState();
// // }
// //
// // class _HomeFeedVideoState extends State<HomeFeedVideo> {
// //   Future<List<Map<String, dynamic>>>? _futurePosts;
// //
// //   @override
// //   void initState() {
// //     super.initState();
// //     _futurePosts = fetchPosts();
// //   }
// //
// //   Future<List<Map<String, dynamic>>> fetchPosts() async {
// //     List<Map<String, dynamic>> posts = [];
// //
// //     FirebaseFirestore db = FirebaseFirestore.instance; // Firebase Firestore instance
// //     CollectionReference postsRef = db.collection('posts'); // Reference to the posts collection
// //
// //     QuerySnapshot querySnapshot = await postsRef.get(); // Get all documents in the posts collection
// //     for (var doc in querySnapshot.docs) {
// //       Map<String, dynamic> postData = doc.data() as Map<String, dynamic>;
// //       posts.add(postData);
// //
// //       // Print the post data
// //       print('Post Data:');
// //       postData.forEach((key, value) {
// //         print('$key: $value');
// //       });
// //       print('---------------------------------');
// //     }
// //
// //     return posts;
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Column(
// //       children: [
// //         Container(
// //           height: 100,
// //           child: ListView.builder(
// //             scrollDirection: Axis.horizontal,
// //             itemCount: 10,
// //             itemBuilder: (context, index) {
// //               return Container(
// //                 margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
// //                 child: Column(
// //                   children: [
// //                     CircleAvatar(
// //                       radius: 30,
// //                       backgroundImage: NetworkImage(
// //                           widget.image ?? 'https://example.com/default.jpg'),
// //                     ),
// //                     SizedBox(height: 4),
// //                     Text(widget.username ?? 'User'),
// //                   ],
// //                 ),
// //               );
// //             },
// //           ),
// //         ),
// //         Expanded(
// //           child: FutureBuilder<List<Map<String, dynamic>>>(
// //             future: _futurePosts,
// //             builder: (context, snapshot) {
// //               if (snapshot.connectionState == ConnectionState.waiting) {
// //                 return Center(child: CircularProgressIndicator());
// //               } else if (snapshot.hasError) {
// //                 return Text('Error: ${snapshot.error}');
// //               } else {
// //                 return GridView.builder(
// //                   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
// //                     crossAxisCount: 3,
// //                     mainAxisSpacing: 4,
// //                     crossAxisSpacing: 4,
// //                   ),
// //                   itemCount: snapshot.data!.length,
// //                   itemBuilder: (context, index) {
// //                     Map<String, dynamic> postData = snapshot.data![index];
// //                     String postType = postData['post_type'];
// //                     String contentUrl = postData['content_url'];
// //
// //                     if (postType == 'video') {
// //                       return VideoWidget(videoUrl: contentUrl);
// //                     } else {
// //                       return Image.network(contentUrl, fit: BoxFit.cover);
// //                     }
// //                   },
// //                 );
// //               }
// //             },
// //           ),
// //         ),
// //       ],
// //     );
// //   }
// // }
//
// // class VideoWidget extends StatefulWidget {
// //   final String videoUrl;
// //
// //   VideoWidget({required this.videoUrl});
// //
// //   @override
// //   _VideoWidgetState createState() => _VideoWidgetState();
// // }
// //
// // class _VideoWidgetState extends State<VideoWidget> {
// //   late VideoPlayerController _videoPlayerController;
// //   late Future<void> _initializeVideoPlayerFuture;
// //
// //   @override
// //   void initState() {
// //     super.initState();
// //     _videoPlayerController = VideoPlayerController.network(widget.videoUrl);
// //     _initializeVideoPlayerFuture = _videoPlayerController.initialize();
// //   }
// //
// //   @override
// //   void dispose() {
// //     _videoPlayerController.dispose();
// //     super.dispose();
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return FutureBuilder(
// //       future: _initializeVideoPlayerFuture,
// //       builder: (context, snapshot) {
// //         if (snapshot.connectionState == ConnectionState.done) {
// //           return AspectRatio(
// //             aspectRatio: _videoPlayerController.value.aspectRatio,
// //             child: VideoPlayer(_videoPlayerController),
// //           );
// //         } else {
// //           return Center(child: CircularProgressIndicator());
// //         }
// //       },
// //     );
// //   }
// // }
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// import '../../widgets/background_image.dart';
// import '../imageRetreave/imagesByids.dart';
//
// class HomeFeed extends StatefulWidget {
//   final String? image;
//   final String? username;
//   final String? imageId;
//
//   HomeFeed({this.image, this.username, this.imageId});
//
//   @override
//   _HomeFeedState createState() => _HomeFeedState();
// }
//
// class _HomeFeedState extends State<HomeFeed> {
//   Future<List<Map<String, dynamic>>>? _futurePosts;
//
//   Future<String> _getImageUrlFromSharedPreferences() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String imageUrl = prefs.getString('image') ?? 'https://example.com/default.jpg';
//     return imageUrl;
//   }
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
//     FirebaseFirestore db = FirebaseFirestore.instance;
//     CollectionReference postsRef = db.collection('posts');
//
//     QuerySnapshot querySnapshot = await postsRef.get();
//     for (var doc in querySnapshot.docs) {
//       Map<String, dynamic> postData = doc.data() as Map<String, dynamic>;
//       postData['id'] = doc.id;
//       posts.add(postData);
//
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
//     return Stack(
//       children: [
//         backgroundImage(
//           image: "assets/images/1.jpg",
//         ),
//         Column(
//           children: [
//             Container(
//               height: 100,
//               child: ListView.builder(
//                 scrollDirection: Axis.horizontal,
//                 itemCount: 10,
//                 itemBuilder: (context, index) {
//                   return Container(
//                     margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
//                     child: Column(
//                       children: [
//                         CircleAvatar(
//                           radius: 30,
//                           backgroundImage: NetworkImage(widget.image ??
//                               'https://example.com/default.jpg'),
//                         ),
//                         SizedBox(height: 4),
//                         SizedBox(height: 4),
//                         Text(
//                           widget.username ?? 'User',
//                           style: TextStyle(color: Colors.white),
//                         ),
//                       ],
//                     ),
//                   );
//                 },
//               ),
//             ),
//             FutureBuilder<List<Map<String, dynamic>>>(
//               future: _futurePosts,
//               builder: (context, snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return Center(child: CircularProgressIndicator());
//                 } else if (snapshot.hasError) {
//                   return Text('Error: ${snapshot.error}');
//                 } else {
//                   return Expanded(
//                     child: ListView.builder(
//                       itemCount: snapshot.data!.length,
//                       itemBuilder: (context, index) {
//                         final String imageId = snapshot.data![index]['user_id'];
//                         Image.network(snapshot.data![index]
//                         ['content_url']); // Retrieve the image ID
//
//                         return GestureDetector(
//                           onTap: () {
//                             final String docId = snapshot.data![index]['id'];
//                             final String? img = snapshot.data![index]['content_url'];
//                             print('Document ID: $docId');
//                             Navigator.of(context).push(
//                               MaterialPageRoute(
//                                 builder: (context) => ImageById(documentId: docId, image: img),
//                               ),
//                             );
//                           },
//                           child: Stack(
//                             children: [
//                               backgroundImage(
//                                 image: "assets/images/1.jpg",
//                               ),
//                               Card(
//                                 color: Colors.transparent,
//                                 child: Column(
//                                   children: [
//                                     ListTile(
//                                       leading: CircleAvatar(
//                                         radius: 30,
//                                         backgroundImage: NetworkImage(widget.image ??
//                                             'https://example.com/default.jpg'),
//                                       ),
//                                       title: Text(
//                                           snapshot.data![index]['username'] ??
//                                               'Username',
//                                           style:
//                                           TextStyle(color: Colors.white)),
//                                     ),
//                                     Container(
//                                       child: Image.network(
//                                         snapshot.data![index]['content_url'],
//                                         fit: BoxFit.cover,
//                                         errorBuilder: (context, error, stackTrace) {
//                                           print(error);  // Log the error for debugging purposes
//                                           return Image.asset('assets/images/placeholder.jpg');  // Display a placeholder image on error
//                                         },
//                                       ),
//                                     ),
//                                     Padding(
//                                       padding: const EdgeInsets.all(8.0),
//                                       child: Column(
//                                         children: [
//                                           Row(
//                                             children: [
//                                               SizedBox(width: 8), // space between avatar and text
//                                               Expanded(
//                                                 child: Text(snapshot.data![index]['username'] ?? 'User', style: TextStyle(color: Colors.white)),
//                                               ),
//                                               OutlinedButton(
//                                                 onPressed: () {
//                                                   // handle follow action here
//                                                 },
//                                                 child: Text('Follow', style: TextStyle(color: Colors.white)),
//                                                 style: OutlinedButton.styleFrom(
//                                                   side: BorderSide(color: Colors.white),
//                                                 ),
//                                               ),
//                                             ],
//                                           ),
//                                           SizedBox(height: 4), // space between row and description
//                                           Text(snapshot.data![index]['description'] ?? '', style: TextStyle(color: Colors.white)),
//                                           SizedBox(height: 4), // space between description and likes/comments count
//                                           Row(
//                                             children: [
//                                               Icon(Icons.favorite, color: Colors.red),
//                                               Text(snapshot.data![index]['likes'].toString() ?? '0', style: TextStyle(color: Colors.white)),
//                                               SizedBox(width: 16), // space between likes count and comments count
//                                               Icon(Icons.comment, color: Colors.white),
//                                               Text(snapshot.data![index]['comments'].toString() ?? '0', style: TextStyle(color: Colors.white)),
//                                             ],
//                                           ),
//                                           SizedBox(height: 4), // space between likes/comments count and text field
//                                           Padding(
//                                             padding: const EdgeInsets.all(8.0),
//                                             child: Row(
//                                               children: [
//                                                 FutureBuilder<String>(
//                                                   future: _getImageUrlFromSharedPreferences(),
//                                                   builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
//                                                     if (snapshot.connectionState == ConnectionState.waiting) {
//                                                       return CircularProgressIndicator();
//                                                     } else {
//                                                       return CircleAvatar(
//                                                         radius: 30,
//                                                         backgroundImage: NetworkImage(snapshot.data!),
//                                                       );
//                                                     }
//                                                   },
//                                                 ),
//                                                 SizedBox(width: 8), // space between avatar and text field
//                                                 Expanded( // to ensure TextField takes up remaining space
//                                                   child: TextField(
//                                                     decoration: InputDecoration(
//                                                       border: OutlineInputBorder(),
//                                                       hintText: 'Add comment...',
//                                                       hintStyle: TextStyle(color: Colors.white.withOpacity(0.6)),
//                                                       filled: true,
//                                                       fillColor: Colors.white24,
//                                                     ),
//                                                     style: TextStyle(color: Colors.white),
//                                                   ),
//                                                 ),
//                                               ],
//                                             ),
//                                           ),
//
//                                         ],
//                                       ),
//                                     ),
//
//                                   ],
//                                 ),
//                               ),
//                               Positioned(
//                                 top: 8,
//                                 right: 8,
//                                 child: Column(
//                                   mainAxisAlignment: MainAxisAlignment.start,
//                                   crossAxisAlignment: CrossAxisAlignment.end,
//                                   children: [
//                                     SizedBox(height: 8),
//                                     Container(
//                                       decoration: BoxDecoration(
//                                         shape: BoxShape.circle,
//                                         color: Colors.black.withOpacity(0.5),
//                                       ),
//                                       child: IconButton(
//                                         icon: Icon(Icons.favorite),
//                                         color: Colors.white,
//                                         onPressed: () {
//                                           // Handle like action
//                                         },
//                                       ),
//                                     ),
//                                     SizedBox(height: 8),
//                                     Container(
//                                       decoration: BoxDecoration(
//                                         shape: BoxShape.circle,
//                                         color: Colors.black.withOpacity(0.5),
//                                       ),
//                                       child: IconButton(
//                                         icon: Icon(Icons.comment),
//                                         color: Colors.white,
//                                         onPressed: () {
//                                           // Handle comment action
//                                         },
//                                       ),
//                                     ),
//                                     SizedBox(height: 8),
//                                     Container(
//                                       decoration: BoxDecoration(
//                                         shape: BoxShape.circle,
//                                         color: Colors.black.withOpacity(0.5),
//                                       ),
//                                       child: IconButton(
//                                         icon: Icon(Icons.share),
//                                         color: Colors.white,
//                                         onPressed: () {
//                                           // Handle share action
//                                         },
//                                       ),
//                                     ),
//                                     SizedBox(height: 8),
//                                     Container(
//                                       decoration: BoxDecoration(
//                                         shape: BoxShape.circle,
//                                         color: Colors.black.withOpacity(0.5),
//                                       ),
//                                       child: IconButton(
//                                         icon: Icon(Icons.message),
//                                         color: Colors.white,
//                                         onPressed: () {
//                                           // Handle message action
//                                         },
//                                       ),
//                                     ),
//                                     SizedBox(height: 8),
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                         );
//                       },
//                     ),
//                   );
//                 }
//               },
//             ),
//           ],
//         ),
//       ],
//     );
//   }
// }
//
// ///////////////////////////////////////////////////////////////videos////////////////////////////////
// // class HomeFeedVideo extends StatefulWidget {
// //   final String? image;
// //   final String? username;
// //
// //   HomeFeedVideo({this.image, this.username});
// //
// //   @override
// //   _HomeFeedVideoState createState() => _HomeFeedVideoState();
// // }
// //
// // class _HomeFeedVideoState extends State<HomeFeedVideo> {
// //   Future<List<Map<String, dynamic>>>? _futurePosts;
// //
// //   @override
// //   void initState() {
// //     super.initState();
// //     _futurePosts = fetchPosts();
// //   }
// //
// //   Future<List<Map<String, dynamic>>> fetchPosts() async {
// //     List<Map<String, dynamic>> posts = [];
// //
// //     FirebaseFirestore db = FirebaseFirestore.instance; // Firebase Firestore instance
// //     CollectionReference postsRef = db.collection('posts'); // Reference to the posts collection
// //
// //     QuerySnapshot querySnapshot = await postsRef.get(); // Get all documents in the posts collection
// //     for (var doc in querySnapshot.docs) {
// //       Map<String, dynamic> postData = doc.data() as Map<String, dynamic>;
// //       posts.add(postData);
// //
// //       // Print the post data
// //       print('Post Data:');
// //       postData.forEach((key, value) {
// //         print('$key: $value');
// //       });
// //       print('---------------------------------');
// //     }
// //
// //     return posts;
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Column(
// //       children: [
// //         Container(
// //           height: 100,
// //           child: ListView.builder(
// //             scrollDirection: Axis.horizontal,
// //             itemCount: 10,
// //             itemBuilder: (context, index) {
// //               return Container(
// //                 margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
// //                 child: Column(
// //                   children: [
// //                     CircleAvatar(
// //                       radius: 30,
// //                       backgroundImage: NetworkImage(
// //                           widget.image ?? 'https://example.com/default.jpg'),
// //                     ),
// //                     SizedBox(height: 4),
// //                     Text(widget.username ?? 'User'),
// //                   ],
// //                 ),
// //               );
// //             },
// //           ),
// //         ),
// //         Expanded(
// //           child: FutureBuilder<List<Map<String, dynamic>>>(
// //             future: _futurePosts,
// //             builder: (context, snapshot) {
// //               if (snapshot.connectionState == ConnectionState.waiting) {
// //                 return Center(child: CircularProgressIndicator());
// //               } else if (snapshot.hasError) {
// //                 return Text('Error: ${snapshot.error}');
// //               } else {
// //                 return GridView.builder(
// //                   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
// //                     crossAxisCount: 3,
// //                     mainAxisSpacing: 4,
// //                     crossAxisSpacing: 4,
// //                   ),
// //                   itemCount: snapshot.data!.length,
// //                   itemBuilder: (context, index) {
// //                     Map<String, dynamic> postData = snapshot.data![index];
// //                     String postType = postData['post_type'];
// //                     String contentUrl = postData['content_url'];
// //
// //                     if (postType == 'video') {
// //                       return VideoWidget(videoUrl: contentUrl);
// //                     } else {
// //                       return Image.network(contentUrl, fit: BoxFit.cover);
// //                     }
// //                   },
// //                 );
// //               }
// //             },
// //           ),
// //         ),
// //       ],
// //     );
// //   }
// // }
//
// // class VideoWidget extends StatefulWidget {
// //   final String videoUrl;
// //
// //   VideoWidget({required this.videoUrl});
// //
// //   @override
// //   _VideoWidgetState createState() => _VideoWidgetState();
// // }
// //
// // class _VideoWidgetState extends State<VideoWidget> {
// //   late VideoPlayerController _videoPlayerController;
// //   late Future<void> _initializeVideoPlayerFuture;
// //
// //   @override
// //   void initState() {
// //     super.initState();
// //     _videoPlayerController = VideoPlayerController.network(widget.videoUrl);
// //     _initializeVideoPlayerFuture = _videoPlayerController.initialize();
// //   }
// //
// //   @override
// //   void dispose() {
// //     _videoPlayerController.dispose();
// //     super.dispose();
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return FutureBuilder(
// //       future: _initializeVideoPlayerFuture,
// //       builder: (context, snapshot) {
// //         if (snapshot.connectionState == ConnectionState.done) {
// //           return AspectRatio(
// //             aspectRatio: _videoPlayerController.value.aspectRatio,
// //             child: VideoPlayer(_videoPlayerController),
// //           );
// //         } else {
// //           return Center(child: CircularProgressIndicator());
// //         }
// //       },
// //     );
// //   }
// // }

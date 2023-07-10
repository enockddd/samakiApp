// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
//
//
//
// class HomeFeed extends StatefulWidget {
//   final String? image;
//   final String? username;
//
//   HomeFeed({this.image, this.username});
//
//   @override
//   _HomeFeedState createState() => _HomeFeedState();
// }
//
// class _HomeFeedState extends State<HomeFeed> {
//   Future<List<Map<String, dynamic>>>? _futurePosts;
//
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
//     return Column(
//       children: [
//         Container(
//           height: 100,
//           child: ListView.builder(
//             scrollDirection: Axis.horizontal,
//             itemCount: 10,
//             itemBuilder: (context, index) {
//               return Container(
//                 margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
//                 child: Column(
//                   children: [
//                     CircleAvatar(
//                       radius: 30,
//                       backgroundImage: NetworkImage(
//                           widget.image ?? 'https://example.com/default.jpg'),
//                     ),
//                     SizedBox(height: 4),
//                     Text(widget.username ?? 'User'),
//                   ],
//                 ),
//               );
//             },
//           ),
//         ),
//         FutureBuilder<List<Map<String, dynamic>>>(
//           future: _futurePosts,
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return Center(child: CircularProgressIndicator());
//             } else if (snapshot.hasError) {
//               return Text('Error: ${snapshot.error}');
//             } else {
//               return Expanded(
//                 child: GridView.builder(
//                   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                     crossAxisCount: 3,
//                     mainAxisSpacing: 4,
//                     crossAxisSpacing: 4,
//                   ),
//                   itemCount: snapshot.data!.length,
//                   itemBuilder: (context, index) {
//                     return Image.network(snapshot.data![index]['content_url'], fit: BoxFit.cover);
//                   },
//                 ),
//               );
//             }
//           },
//         ),
//
//       ],
//     );
//   }
// }
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
//

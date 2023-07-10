import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';
import '../../widgets/background_image.dart';
import '../imageRetreave/imagesByids.dart';

class VideoHomeFeed extends StatefulWidget {
  final String? image;
  final String? username;
  final String? imageId;

  VideoHomeFeed({this.image, this.username, this.imageId});

  @override
  _VideoHomeFeedState createState() => _VideoHomeFeedState();
}

class _VideoHomeFeedState extends State<VideoHomeFeed> {
  Future<List<Map<String, dynamic>>>? _futurePosts;
  List<VideoPlayerController> videoControllers = [];

  Future<String> _getImageUrlFromSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String imageUrl =
        prefs.getString('image') ?? 'https://example.com/default.jpg';
    return imageUrl;
  }

  @override
  void initState() {
    super.initState();
    _futurePosts = fetchPosts();
  }

  Future<List<Map<String, dynamic>>> fetchPosts() async {
    List<Map<String, dynamic>> posts = [];

    FirebaseFirestore db = FirebaseFirestore.instance;
    CollectionReference postsRef = db.collection('posts');

    QuerySnapshot querySnapshot = await postsRef.get();
    for (var doc in querySnapshot.docs) {
      Map<String, dynamic> postData = doc.data() as Map<String, dynamic>;
      postData['id'] = doc.id;
      posts.add(postData);

      videoControllers.add(
          VideoPlayerController.network(postData['content_url'])..initialize());

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
    return Stack(
      children: [
        backgroundImage(
          image: "assets/images/1.jpg",
        ),
        Column(
          children: [
            Container(
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundImage: NetworkImage(widget.image ??
                              'https://example.com/default.jpg'),
                        ),
                        SizedBox(height: 4),
                        SizedBox(height: 4),
                        Text(
                          widget.username ?? 'User',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            FutureBuilder<List<Map<String, dynamic>>>(
              future: _futurePosts,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return Expanded(
                    child: ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            final String docId = snapshot.data![index]['id'];
                            final String? img =
                                snapshot.data![index]['content_url'];
                            print('Document ID: $docId');
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) =>
                                    ImageById(documentId: docId, image: img),
                              ),
                            );
                          },
                          child: Stack(
                            children: [
                              backgroundImage(
                                image: "assets/images/1.jpg",
                              ),
                              Card(
                                color: Colors.transparent,
                                child: Column(
                                  children: [
                                    ListTile(
                                      leading: CircleAvatar(
                                        radius: 30,
                                        backgroundImage: NetworkImage(widget
                                                .image ??
                                            'https://example.com/default.jpg'),
                                      ),
                                      title: Text(
                                          snapshot.data![index]['username'] ??
                                              'Username',
                                          style:
                                              TextStyle(color: Colors.white)),
                                    ),
                                    AspectRatio(
                                      aspectRatio: videoControllers[index]
                                          .value
                                          .aspectRatio,
                                      child:
                                          VideoPlayer(videoControllers[index]),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              SizedBox(width: 8),
                                              Expanded(
                                                child: Text(
                                                    snapshot.data![index]
                                                            ['username'] ??
                                                        'User',
                                                    style: TextStyle(
                                                        color: Colors.white)),
                                              ),
                                              OutlinedButton(
                                                onPressed: () {
                                                  // handle follow action here
                                                },
                                                child: Text('Follow',
                                                    style: TextStyle(
                                                        color: Colors.white)),
                                                style: OutlinedButton.styleFrom(
                                                  side: BorderSide(
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 4),
                                          // space between row and description
                                          Text(
                                              snapshot.data![index]
                                                      ['description'] ??
                                                  '',
                                              style: TextStyle(
                                                  color: Colors.white)),
                                          SizedBox(height: 4),
                                          // space between description and likes/comments count
                                          Row(
                                            children: [
                                              Icon(Icons.favorite,
                                                  color: Colors.red),
                                              Text(
                                                  snapshot.data![index]['likes']
                                                          .toString() ??
                                                      '0',
                                                  style: TextStyle(
                                                      color: Colors.white)),
                                              SizedBox(width: 16),
                                              // space between likes count and comments count
                                              Icon(Icons.comment,
                                                  color: Colors.white),
                                              Text(
                                                  snapshot.data![index]
                                                              ['comments']
                                                          .toString() ??
                                                      '0',
                                                  style: TextStyle(
                                                      color: Colors.white)),
                                            ],
                                          ),
                                          SizedBox(height: 4),
                                          // space between likes/comments count and text field
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              children: [
                                                FutureBuilder<String>(
                                                  future:
                                                      _getImageUrlFromSharedPreferences(),
                                                  builder:
                                                      (BuildContext context,
                                                          AsyncSnapshot<String>
                                                              snapshot) {
                                                    if (snapshot
                                                            .connectionState ==
                                                        ConnectionState
                                                            .waiting) {
                                                      return CircularProgressIndicator();
                                                    } else {
                                                      return CircleAvatar(
                                                        radius: 30,
                                                        backgroundImage:
                                                            NetworkImage(
                                                                snapshot.data!),
                                                      );
                                                    }
                                                  },
                                                ),
                                                SizedBox(width: 8),
                                                // space between avatar and text field
                                                Expanded(
                                                  child: TextField(
                                                    decoration: InputDecoration(
                                                      border:
                                                          OutlineInputBorder(),
                                                      hintText:
                                                          'Add comment...',
                                                      hintStyle: TextStyle(
                                                          color: Colors.white
                                                              .withOpacity(
                                                                  0.6)),
                                                      filled: true,
                                                      fillColor: Colors.white24,
                                                    ),
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Positioned(
                                top: 8,
                                right: 8,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    SizedBox(height: 8),
                                    Container(
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.black.withOpacity(0.5),
                                      ),
                                      child: IconButton(
                                        icon: Icon(Icons.favorite),
                                        color: Colors.white,
                                        onPressed: () {
                                          // Handle like action
                                        },
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    Container(
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.black.withOpacity(0.5),
                                      ),
                                      child: IconButton(
                                        icon: Icon(Icons.comment),
                                        color: Colors.white,
                                        onPressed: () {
                                          // Handle comment action
                                        },
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    Container(
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.black.withOpacity(0.5),
                                      ),
                                      child: IconButton(
                                        icon: Icon(Icons.share),
                                        color: Colors.white,
                                        onPressed: () {
                                          // Handle share action
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ],
    );
  }

  @override
  void dispose() {
    for (var controller in videoControllers) {
      controller.dispose();
    }
    super.dispose();
  }
}

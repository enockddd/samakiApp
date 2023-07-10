import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/user.dart';
import '../../models/user2.dart';
import '../../services/apiService.dart';
import '../../widgets/background_image.dart';
import '../imageRetreave/imagesByids.dart';
import '../userProfile/otherProfileClass.dart';

class HomeFeed extends StatefulWidget {
  final String? image;
  final String? username;
  final String? imageId;
  final String? email;

  HomeFeed({this.image, this.username, this.imageId, this.email, });

  @override
  _HomeFeedState createState() => _HomeFeedState();
}

class _HomeFeedState extends State<HomeFeed> {
  Future<List<Map<String, dynamic>>>? _futurePosts;
  final _apiService = ApiService();

  Future<String> _getImageUrlFromSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String imageUrl = prefs.getString('image') ?? 'https://example.com/default.jpg';
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
              child:  FutureBuilder<List<Users2>>(
                future: _apiService.getAllUsers(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: snapshot.data?.length ?? 0,
                      itemBuilder: (context, index) {
                        Users2? user = snapshot.data?[index];
                        return Container(
                          margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  if (user != null) {
                                    print('User ID: ${user.email}');
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => otherProfile(userId: user.user_id,email:user.email,username:user.username),
                                      ),
                                    );
                                  }
                                },
                                child: CircleAvatar(
                                  radius: 30,
                                  backgroundImage: NetworkImage(user?.profile_picture ?? 'https://example.com/default.jpg'),
                                ),
                              ),
                              SizedBox(height: 4),
                              SizedBox(height: 4),
                              Text(
                                user?.username ?? 'User',
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  }
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
                        final String imageId = snapshot.data![index]['user_id'];
                        Image.network(snapshot.data![index]
                        ['content_url']); // Retrieve the image ID

                        return GestureDetector(
                          onTap: () {
                            final String docId = snapshot.data![index]['id'];
                            final String? img = snapshot.data![index]['content_url'];
                            print('Document ID: $docId');
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => ImageById(documentId: docId, image: img),
                              ),
                            );
                          },
                          child: Card(
                            elevation: 4,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  child: Image.network(
                                    snapshot.data![index]['content_url'],
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      print(error);  // Log the error for debugging purposes
                                      return Image.asset('assets/images/placeholder.jpg');  // Display a placeholder image on error
                                    },
                                  ),
                                ),
                                // Container(
                                //   height: 150,
                                //   decoration: BoxDecoration(
                                //     image: DecorationImage(
                                //       image: AssetImage('assets/images/1.jpg'),
                                //       fit: BoxFit.cover,
                                //     ),
                                //     borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                                //   ),
                                // ),
                                Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Title of the Content',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: 8),
                                      Text(
                                        'Author Name',
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      SizedBox(height: 8),
                                      Text(
                                        'Content Preview Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                                        style: TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                      SizedBox(height: 16),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            width: 100,
                                            height: 100,
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                image: AssetImage('assets/images/thumbnail.jpg'),
                                                fit: BoxFit.cover,
                                              ),
                                              borderRadius: BorderRadius.circular(10),
                                            ),
                                          ),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Tags: #Tag1, #Tag2, #Tag3',
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                              SizedBox(height: 8),
                                              Row(
                                                children: [
                                                  IconButton(
                                                    onPressed: () {},
                                                    icon: Icon(Icons.favorite_border),
                                                  ),
                                                  IconButton(
                                                    onPressed: () {},
                                                    icon: Icon(Icons.share),
                                                  ),
                                                  IconButton(
                                                    onPressed: () {},
                                                    icon: Icon(Icons.bookmark_border),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 16),
                                      Row(
                                        children: [
                                          Icon(Icons.calendar_today, size: 16, color: Colors.grey),
                                          SizedBox(width: 4),
                                          Text(
                                            'Published: July 10, 2023',
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.grey,
                                            ),
                                          ),
                                          SizedBox(width: 16),
                                          Icon(Icons.remove_red_eye, size: 16, color: Colors.grey),
                                          SizedBox(width: 4),
                                          Text(
                                            'Views: 100',
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.grey,
                                            ),
                                          ),
                                          SizedBox(width: 16),
                                          Icon(Icons.comment, size: 16, color: Colors.grey),
                                          SizedBox(width: 4),
                                          Text(
                                            'Comments: 10',
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.grey,
                                            ),
                                          ),
                                          SizedBox(width: 16),
                                          Icon(Icons.star, size: 16, color: Colors.grey),
                                          SizedBox(width: 4),
                                          Text(
                                            'Rating: 4.5',
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
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
}

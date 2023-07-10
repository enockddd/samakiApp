import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../widgets/background_image.dart';

class ImageById extends StatelessWidget {
  final String documentId;
  final String? image;  // <-- declare the image property here

  ImageById({required this.documentId, this.image});

  Future<Map<String, dynamic>> fetchPost() async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    DocumentSnapshot doc = await db.collection('posts').doc(documentId).get();
    return doc.data() as Map<String, dynamic>;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
        children:[
          backgroundImage(
            image:"assets/images/1.jpg",
          ),
          Scaffold(
            body: FutureBuilder<Map<String, dynamic>>(
              future: fetchPost(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return Stack(
                    children: [
                      backgroundImage(
                        image:"assets/images/1.jpg",
                      ),

                      Container(
                        height: MediaQuery.of(context).size.height,  // the height of the screen
                        width: MediaQuery.of(context).size.width,   // the width of the screen
                        child: Image.network(
                          snapshot.data!['content_url'],
                          fit: BoxFit.contain,
                        ),
                      ),

                      // User avatar and description
                      Positioned(
                        left: 8,
                        top: 8,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                           CircleAvatar(
                          radius: 30,
                          backgroundImage: NetworkImage(image ?? 'https://example.com/default.jpg'),
                        ),
                            SizedBox(height: 4),
                            Text(
                              snapshot.data!['description'] ?? '',
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),

                      // Three dots at right top corner
                      Positioned(
                        top: 8,
                        right: 8,
                        child: IconButton(
                          icon: Icon(Icons.more_vert),
                          onPressed: () {
                            // Handle three dots action
                          },
                        ),
                      ),

                      // Floating action button at bottom
                      Positioned(
                        bottom: 8,
                        right: 8,
                        child: FloatingActionButton(
                          child: Icon(Icons.add),
                          onPressed: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (context) => Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: Icon(Icons.favorite),
                                    onPressed: () {
                                      // Handle like action
                                    },
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.comment),
                                    onPressed: () {
                                      // Handle comment action
                                    },
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.share),
                                    onPressed: () {
                                      // Handle share action
                                    },
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.message),
                                    onPressed: () {
                                      // Handle message action
                                    },
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  );
                }
              },
            ),
          ),
        ]
    );
  }
}

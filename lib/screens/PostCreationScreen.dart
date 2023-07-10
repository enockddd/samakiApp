import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:samaki_social_app/services/firebase_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';


import '../SamakiHomeScreen/SamakiHomeScreen.dart';
import '../services/apiService.dart';
import '../services/postgres_service.dart';

class PostCreationScreen extends StatefulWidget {
  @override
  _PostCreationScreenState createState() => _PostCreationScreenState();
}

class _PostCreationScreenState extends State<PostCreationScreen> {
  bool _isSubmitting = false;
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _tagController = TextEditingController();
  String _postType = 'image';
  List<String> _tags = [];
  XFile? _pickedFile;
  VideoPlayerController? _videoPlayerController;
  final FirebaseService _firebaseService = FirebaseService();
  final ApiService _apiService = ApiService();
  String? _token;
  String? _username;
  String? _userId;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _token = prefs.getString('image');
      _username = prefs.getString('username');
      _userId = prefs.getString('userId');
    });
  }


  @override
  void dispose() {
    _tagController?.dispose();
    _videoPlayerController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                ),
                maxLines: 4,
              ),
              SizedBox(height: 16.0),
              DropdownButtonFormField<String>(
                value: _postType,
                items: [
                  DropdownMenuItem(value: 'image', child: Text('Image')),
                  DropdownMenuItem(value: 'video', child: Text('Video')),
                  DropdownMenuItem(value: 'short', child: Text('Short')),
                ],
                onChanged: (String? newValue) {
                  setState(() {
                    _postType = newValue!;
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Post Type',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16.0),
              ElevatedButton.icon(
                onPressed: () async {
                  final picker = ImagePicker();

                  if (_postType == 'image') {
                    _pickedFile =
                        await picker.pickImage(source: ImageSource.gallery);
                  } else if (_postType == 'video') {
                    _pickedFile =
                        await picker.pickVideo(source: ImageSource.gallery);
                  }

                  if (_pickedFile != null) {
                    if (_postType == 'video') {
                      _videoPlayerController =
                          VideoPlayerController.file(File(_pickedFile!.path))
                            ..initialize().then((_) {
                              setState(() {});
                              _videoPlayerController!.play();
                            });
                    }
                    setState(() {
                      _pickedFile = _pickedFile;
                    });
                  }
                },
                icon: Icon(Icons.file_upload),
                label: Text('Upload $_postType'),
              ),
              if (_pickedFile != null) ...[
                SizedBox(height: 16.0),
                _postType == 'image'
                    ? Image.file(File(_pickedFile!.path), height: 200)
                    : Container(
                        height: 200,
                        child: _videoPlayerController != null &&
                                _videoPlayerController!.value.isInitialized
                            ? VideoPlayer(_videoPlayerController!)
                            : Text('Error loading video'),
                      ),
              ],
              SizedBox(height: 16.0),
              Wrap(
                spacing: 8.0,
                runSpacing: 8.0,
                children: _tags
                    .map(
                      (tag) => Chip(
                    label: Text(tag),
                    onDeleted: () {
                      setState(() {
                        _tags.remove(tag);
                      });
                    },
                  ),
                )
                    .toList(),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: _tagController,
                decoration: InputDecoration(
                  labelText: 'Add Tag',
                  border: OutlineInputBorder(),
                ),
                onSubmitted: (String value) {
                  if (value.isNotEmpty) {
                    setState(() {
                      _tags.add(value);
                      _tagController.clear(); // Clear the input field after adding the tag
                    });
                  }
                },
              ),
              SizedBox(height: 16.0),
              Center(
                child:ElevatedButton(
                  onPressed: _isSubmitting ? null : _submitPost, // Disable button while submitting
                  child: Text(_isSubmitting ? 'Submitting...' : 'Submit Post'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submitPost() async {
    setState(() {
      _isSubmitting = true;  // Start submission process
    });

    print(_userId);
    print(_username);

    try {
      if (_pickedFile != null) {
        // Upload the file to Firebase Storage
        String mediaUrl = await FirebaseService.uploadFile(
          File(_pickedFile!.path),
          _postType,
          _descriptionController.text,
        );

        // Convert the tags list to a comma-separated string
        String tagsString = _tags.join(',');
        // Create a map to hold the post details
        Map<String, dynamic> postDetails = {
          "content_url": mediaUrl,
          "description": _descriptionController.text,
          "post_type": _postType,
          "tags":tagsString,
          "user_id": _userId,
          "username": _username,
          "comments": 0,
          "likes": 0,
          "created_at": DateTime.now().toIso8601String(),
          "updated_at": DateTime.now().toIso8601String(),
        };

        // Save the post details to Firebase Firestore
        FirebaseFirestore firestore = FirebaseFirestore.instance;
        CollectionReference postsRef = firestore.collection('posts');
        await postsRef.add(postDetails);

       // Save the post details to the MySQL database
      await _apiService.createPost(postDetails, _token);

        // Show success message and navigate back
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Post submitted successfully.')),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => SamakiHomeScreen(),
          ),
        );
      } else {
        throw Exception('Please upload an image or a video.');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error submitting post: $e')),
      );
    } finally {
      setState(() {
        _isSubmitting = false;  // End submission process
      });
    }
  }


}

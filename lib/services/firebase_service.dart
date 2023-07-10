import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  static final FirebaseStorage _storage = FirebaseStorage.instance;
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static Future<String> uploadFile(File file, String postType, String description) async {
    // Generate a unique file name based on current timestamp
    String fileName = '${DateTime.now().millisecondsSinceEpoch}';

    // Upload the file to Firebase Storage
    TaskSnapshot snapshot = await _storage
        .ref()
        .child('posts/$postType/$fileName')
        .putFile(file);

    // Get the download URL for the uploaded file
    String downloadUrl = await snapshot.ref.getDownloadURL();

    return downloadUrl;
  }

  static Future<void> updateFirestore(String description, String postType, String downloadUrl) async {
    // Add a new document to the Firestore collection
    await _firestore.collection('posts').add({
      'description': description,
      'postType': postType,
      'mediaUrl': downloadUrl,
      'likes': 0,
      'dislikes': 0,
      'comments': [],
      'tags':[]
    });
  }
}
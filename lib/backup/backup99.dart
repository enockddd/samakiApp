// void _submitPost() async {
//   setState(() {
//     _isSubmitting = true;  // Start submission process
//   });
//
//   print(_userId);
//   print(_username);
//
//   try {
//     if (_pickedFile != null) {
//       // Upload the file to Firebase Storage
//       String mediaUrl = await FirebaseService.uploadFile(
//         File(_pickedFile!.path),
//         _postType,
//         _descriptionController.text,
//       );
//
//       // Create a map to hold the post details
//       Map<String, dynamic> postDetails = {
//         "content_url": mediaUrl,
//         "description": _descriptionController.text,
//         "post_type": _postType,
//         "tags": _tags.join(','),
//         "user_id": _userId,
//         "username": _username,
//         "comments": 0,
//         "likes": 0,
//         "created_at": DateTime.now().toIso8601String(),
//         "updated_at": DateTime.now().toIso8601String(),
//       };
//
//       // Save the post details to the MySQL database
//       await _apiService.createPost(postDetails, _token);
//
//       // Show success message and navigate back
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Post submitted successfully.')),
//       );
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(
//           builder: (context) => SamakiHomeScreen(),
//         ),
//       );
//     } else {
//       throw Exception('Please upload an image or a video.');
//     }
//   } catch (e) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text('Error submitting post: $e')),
//     );
//   } finally {
//     setState(() {
//       _isSubmitting = false;  // End submission process
//     });
//   }
// //
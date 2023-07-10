// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:samaki_app_screens/services/firebase_service.dart';
// import 'package:samaki_app_screens/services/postgres_service.dart';
//
// class PostCreationScreen extends StatefulWidget {
//   @override
//   _PostCreationScreenState createState() => _PostCreationScreenState();
// }
//
// class _PostCreationScreenState extends State<PostCreationScreen> {
//   TextEditingController _descriptionController = TextEditingController();
//   late String _postType;
//   late File _image;
//   final ImagePicker _picker = ImagePicker();
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: EdgeInsets.all(16.0),
//           child: Form(
//             key: _formKey,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 TextFormField(
//                   controller: _descriptionController,
//                   decoration: InputDecoration(
//                     labelText: "Description",
//                   ),
//                   validator: (value) {
//                     if (value!.isEmpty) {
//                       return "Please enter a description";
//                     }
//                     return null;
//                   },
//                 ),
//                 SizedBox(height: 16.0),
//                 DropdownButtonFormField<String>(
//                   value: _postType,
//                   hint: Text("Select post type"),
//                   items: ["Image", "Video", "Short"]
//                       .map(
//                         (type) => DropdownMenuItem(
//                       value: type,
//                       child: Text(type),
//                     ),
//                   )
//                       .toList(),
//                   onChanged: (value) {
//                     setState(() {
//                       _postType = value!;
//                     });
//                   },
//                   validator: (value) {
//                     if (value == null) {
//                       return "Please select a post type";
//                     }
//                     return null;
//                   },
//                 ),
//                 SizedBox(height: 16.0),
//                 _image == null
//                     ? Text("No image selected")
//                     : Image.file(_image, height: 200),
//                 SizedBox(height: 16.0),
//                 ElevatedButton(
//                   onPressed: () async {
//                     final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
//                     setState(() {
//                       _image = File(pickedFile!.path);
//                     });
//                   },
//                   child: Text("Select Image"),
//                 ),
//                 SizedBox(height: 16.0),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: [
//                     ElevatedButton(
//                       onPressed: () async {
//                         if (_formKey.currentState!.validate()) {
//                           // Upload the file to Firebase Storage
//                           String imageUrl = await FirebaseService.uploadFile(
//                               _image, _postType, _descriptionController.text);
//
//                          // Save the post details to the PostgreSQL database
//                          //  await PostgresService.createPost(
//                          //      _descriptionController.text, _postType, imageUrl);
//
//                           await PostgresService().createPost(
//                             _descriptionController.text,
//                             _postType,
//                             imageUrl,
//                           );
//
//
//                           // Update Firestore with real-time data
//                           await FirebaseService.updateFirestore(
//                               _descriptionController.text, _postType, imageUrl);
//
//                           // Navigate back
//                           Navigator.pop(context);
//                         }
//                       },
//                       child: Text("Submit"),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
//
//
//
//

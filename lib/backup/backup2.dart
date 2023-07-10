// import 'package:flutter/material.dart';
//
// import '../screens/PostCreationScreen.dart';
//
// class SamakiHomeScreen extends StatefulWidget {
//   final String? image;
//   final String? username;
//   final String? userId;
//
//   SamakiHomeScreen({this.image, this.username, this.userId});
//   @override
//   _SamakiHomeScreenState createState() => _SamakiHomeScreenState();
// }
//
// class _SamakiHomeScreenState extends State<SamakiHomeScreen> {
//   int _selectedIndex = 0;
//
//   static List<Widget> _widgetOptions = [
//     HomeFeed(),
//     Text('Search/Discover'),
//     PostCreationScreen(),
//     Text('Activity/Notifications'),
//     Text('Profile'),
//   ];
//
//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       length: 4,
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text('Samaki'),
//           backgroundColor: Colors.deepPurple,
//           bottom: _selectedIndex == 0
//               ? TabBar(
//             tabs: [
//               Tab(text: 'All'),
//               Tab(text: 'News'),
//               Tab(text: 'Images'),
//               Tab(text: 'Videos'),
//             ],
//           )
//               : null,
//         ),
//         body: _selectedIndex == 0
//             ? TabBarView(
//           children: [
//             HomeFeed(),
//             HomeFeed(),
//             HomeFeed(),
//             HomeFeed(),
//           ],
//         )
//             : _widgetOptions.elementAt(_selectedIndex),
//         bottomNavigationBar: BottomNavigationBar(
//           items: [
//             BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
//             BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
//             BottomNavigationBarItem(icon: Icon(Icons.add_box), label: 'Post'),
//             BottomNavigationBarItem(icon: Icon(Icons.notifications), label: 'Activity'),
//             BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
//           ],
//           currentIndex: _selectedIndex,
//           onTap: _onItemTapped,
//           selectedItemColor: Colors.deepPurple,
//           unselectedItemColor: Colors.grey,
//         ),
//       ),
//     );
//   }
// }
//
// class HomeFeed extends StatelessWidget {
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
//                       backgroundImage: AssetImage('assets/images/user_profile.jpg'),
//                     ),
//                     SizedBox(height: 4),
//                     Text('User'),
//                   ],
//                 ),
//               );
//             },
//           ),
//         ),
//         Expanded(
//           child: GridView.builder(
//             gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//               crossAxisCount: 3,
//               mainAxisSpacing: 4,
//               crossAxisSpacing: 4,
//             ),
//             itemCount: 30,
//             itemBuilder: (context, index) {
//               // Replace the AssetImage with the actual image fetched from your database
//               return Image.asset('assets/images/sample_post_image.jpg', fit: BoxFit.cover);
//             },
//           ),
//         ),
//       ],
//     );
//   }
// }
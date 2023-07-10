// Container(
// child: Visibility(
// visible: _searchResults.isNotEmpty,
// child: Container(
// margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
// child: Wrap(
// children: [
// for (Users3 user in _searchResults)
// Padding(
// padding: EdgeInsets.all(8.0),
// child: Column(
// children: [
// GestureDetector(
// onTap: () {
// // Handle the tap on a search result user
// // You can navigate to the user's profile or perform other actions
// },
// child: CircleAvatar(
// radius: 30,
// backgroundImage: NetworkImage(
// user.profile_picture ??
// 'https://example.com/default.jpg',
// ),
// ),
// ),
// SizedBox(height: 4),
// Text(
// user.username ?? 'User',
// style: TextStyle(color: Colors.white),
// ),
// Text(
// user.email ?? '',
// style: TextStyle(color: Colors.white),
// ),
// ],
// ),
// ),
// ],
// ),
// ),
// ),
// ),
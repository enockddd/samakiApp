import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:samaki_social_app/widgets/pallete.dart';

import '../models/user3.dart';
import '../services/apiService.dart';
class searchField extends StatefulWidget {
  const searchField({Key? key}) : super(key: key);

  @override
  _searchFieldState createState() => _searchFieldState();
}

class _searchFieldState extends State<searchField> {
  final TextEditingController _searchController = TextEditingController();
  List<Users3> _searchResults = [];

  void _performSearch() {
    String query = _searchController.text;
    if (query.isNotEmpty) {
      ApiService apiService = ApiService();
      apiService.searchUsers(query).then((List<Users3> searchResults) {
        setState(() {
          _searchResults = searchResults;
        });
      }).catchError((error) {
        // Handle the error
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Container(
        height: size.height * 0.08,
        width: size.width * 0.8,
        decoration: BoxDecoration(
          color: Colors.grey[500]?.withOpacity(0.5),
          borderRadius: BorderRadius.circular(16),
        ),
          child:
                Row(
                  children: [
                    Container(
                      child: Icon(
                        Icons.search,
                        size: 28,
                        color: kWhite,
                      ),
                    ),
                    SizedBox(width: 20),
                    Expanded(
                      child: TextFormField(
                        controller: _searchController,
                        style: kBodyText,
                        decoration: InputDecoration.collapsed(
                          hintText: 'Search',
                          hintStyle: kBodyText,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: _performSearch,
                      icon: Icon(
                        Icons.arrow_forward_ios,
                        color: kWhite,
                      ),
                    ),
                  ],
                ),

      ),
    );
  }
}

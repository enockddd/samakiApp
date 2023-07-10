import 'package:flutter/material.dart';
import '../../models/user3.dart';
import '../../services/apiService.dart';
import '../../widgets/background_image.dart';
import '../../widgets/pallete.dart';
import '../../widgets/searchResult.dart';
import '../../widgets/searchWidget.dart';

class searchClass extends StatefulWidget {
  const searchClass({Key? key}) : super(key: key);


  @override
  _searchClassState createState() => _searchClassState();
}

class _searchClassState extends State<searchClass> {
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
    return Stack(
      children: [
        backgroundImage(
          image: "assets/images/1.jpg",
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  alignment: Alignment.topCenter,
                  child: SizedBox(height: 20),
                ),
                Container(
                  alignment: Alignment.topCenter,
                  child: Padding(
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
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  alignment: Alignment.topCenter,
                  child: SearchResult(searchResults: _searchResults),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

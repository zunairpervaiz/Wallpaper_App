import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:wallpaper_hub/Data/data.dart';
import 'package:wallpaper_hub/Model/wallpaper_model.dart';
import 'package:wallpaper_hub/Widget/Widget.dart';
import 'package:http/http.dart' as http;

class Search extends StatefulWidget {
  final searchText;
  Search({this.searchText});

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {

  String searchText='';

  List<WallpaperModel> wallpapers = new List();
  var responce;

  getSearchWallpapers(String query) async {
    responce = await http.get(
        'https://api.pexels.com/v1/search?query=$query&per_page=15&page=1',
        headers: {"Authorization": apiKey});
    //print(responce.body.toString());

    Map<String, dynamic> jsonData = jsonDecode(responce.body);
    jsonData['photos'].forEach((element) {
      // print(element);
      WallpaperModel wallpaperModel = new WallpaperModel();
      wallpaperModel = WallpaperModel.fromMap(element);
      wallpapers.add(wallpaperModel);
    });
    setState(() {
      print(responce.body.toString());
    });
  }

  @override
  void initState() {
    getSearchWallpapers(widget.searchText);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0.0,
        title: brandName(),
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.black87),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Card(
                  elevation: 0.0,
                  margin: EdgeInsets.symmetric(horizontal: 16.0),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadiusDirectional.circular(12.0)),
                  color: Colors.grey[200],
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: TextField(
                      onChanged: (value) {
                        if (searchText == '') {
                          return;
                        }
                        searchText = value;
                      },
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Search",
                        suffixIcon: Padding(
                          padding: const EdgeInsets.only(right: 16.0),
                          child: GestureDetector(
                            onTap: () {
                              print("searchText $searchText");
                              getSearchWallpapers(searchText);
                            },
                            child: Container(child: Icon(Icons.search)),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 12.0,
                ),
                wallpapers == null
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : wallpaperList(
                        wallpapers: wallpapers,
                        context: context,
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

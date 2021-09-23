import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:wallpaper_hub/Data/data.dart';
import 'package:wallpaper_hub/Model/wallpaper_model.dart';
import 'package:wallpaper_hub/UI/Search.dart';
import 'package:wallpaper_hub/Widget/CategoriesCard.dart';
import 'package:http/http.dart' as http;
import 'package:wallpaper_hub/Widget/Widget.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<WallpaperModel> wallpapers = new List();

  String searchText;

  getTrendingWallpapers() async {
    try {
      var responce = await http.get(
          'https://api.pexels.com/v1/curated?per_page=15&page=1',
          headers: {"Authorization": apiKey});
      // print(responce.body.toString());

      Map<String, dynamic> jsonData = jsonDecode(responce.body);
      jsonData['photos'].forEach((element) {
        // print(element);
        WallpaperModel wallpaperModel = new WallpaperModel();
        wallpaperModel = WallpaperModel.fromMap(element);
        wallpapers.add(wallpaperModel);
      });
      setState(() {});
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  void initState() {
    getTrendingWallpapers();
    setState(() {});
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
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          child: Container(
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
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Search(
                                            searchText: searchText,
                                          )));
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

                //Horizontal Categoris
                CategoriesCard(),

                SizedBox(
                  height: 12.0,
                ),

                wallpaperList(
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

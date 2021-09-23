import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:wallpaper_hub/Model/wallpaper_model.dart';
import 'package:wallpaper_hub/UI/Search.dart';

List categoriesImg = [
  'https://www.stocksy.com/blog/wp-content/uploads/2019/09/Stocksy_comp_2701337.jpg',
  'https://www.stocksy.com/blog/wp-content/uploads/2019/09/Stocksy_comp_1083414-1.jpg',
  'https://www.stocksy.com/blog/wp-content/uploads/2019/09/Stocksy_comp_2757923.jpg',
  'https://www.telegraph.co.uk/content/dam/Travel/Destinations/Asia/India/Mumbai/gateway-of-india-mumbai.jpg',
  'https://www.stocksy.com/blog/wp-content/uploads/2019/09/Stocksy_comp_1413843.jpg',
  'https://tryengineering.org/wp-content/uploads/bigstock-Skyscraper-Glass-Facades-On-A-204198055.jpg',
  'https://www.stocksy.com/blog/wp-content/uploads/2019/09/Stocksy_comp_1287816.jpg',
  'https://www.stocksy.com/blog/wp-content/uploads/2019/09/Stocksy_comp_1231375.jpg',
  'https://www.stocksy.com/blog/wp-content/uploads/2019/09/Stocksy_comp_2588431.jpg',
  'https://www.stocksy.com/blog/wp-content/uploads/2019/09/Stocksy_comp_2457971-1.jpg',
  'https://www.stocksy.com/blog/wp-content/uploads/2019/09/Stocksy_comp_1206759.jpg',
  'https://www.stocksy.com/blog/wp-content/uploads/2019/09/Stocksy_comp_1830479.jpg',
];

List categoriesTitle = [
  "Abstract",
  'Fashion',
  "Food",
  "India",
  "Adventure", 
  "Architectural",
  "Black-White",
  "Business",
  "Candid",
  "Creative",
  "Documentary",
  'Event',
];

List<WallpaperModel> wallpapers = new List();

class CategoriesCard extends StatefulWidget {
  @override
  _CategoriesCardState createState() => _CategoriesCardState();
}

class _CategoriesCardState extends State<CategoriesCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.0,
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categoriesTitle.length - 1,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 1.0),
            child: GestureDetector(
              onTap: () {
                print("Button press");
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Search(
                              searchText: categoriesTitle[index],
                            )));
              },
              child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Stack(
                    children: [
                      Container(
                        width: 82.0,
                        height: 60.0,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: CachedNetworkImage(
                            imageUrl: categoriesImg[index],
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Container(
                        width: 82.0,
                        height: 60.0,
                        alignment: Alignment.center,
                        child: Text(categoriesTitle[index],
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 0.25,
                              fontSize: 12.0,
                            )),
                      ),
                    ],
                  )),
            ),
          );
        },
      ),
    );
  }
}

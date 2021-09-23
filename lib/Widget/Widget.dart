import 'package:flutter/material.dart';
import 'package:wallpaper_hub/Model/wallpaper_model.dart';
import 'package:wallpaper_hub/UI/ImageView.dart';
import 'package:cached_network_image/cached_network_image.dart';


Widget brandName() {
  return Wrap(
    children: [
      Text(
        "Wallpaper",
        style: TextStyle(
          color: Colors.black87,
          fontSize: 18.0,
        ),
      ),
      Text(
        "Hub",
        style: TextStyle(
          color: Colors.indigo,
          fontSize: 19.0,
        ),
      )
    ],
  );
}

Widget wallpaperList({List<WallpaperModel> wallpapers, BuildContext context}) {
  return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      childAspectRatio: 0.6,
      mainAxisSpacing: 6.0,
      crossAxisSpacing: 6.0,
      children: wallpapers.map((wallpaper) {
        return  Hero(
          tag: wallpaper.src.portrait,
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ImageView(wallpaper.src.portrait)));
            },
            child: wallpaper.src.portrait == null ? Center(
          child: CircularProgressIndicator(
            backgroundColor: Colors.indigo, 
          ),
        ) : GridTile(
                child: Container(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: CachedNetworkImage(imageUrl: wallpaper.src.portrait,fit: BoxFit.cover),
              ),
            )),
          ),
        ); 
      }).toList()
    );  
}

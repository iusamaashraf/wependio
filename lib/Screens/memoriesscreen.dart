import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';

import '../constants.dart';

class Memoriesmainscreen extends StatefulWidget {
  const Memoriesmainscreen({Key? key}) : super(key: key);

  @override
  _MemoriesmainscreenState createState() => _MemoriesmainscreenState();
}

class _MemoriesmainscreenState extends State<Memoriesmainscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        bottom: PreferredSize(
            child: Container(),
            preferredSize: Size(MediaQuery.of(context).size.width, 10)),
        automaticallyImplyLeading: true,
        centerTitle: false,
        title: Text(
          "Memories",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 22,
          ),
        ),
        // leadingWidth: 50,
        backgroundColor:
            AdaptiveTheme.of(context).theme.brightness == Brightness.light
                ? maincolor
                : Color(0xff4F5666),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(
                  "Assets/Images/message.svg",
                  height: 24,
                  width: 24,
                  color: Colors.white,
                ),
                SizedBox(
                  width: 20,
                ),
                SvgPicture.asset(
                  "Assets/Images/notification.svg",
                  height: 24,
                  width: 24,
                  color: Colors.white,
                ),
                SizedBox(
                  width: 20,
                ),
                SvgPicture.asset(
                  "Assets/Images/add.svg",
                  height: 24,
                  width: 24,
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            StaggeredGrid.count(
              crossAxisCount: 4,
              mainAxisSpacing: 4,
              crossAxisSpacing: 4,
              children: [
                StaggeredGridTile.count(
                  crossAxisCellCount: 2,
                  mainAxisCellCount: 2,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      "https://images.unsplash.com/photo-1572204443441-3859041b6c88?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8cGxhbmUlMjB3aW5kb3d8ZW58MHx8MHx8&w=1000&q=80",
                      fit: BoxFit.cover,
                      // height: 300,
                    ),
                  ),
                ),
                StaggeredGridTile.count(
                  crossAxisCellCount: 2,
                  mainAxisCellCount: 2,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      "https://img.freepik.com/free-photo/couple-family-traveling-together_1150-7772.jpg?w=2000",
                      fit: BoxFit.cover,
                      // height: 300,
                    ),
                  ),
                ),
                StaggeredGridTile.count(
                  crossAxisCellCount: 4,
                  mainAxisCellCount: 2.5,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      "https://imageio.forbes.com/blogs-images/johnnyjet/files/2017/10/traveling-alone.jpg?format=jpg&width=960",
                      fit: BoxFit.cover,
                      // height: 300,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

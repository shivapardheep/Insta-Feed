import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:insta_news/screens/market_place_screen.dart';

import '../constants/colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, dynamic>> bottomNavigationBarItem = [
    {"icon": "assets/icons/explore_new.svg", "label": "Explore"},
    {"icon": "assets/icons/store.svg", "label": "Marketplace"},
    {"icon": "assets/icons/Search.svg", "label": "Search"},
    {"icon": "assets/icons/duration.svg", "label": "Activity"},
    {"icon": "assets/icons/profile.svg", "label": "Profile"},
  ];
  int currentIndex = 1;

  @override
  void initState() {
    super.initState();
  }

  List<Widget> screensList = [
    Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [Center(child: Text("No Data Found"))],
    ),
    MarketPlaceScreen(),
    Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [Center(child: Text("No Data Found"))],
    ),
    Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [Center(child: Text("No Data Found"))],
    ),
    Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [Center(child: Text("No Data Found"))],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: currentIndex != 1
          ? null
          : AppBar(
              title: Text(
                "Marketplace",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                ),
              ),
              flexibleSpace: Container(
                decoration: BoxDecoration(
                  gradient: AppColors.primaryBgGradient,
                ),
              ),
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.menu_open, color: Colors.white, size: 24),
                ),
              ],
            ),

      body: screensList[currentIndex],

      floatingActionButton: Container(
        padding: EdgeInsetsGeometry.symmetric(vertical: 8, horizontal: 20),
        decoration: BoxDecoration(
          gradient: AppColors.primaryDarkGradient,
          borderRadius: BorderRadius.circular(50),
        ),
        width: 160, // adjust as needed
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.add, color: Colors.white),
            SizedBox(width: 8),
            Text(
              "Post Request",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),

      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        currentIndex: currentIndex,
        type: BottomNavigationBarType.fixed,
        onTap: (i) {
          setState(() {
            currentIndex = i;
          });
        },
        selectedItemColor: Colors.black,

        items: List.generate(
          bottomNavigationBarItem.length,
          (i) => BottomNavigationBarItem(
            activeIcon: Stack(
              clipBehavior: Clip.none,
              children: [
                SvgPicture.asset(
                  bottomNavigationBarItem[i]['icon'],
                  color: AppColors.primaryColor,
                ),
                Visibility(
                  visible: i == 1,
                  child: Positioned(
                    top: -4,
                    right: -14,
                    child: Container(
                      padding: EdgeInsetsGeometry.symmetric(
                        vertical: 2,
                        horizontal: 4,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Text(
                        "NEW",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 8,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            icon: SvgPicture.asset(
              bottomNavigationBarItem[i]['icon'],
              color: Colors.grey,
            ),

            label: bottomNavigationBarItem[i]['label'],
          ),
        ).toList(),
      ),
    );
  }
}

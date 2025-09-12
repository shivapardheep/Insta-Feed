import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:insta_news/constants/colors.dart';

import '../bloc/models/FeedsModel.dart';
import '../services/services.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({super.key, required this.data});

  final MarketplaceRequest data;

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  MarketplaceRequest? data;

  @override
  void initState() {
    super.initState();
    data = widget.data;
  }

  static const List<String> imagePaths = [
    'assets/icons/Frame.svg',
    'assets/icons/Frame-1.svg',
    'assets/icons/Frame-2.svg',
    'assets/icons/Frame-3.svg',
    'assets/icons/Frame-4.svg',
  ];

  String getRandomImage() {
    final random = Random();
    final randomPath = imagePaths[random.nextInt(imagePaths.length)];
    return randomPath;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        actionsPadding: EdgeInsets.only(right: 20),
        backgroundColor: Colors.white,
        elevation: 0, // remove default shadow
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Container(color: Colors.grey.shade200, height: 1.5),
        ),

        actions: [
          IconButton(
            onPressed: () {},
            icon: SvgPicture.asset(
              "assets/icons/delete.svg",
              color: AppColors.primaryColor,
            ),
          ),

          Container(
            height: 28,
            width: 32,
            // padding: EdgeInsetsGeometry.symmetric(vertical: 4, horizontal: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              gradient: AppColors.primaryBgGradient,
            ),
            child: Center(
              child: Icon(Icons.share, color: Colors.white, size: 16),
            ),
          ),
        ],
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            // head
            Container(
              height: 80,
              padding: EdgeInsetsGeometry.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                // borderRadius: BorderRadius.circular(20),
                color: Color(0xffF5F6FB),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //head
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Image.network(
                          data!.userDetails.profileImage,
                          fit: BoxFit.cover,
                          height: 56,
                          width: 56,
                        ),
                      ),
                      SizedBox(width: 10),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                data!.userDetails.name,
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                              // SvgPicture.asset("assets/icons/linkedin.svg"),
                              SizedBox(width: 4),

                              Image.asset(
                                "assets/icons/linkedin.png",
                                height: 12,
                                width: 12,
                                fit: BoxFit.cover,
                              ),
                              SizedBox(width: 4),

                              SvgPicture.asset("assets/icons/Verified.svg"),
                            ],
                          ),
                          Text(
                            "Senior Sales Manager",
                            style: TextStyle(
                              color: AppColors.secondaryTextColor,
                              fontSize: 12,
                            ),
                          ),
                          SizedBox(height: 4),

                          Row(
                            children: [
                              SvgPicture.asset("assets/icons/build.svg"),
                              SizedBox(width: 4),

                              Text(
                                "Meesho",
                                style: TextStyle(
                                  color: AppColors.secondaryTextColor,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Spacer(),

                      Text(
                        " ${Services().formatAgo(data!.createdAt)} ago",
                        style: TextStyle(
                          color: AppColors.secondaryTextColor,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            //body

            //body
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Looking for",
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.secondaryTextColor,
                    ),
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      SvgPicture.asset(getRandomImage()),
                      SizedBox(width: 10),
                      Text(
                        "Looking for ${data!.serviceType}",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  Divider(
                    height: 30,
                    thickness: 1,
                    color: AppColors.borderColor,
                  ),
                  Text(
                    "Highlights",
                    style: TextStyle(
                      fontSize: 12,
                      color: Color(0xffAAAAAA),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      FittedBox(
                        child: Container(
                          padding: EdgeInsetsGeometry.symmetric(
                            vertical: 6,
                            horizontal: 10,
                          ),
                          margin: EdgeInsets.only(bottom: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: Color(0xffF5F6FB),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.currency_rupee, size: 14),
                              SizedBox(width: 4),
                              Text(
                                "Budget: ${data!.requestDetails == null ? 0 : data!.requestDetails!.budget}",
                                style: const TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.secondaryTextColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      FittedBox(
                        child: Container(
                          padding: EdgeInsetsGeometry.symmetric(
                            vertical: 6,
                            horizontal: 10,
                          ),
                          margin: EdgeInsets.only(bottom: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: Color(0xffF5F6FB),
                          ),
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                "assets/icons/light.svg",
                                height: 14,
                                width: 14,
                                fit: BoxFit.cover,
                              ),
                              SizedBox(width: 4),
                              Text(
                                "Brand: ${data!.requestDetails == null ? 0 : data!.requestDetails!.brand}",
                                style: const TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.secondaryTextColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 14),

                  ///info
                  Text(
                    "Budget: ₹${data!.requestDetails == null ? 0 : data!.requestDetails!.budget}",
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 2),

                  Text(
                    "Brand: WanderFit Luggage",
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    "Location: Goa & Kerala",
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 2),
                  Text(
                    "Type: Lifestyle & Adventure travel content with a focus on young, urban audiences",
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 2),
                  Text(
                    "Language: English and Hindi",
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 2),
                  Text(
                    "Looking for a travel influencer who can showcase our premium luggage line in scenic beach and nature destinations. Content should emphasize ease of travel and durability of the product.",
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 18),

                  /// share
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsetsGeometry.symmetric(
                            vertical: 10,
                            horizontal: 10,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: Color(0xffe2fbea),
                          ),
                          child: Row(
                            children: [
                              // SvgPicture.asset("assets/icons/whatsapp.svg"),
                              Image.asset(
                                "assets/icons/whatsapp.png",
                                height: 16,
                                width: 16,
                                fit: BoxFit.cover,
                              ),
                              SizedBox(width: 4),
                              RichText(
                                text: TextSpan(
                                  style: TextStyle(
                                    color: Colors.black, // default text color
                                    fontSize: 12,
                                  ),
                                  children: [
                                    TextSpan(text: "Share via "),
                                    TextSpan(
                                      text: "WhatsApp",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      SizedBox(width: 10),

                      Expanded(
                        child: Container(
                          padding: EdgeInsetsGeometry.symmetric(
                            vertical: 10,
                            horizontal: 10,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: Color(0xffe0edf8),
                          ),
                          child: Row(
                            children: [
                              // SvgPicture.asset("assets/icons/linkedin.svg"),
                              Image.asset(
                                "assets/icons/linkedin.png",
                                height: 16,
                                width: 16,
                                fit: BoxFit.cover,
                              ),
                              SizedBox(width: 4),
                              RichText(
                                text: TextSpan(
                                  style: TextStyle(
                                    color: Colors.black, // default text color
                                    fontSize: 12,
                                  ),
                                  children: [
                                    TextSpan(text: "Share on "),
                                    TextSpan(
                                      text: "LinkedIn",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 22),

                  /// highlights
                  Text(
                    "Key Highlighted Details",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(0xffAAAAAA),
                    ),
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 40,
                              // color: Colors.green,
                              margin: EdgeInsets.only(bottom: 16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Category",
                                    style: TextStyle(fontSize: 12),
                                  ),
                                  SizedBox(height: 4),

                                  Text(
                                    "Lifestyle, Fashion",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: Color(0xffAAAAAA),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: 70,
                              // color: Colors.green,
                              margin: EdgeInsets.only(bottom: 16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Language",
                                    style: TextStyle(fontSize: 12),
                                  ),
                                  SizedBox(height: 4),

                                  Text(
                                    "Hindi, Kannada, Malayalam, Tamil & Telugu",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: Color(0xffAAAAAA),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: 40,
                              // color: Colors.green,
                              margin: EdgeInsets.only(bottom: 16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Required count",
                                    style: TextStyle(fontSize: 12),
                                  ),
                                  SizedBox(height: 4),

                                  Text(
                                    "15 - 20",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: Color(0xffAAAAAA),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: 85,
                              // color: Colors.green,
                              margin: EdgeInsets.only(bottom: 16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Brand collab with",
                                    style: TextStyle(fontSize: 12),
                                  ),
                                  SizedBox(height: 4),

                                  Text(
                                    "Swiggy",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: Color(0xffAAAAAA),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 40,
                              // color: Colors.green,
                              margin: EdgeInsets.only(bottom: 16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Platform",
                                    style: TextStyle(fontSize: 12),
                                  ),
                                  SizedBox(height: 4),

                                  Text(
                                    "Instagram, Youtube",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: Color(0xffAAAAAA),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: 70,
                              // color: Colors.green,
                              margin: EdgeInsets.only(bottom: 16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Location",
                                    style: TextStyle(fontSize: 12),
                                  ),
                                  SizedBox(height: 4),

                                  Text(
                                    "Bangalore, Tamilnadu, Kerala & GoaBangalore, Tamilnadu, Kerala & GoaBangalore",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: Color(0xffAAAAAA),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: 40,
                              // color: Colors.green,
                              margin: EdgeInsets.only(bottom: 16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Our Budget",
                                    style: TextStyle(fontSize: 12),
                                  ),
                                  SizedBox(height: 4),

                                  Text(
                                    "₹1,45,000",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: Color(0xffAAAAAA),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: 85,
                              // color: Colors.green,
                              margin: EdgeInsets.only(bottom: 16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Required followers",
                                    style: TextStyle(fontSize: 12),
                                  ),
                                  SizedBox(height: 4),

                                  FittedBox(
                                    child: Container(
                                      padding: EdgeInsetsGeometry.symmetric(
                                        vertical: 6,
                                        horizontal: 10,
                                      ),
                                      margin: EdgeInsets.only(bottom: 4),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(6),
                                        color: Color(0xffF5F6FB),
                                      ),
                                      child: Row(
                                        children: [
                                          SvgPicture.asset(
                                            "assets/icons/i.svg",
                                            height: 14,
                                          ),
                                          SizedBox(width: 4),
                                          Text(
                                            "500k -1M+",
                                            style: const TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.w700,
                                              color:
                                                  AppColors.secondaryTextColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  FittedBox(
                                    child: Container(
                                      padding: EdgeInsetsGeometry.symmetric(
                                        vertical: 6,
                                        horizontal: 10,
                                      ),
                                      margin: EdgeInsets.only(bottom: 4),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(6),
                                        color: Color(0xffF5F6FB),
                                      ),
                                      child: Row(
                                        children: [
                                          SvgPicture.asset(
                                            "assets/icons/i.svg",
                                          ),
                                          SizedBox(width: 4),
                                          Text(
                                            "10k - 100k",
                                            style: const TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.w700,
                                              color:
                                                  AppColors.secondaryTextColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

      bottomNavigationBar: Container(
        height: 130,
        padding: EdgeInsets.all(16),
        color: Colors.white,
        child: Column(
          children: [
            Row(
              children: [
                Icon(CupertinoIcons.clock, size: 16, color: Color(0xff3F51B5)),
                SizedBox(width: 4),
                Text(
                  " Your post has will be expired on 26 July",
                  style: TextStyle(fontSize: 12),
                ),
              ],
            ),
            SizedBox(height: 14),
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 48,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: Colors.white,
                        side: BorderSide(
                          color: AppColors.primaryColor, // border color
                          width: 2, // border width
                        ),
                      ),
                      child: Text(
                        "Edit",
                        style: TextStyle(
                          color: AppColors.primaryColor,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: SizedBox(
                    height: 48,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: AppColors.primaryColor,
                      ),
                      child: Text(
                        "Close",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
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

import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:insta_news/bloc/feeds/feeds_bloc.dart';

import '../bloc/models/FeedsModel.dart';
import '../constants/colors.dart';
import '../services/services.dart';
import '../widgets/search.dart';
import 'details_screen.dart';

class MarketPlaceScreen extends StatefulWidget {
  const MarketPlaceScreen({super.key});

  @override
  State<MarketPlaceScreen> createState() => _MarketPlaceScreenState();
}

class _MarketPlaceScreenState extends State<MarketPlaceScreen> {
  bool isLoading = false;
  List<MarketplaceRequest> feedsList = [];
  @override
  void initState() {
    super.initState();
    context.read<FeedsBloc>().add(FetchFeeds());
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      height: height,
      width: width,
      padding: EdgeInsets.all(16),

      child: Column(
        children: [
          SearchContainer(),
          FiltersList(),
          SizedBox(height: 10),

          BlocBuilder<FeedsBloc, FeedsState>(
            builder: (context, state) {
              debugPrint("state is : $state");
              if (state is LoadingState) {
                isLoading = true;
              }
              if (state is LoadedState) {
                isLoading = false;

                feedsList = state.response.marketplaceRequests;
              }
              if (state is ErrorState) {
                isLoading = false;

                Fluttertoast.showToast(msg: state.error);
              }
              return Expanded(
                child: isLoading
                    ? Center(
                        child: CircularProgressIndicator(
                          color: AppColors.primaryColor,
                        ),
                      )
                    : ListView.builder(
                        padding: EdgeInsetsGeometry.symmetric(vertical: 10),
                        itemCount: feedsList.length,
                        itemBuilder: (context, i) {
                          final data = feedsList[i];
                          return FeedCard(data: data);
                        },
                      ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class FiltersList extends StatelessWidget {
  const FiltersList({super.key});

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filterList = [
      {"label": "For You"},
      {"label": "Recent"},
      {"label": "My Request"},
      {"label": "Top Deals", "icon": Icons.star_border_purple500_outlined},
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: SizedBox(
        height: 38,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: List.generate(
            filterList.length,
            (i) => Padding(
              padding: const EdgeInsets.only(right: 10),
              child: InkWell(
                borderRadius: BorderRadius.circular(30),
                onTap: () {
                  Fluttertoast.showToast(
                    msg: "Filter not available",
                    backgroundColor: AppColors.primaryColor,
                  );
                },
                child: FilterCard(filterList: filterList, i: i),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class FilterCard extends StatelessWidget {
  const FilterCard({super.key, required this.filterList, required this.i});

  final List<Map<String, dynamic>> filterList;
  final int i;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsetsGeometry.symmetric(vertical: 8, horizontal: 12),
      // margin: EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
        color: i == 1 ? AppColors.primaryShadeColor : Colors.transparent,
        border: Border.all(
          color: i == 1 ? AppColors.primaryColor : Colors.grey.shade300,
        ),
        borderRadius: BorderRadius.circular(24),
      ),

      child: Row(
        children: [
          Visibility(
            visible: filterList[i]['icon'] != null,
            child: Row(
              children: [
                ShaderMask(
                  shaderCallback: (bounds) =>
                      AppColors.goldenGradient.createShader(bounds),
                  child: Icon(
                    filterList[i]['icon'] ??
                        Icons.star_border_purple500_outlined,
                    size: 16,
                    color: Colors.white,
                  ),
                ),
                SizedBox(width: 10),
              ],
            ),
          ),
          Text(filterList[i]['label']),
        ],
      ),
    );
  }
}

class FeedCard extends StatefulWidget {
  const FeedCard({super.key, required this.data});

  final MarketplaceRequest data;

  @override
  State<FeedCard> createState() => _FeedCardState();
}

class _FeedCardState extends State<FeedCard>
    with SingleTickerProviderStateMixin {
  bool isExpanded = false;

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

  bool checkLastFeed() {
    if (widget.data.userDetails.designation != null &&
        widget.data.userDetails.designation == "Test") {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => DetailsScreen(data: widget.data)),
        );
      },
      borderRadius: BorderRadius.circular(16),

      child: AnimatedSize(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,

        child: Ink(
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                height: isExpanded ? null : 300,
                padding: EdgeInsetsGeometry.symmetric(
                  vertical: 16,
                  horizontal: 12,
                ),
                margin: EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.borderColor),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: SingleChildScrollView(
                  physics: NeverScrollableScrollPhysics(), // disable scrolling
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //header
                      Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Image.network(
                              widget.data.userDetails.profileImage,
                              fit: BoxFit.cover,
                              height: 56,
                              width: 56,
                            ),
                          ),
                          SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.data.userDetails.name,
                                style: TextStyle(fontWeight: FontWeight.w600),
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
                                  Icon(
                                    CupertinoIcons.clock,
                                    size: 12,
                                    color: Colors.grey.shade400,
                                  ),
                                  Text(
                                    " ${Services().formatAgo(widget.data.createdAt)}",
                                    style: TextStyle(
                                      color: Colors.grey.shade400,
                                      fontSize: 10,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Spacer(),

                          Icon(
                            Icons.navigate_next,
                            size: 24,
                            color: AppColors.secondaryTextColor,
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          SvgPicture.asset(getRandomImage()),
                          SizedBox(width: 10),
                          Text(
                            "Looking for ${widget.data.serviceType}",
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

                      // body
                      Text(
                        "Budget: ₹${widget.data!.requestDetails == null ? 0 : widget.data!.requestDetails!.budget}",
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

                      //end line
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
                              SvgPicture.asset("assets/icons/distance.svg"),
                              SizedBox(width: 4),
                              Text(
                                "Bangalore, Tamilnadu, Kerala",
                                style: TextStyle(
                                  color: AppColors.secondaryTextColor,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
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
                                  SvgPicture.asset("assets/icons/i.svg"),
                                  SizedBox(width: 4),
                                  Text(
                                    "${widget.data.requestDetails?.followersRange?.igFollowersMax ?? 0} - ${widget.data.requestDetails?.followersRange?.igFollowersMin ?? 0}",
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
                                  SvgPicture.asset("assets/icons/category.svg"),
                                  SizedBox(width: 4),
                                  Text(
                                    (widget.data.requestDetails?.categories
                                            ?.join(', ')) ??
                                        'Book Authors, Working Professionals',
                                    style: TextStyle(
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
                    ],
                  ),
                ),
              ),

              Positioned(
                top: -10,
                right: 20,
                child: Visibility(
                  visible: widget.data.isHighValue || checkLastFeed(),
                  child: FittedBox(
                    child: Container(
                      padding: EdgeInsetsGeometry.symmetric(
                        vertical: 6,
                        horizontal: 10,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        gradient: checkLastFeed()
                            ? AppColors.primaryDarkGradient
                            : AppColors.goldenGradient2,
                      ),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            checkLastFeed()
                                ? "assets/icons/bell.svg"
                                : "assets/icons/flower.svg",
                          ),
                          SizedBox(width: 4),
                          Text(
                            checkLastFeed()
                                ? "Exploring soon".toUpperCase()
                                : "HIGH VALUE".toUpperCase(),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 20,
                right: 10,
                child: TextButton(
                  onPressed: () {
                    setState(() => isExpanded = !isExpanded);
                  },
                  child: Text(
                    isExpanded ? "Show Less" : "Show More",
                    style: TextStyle(color: AppColors.secondaryTextColor),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

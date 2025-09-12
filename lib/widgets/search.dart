import 'package:flutter/material.dart';

import '../constants/colors.dart';

class SearchContainer extends StatelessWidget {
  const SearchContainer({super.key});

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(30);

    return Padding(
      padding: EdgeInsetsGeometry.symmetric(vertical: 10),
      child: Container(
        height: 48,
        padding: EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          borderRadius: radius,
          border: Border.all(color: Colors.grey.shade400),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(200),
              child: Image.asset(
                "assets/profile.jpg",
                height: 32,
                width: 32,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: TextField(
                textInputAction: TextInputAction.search,
                decoration: InputDecoration(
                  hintText: "Type your requirement here . . .",
                  border: InputBorder.none,
                  isCollapsed: true,
                  hintStyle: TextStyle(
                    color: AppColors.secondaryTextColor,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

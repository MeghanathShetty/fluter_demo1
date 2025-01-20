import 'package:demo1/pages/dashboard2_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// Custom imports
import 'package:demo1/utils/my_widgets.dart';
import 'package:demo1/pages/dashboard_page.dart';

class CategoryPage extends StatelessWidget {
  const CategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Where is your favorite place to explore?",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            MyImageGrid(
              initialItems: [
                {'image': 'assets/images/Beach.png', 'isChecked': false},
                {'image': 'assets/images/Camping.png', 'isChecked': false},
                {'image': 'assets/images/Ocean.png', 'isChecked': false},
                {'image': 'assets/images/Fishing.png', 'isChecked': false},
                {'image': 'assets/images/Forest.png', 'isChecked': false},
                {'image': 'assets/images/Mountain.png', 'isChecked': false},
              ],
            ),
            SizedBox(height: 20),
            Align(
              alignment: Alignment.center,
              child: SizedBox(
                width: screenWidth>600? 400 : 300,
                child: MyElevatedBtn(
                    text: "Next", onPressed: () => Get.offAll(DashboardPage2(fromCategory: true,))),
              ),
            )
          ],
        ),
      ),
    );
  }
}

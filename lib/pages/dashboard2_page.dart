import 'package:demo1/utils/my_controllers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// custom imports
import 'package:demo1/utils/my_apis.dart';
import 'package:demo1/utils/my_widgets.dart';

class DashboardPage2 extends StatelessWidget {
  final bool fromCategory;
  DashboardPage2({super.key, this.fromCategory = false});
  final UserDioController userDioController = Get.put(UserDioController());
  final MyImageGridController myImageGridController = Get.put(MyImageGridController());

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> selectedItems = [];
    // print("fromCategory = $fromCategory");

    if (fromCategory && myImageGridController.items.isNotEmpty) {
      selectedItems = myImageGridController.items
          .where((item) => (item['isChecked']).value)
          .map((item) {
        item['isChecked'] = false.obs;
        return item;
      }).toList();
    }

    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      body: Padding(
        padding: EdgeInsets.all(30), // Padding around the content
        child: Obx(() {
          var userObj = userDioController.user;
          return Column(
            children: [
              userObj.isNotEmpty && userObj.containsKey('name') && userObj['name'].containsKey('first')
                  ? UserDP(
                image: userObj['picture']?['thumbnail'],
                name: '${userObj['name']['first']}',
              )
                  : SizedBox.shrink(),
              SizedBox(height: 25),
              Text(
                "Where do you want to explore today?",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 25),
              MySearchBar(),
              SizedBox(height: 25),
              Expanded(child:
              SingleChildScrollView(
                  child:
                  Column(
                    children: [
                      DashBoardChooseCategory(
                        initialItems: selectedItems
                      ),
                      SizedBox(height: 25),
                      FavoriteSection(),
                      SizedBox(height: 25),
                      PopularTourism()
                    ],
                  )
              ),),
            ],
          );
        }),
      ),
    );
  }
}

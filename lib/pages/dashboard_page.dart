// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// // custom imports
// import 'package:demo1/utils/my_apis.dart';
// import 'package:demo1/utils/my_widgets.dart';
//
// class DashboardPage extends StatelessWidget {
//   DashboardPage({super.key});
//
//   final UserDioController userDioController = Get.put(UserDioController());
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xFFFFFFFF),
//       body: SingleChildScrollView(  // Wrap the entire content with SingleChildScrollView
//         child: Container(
//           padding: EdgeInsets.all(30),
//           child: Column(
//             children: [
//               Obx(() {
//                 var userObj = userDioController.user;
//                 return Column(
//                   children: [
//                     UserDP(
//                       image: userObj['picture']?['thumbnail'],
//                       name: '${userObj['name']['first']}',
//                     ),
//                     SizedBox(height: 25),
//                     Text(
//                       "Where do you want to explore today?",
//                       style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//                     ),
//                     SizedBox(height: 25),
//                     MySearchBar(),
//                     SizedBox(height: 25),
//                     DashBoardChooseCategory(
//                       initialItems: [
//                         {'image': 'assets/images/Beach.png', 'isChecked': false},
//                         {'image': 'assets/images/Camping.png', 'isChecked': false},
//                         {'image': 'assets/images/Ocean.png', 'isChecked': false},
//                         {'image': 'assets/images/Fishing.png', 'isChecked': false},
//                         {'image': 'assets/images/Forest.png', 'isChecked': false},
//                         {'image': 'assets/images/Mountain.png', 'isChecked': false},
//                       ],
//                     ),
//                     SizedBox(height: 25),
//                     PopularTourism(),
//                   ],
//                 );
//               }),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

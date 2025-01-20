import 'package:demo1/pages/booking_page.dart';
import 'package:demo1/pages/category_page.dart';
import 'package:demo1/pages/dashboard_page.dart';
import 'package:demo1/pages/successful_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

//custom imports
import 'package:demo1/utils/my_controllers.dart';
import 'package:demo1/utils/my_functions.dart';
import 'package:demo1/utils/my_constants.dart';

import 'my_apis.dart';

class MyTextField extends StatelessWidget {
  final String label, hint;

  MyTextField({
    super.key,
    required this.label,
    required this.hint,
  });

  MyTextFieldController myTextFieldController = Get.put(MyTextFieldController());

  @override
  Widget build(BuildContext context) {
    return Container(
      child:
          Obx(()=>
        TextField(
          onChanged: (value){
            myTextFieldController.checkUsername(value);
          },
          decoration: InputDecoration(
            labelText: myTextFieldController.isUsernameValid.value? label : "Invalid Email",
            labelStyle: TextStyle(color: Colors.grey),
            floatingLabelStyle: TextStyle(color:
              myTextFieldController.isUsernameValid.value? Colors.yellow : Colors.red,
            ),
            hintText: hint,
            hintStyle: TextStyle(color: Colors.grey.shade400),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade300, width: 1.0),
              borderRadius: BorderRadius.circular(MyConstants.borderRad),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color:
                myTextFieldController.isUsernameValid.value? Colors.yellow : Colors.red,
                  width: 2.0),
              borderRadius: BorderRadius.circular(MyConstants.borderRad),
            ),
            contentPadding:
                EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
          ),
          style: TextStyle(fontSize: 16.0),
        ),
          )
    );
  }
}

class MyPassTextField extends StatelessWidget {
  final String label;
  final String hint;
  MyPassTextField({
    super.key,
    required this.label,
    required this.hint,
  });

  final MyPassFieldController controller = Get.put(MyPassFieldController());

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Obx(() => TextField(
            onChanged: (value){
              controller.checkPass(value);
            },
            obscureText: controller.isObscure.value,
            decoration: InputDecoration(
              suffixIcon: IconButton(
                icon: Icon(
                  controller.isObscure.value
                      ? Icons.visibility_off
                      : Icons.visibility,
                  color: Colors.grey,
                ),
                onPressed: controller.toggleObscureText,
              ),
              labelText: controller.isPassValid.value? label :"Invalid Password",
              labelStyle: TextStyle(color: Colors.grey),
              floatingLabelStyle: TextStyle(color:
              controller.isPassValid.value? Colors.yellow : Colors.red),
              hintText: hint,
              hintStyle: TextStyle(color: Colors.grey.shade400),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade300, width: 1.0),
                borderRadius: BorderRadius.circular(MyConstants.borderRad),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color:
                controller.isPassValid.value? Colors.yellow : Colors.red,
                    width: 2.0),
                borderRadius: BorderRadius.circular(MyConstants.borderRad),
              ),
              contentPadding:
                  EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
            ),
            style: TextStyle(fontSize: 16.0),
          )),
    );
  }
}

class MyElevatedBtn extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  double width, height;

  MyElevatedBtn(
      {super.key,
      required this.text,
      required this.onPressed,
      this.width = double.infinity,
      this.height = 50});

  MyTextFieldController nameController = Get.put(MyTextFieldController());
  MyPassFieldController passController = Get.put(MyPassFieldController());

  Widget build(BuildContext context) {
    return Obx(()=>ElevatedButton(
      onPressed: nameController.isUsernameValid.value && passController.isPassValid.value?
        onPressed : null,
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.black, // Button background color
        backgroundColor: Colors.yellow, // Text color
        minimumSize: Size(width, height),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(MyConstants.borderRad),
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 16.0,
        ),
      ),
    )
    );
  }
}

class MyImageGrid extends StatelessWidget {
  final RxList<Map<String, dynamic>> items;

  MyImageGrid({super.key, required List<Map<String, dynamic>> initialItems})
      : items = RxList(initialItems
            .map((item) => {
                  'image': item['image'],
                  'isChecked': RxBool(item['isChecked'] ?? false),
                })
            .toList());

  final MyImageGridController imgController = Get.put(MyImageGridController());
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    imgController.setItems(items);
    return Expanded(
      child: Obx(() => (GridView.count(
            crossAxisCount: screenWidth>600? 3 : 2,
            crossAxisSpacing: 30.0,
            mainAxisSpacing: 30.0,
            shrinkWrap: false, // Ensures it wraps content instead of expanding
            // physics: NeverScrollableScrollPhysics(),
            children: imgController.items.map((item) {
              return GestureDetector(
                onTap: () {
                  imgController
                      .toggleImageCheck(imgController.items.indexOf(item));
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(MyConstants.borderRad),
                    border: Border.all(
                      color: item['isChecked'].value
                          ? Colors.green
                          : Colors.grey.shade300,
                      width: item['isChecked'].value ? 2 : 1,
                    ),
                    color: Colors.white,
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            item['image'],
                            height: 60,
                            width: 60,
                          ),
                          SizedBox(height: 10),
                          Text(
                            getImageName(item['image']),
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                      if (item['isChecked'].value)
                        Positioned(
                          top: 5,
                          right: 5,
                          child: Icon(
                            Icons.check_circle,
                            color: Colors.green,
                            size: 24,
                          ),
                        )
                    ],
                  ),
                ),
              );
            }).toList(),
          ))),
    );
  }
}

class UserDP extends StatelessWidget {
  final String image, name;
  const UserDP({super.key, required this.image, required this.name});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          width: 50, // Set width for the circle
          height: 50, // Set height for the circle
          decoration: BoxDecoration(
            shape: BoxShape.circle, // Make the container circular
          ),
          child: ClipOval(
            child: Image.network(
              image ?? "dummy",
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(
          width: 20,
        ),
        Text('Hello, $name!')
      ],
    );
  }
}

class MySearchBar extends StatelessWidget {
  final MySearchController searchController = Get.put(MySearchController());
  late String str;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      width: double.maxFinite,
      padding: EdgeInsets.all(3),
      decoration: BoxDecoration(
        color: Colors.grey[100], // Background color
        borderRadius:
            BorderRadius.circular(MyConstants.borderRad), // Rounded corners
      ),
      child: Stack(
        children: [
          TextField(
            onChanged: (value) {
              // str = value;
              searchController.setSearch(value);
            },
            decoration: InputDecoration(
              hintText: "Search destination",
              hintStyle: TextStyle(color: Colors.grey[500]), // Hint text color
              border: InputBorder.none, // Removes the default outline
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            ),
          ),
          Positioned(
            right: 16,
            top: 9,
            child: GestureDetector(
              onTap: () {
                searchController.setSearch(str);
              },
              child: Icon(
                Icons.search,
                size: 24.0, // Icon size
                color: Colors.black, // Icon color
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DashBoardChooseCategory extends StatelessWidget {
  final RxList<Map<String, dynamic>> items;

  final MyImageGridController imgController = Get.put(MyImageGridController());

  DashBoardChooseCategory(
      {super.key, required List<Map<String, dynamic>> initialItems})
      : items = RxList(initialItems
            .map((item) => {
                  'image': item['image'],
                  'isChecked': (item['isChecked'] ?? false),
                })
            .toList());

  @override
  Widget build(BuildContext context) {
    // imgController.updateDashboardCategoryItems();
    imgController.setItems(items);

    if (imgController.items.isEmpty) return Container();

    return Align(
      alignment: Alignment.bottomLeft,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Choosen Category",
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Container(
              height: 50,
              child: Obx(() => SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: imgController.items.map((item) {
                        return GestureDetector(
                          onTap: () {
                            // print("dfhdjfhdjf");
                            imgController.toggleImageCheck(
                                imgController.items.indexOf(item));
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 5.0, horizontal: 10.0),
                            margin:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(MyConstants.borderRad),
                              border: Border.all(
                                color: item['isChecked'].value
                                    ? Colors.green
                                    : Colors.grey.shade300,
                                width: 1,
                              ),
                              color: Colors.white,
                            ),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(12.0),
                                      child: Image.asset(
                                        item['image'],
                                        height: 55,
                                        width: 30,
                                      ),
                                    ),
                                    const SizedBox(width: 5),
                                    Text(
                                      getImageName(item['image']),
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  )),
            )
          ]),
    );
  }
}

class PopularTourism extends StatelessWidget {
  PopularTourism({super.key});

  final TourismPopularDioController tourismDioController =
      Get.put(TourismPopularDioController());
  final MySearchController searchController = Get.put(MySearchController());

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          textAlign: TextAlign.left,
          "Popular Destinations",
          style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 20),
        Obx(() {
          var filteredTourism = tourismDioController.tourism.where((item) {
            return item['name']
                .toLowerCase()
                .contains(searchController.name.value.toLowerCase());
          }).toList();

          if (tourismDioController.tourism.isEmpty || filteredTourism.isEmpty) {
            return Center(child: Text("Nothing to display"));
          }
          return ListView.builder(
            shrinkWrap: true,
            physics: AlwaysScrollableScrollPhysics(),
            itemCount: searchController.name.value.isEmpty
                ? tourismDioController.tourism.length
                : filteredTourism.length,
            itemBuilder: (context, index) {
              var item = searchController.name.value.isEmpty
                  ? tourismDioController.tourism[index]
                  : filteredTourism[index];
              String price = '\$${generatePrice()}';
              return Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: GestureDetector(
                    onTap: () => Get.to(()=>BookingPage(
                      name: item['name'],
                      url: item['image'],
                      price: price,
                      desc: item['description'],
                    )),
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey.shade300, // Outline color
                          width: 1.0, // Outline width
                        ),
                        borderRadius: BorderRadius.circular(
                            MyConstants.borderRad), // Rounded corners
                        color: Colors.white, // Background color
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0), // Inner padding
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                item['image'], // URL to the image
                                width: 80, // You can adjust this size
                                height: 110,
                                fit: BoxFit
                                    .cover, // Ensure image scales properly
                              ),
                            ),
                            SizedBox(width: 15),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item['name'],
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(height: 2),
                                  Text(
                                    price,
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.red),
                                  ),
                                  SizedBox(height: 2),
                                  Text(
                                    item['description'],
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ));
            },
          );
        }),
      ],
    );
  }
}

class BookingPageDetails extends StatelessWidget {
  final String name, price, desc, url;

  BookingPageDetails(
      {super.key,
      required this.name,
      required this.url,
      required this.price,
      required this.desc});

  final MyCalendarController calendarController =
  Get.put(MyCalendarController());

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Go back btn
        Align(
            alignment: Alignment.topLeft,
            child: BackButton(
              onPressed: () => Get.back(),
              color: Colors.white,
            )),
        SizedBox(height: 250),
        Text(name,
            style: TextStyle(
              fontSize: 38,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            )),
        SizedBox(height: 20),
        Text(desc,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            )),
        SizedBox(height: 10,),
        Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    price,
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      child: Obx(() => Column(
                        children: [
                          calendarController.dateText.value == ""
                              ? SizedBox(height: 0)
                              : Text(calendarController.dateText.value,style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.white
                          )
                          ),
                          SizedBox(height: 5,),
                          MyElevatedBtn(
                            text: calendarController.dateText.value == ""
                                ? "Booking"
                                : "Confirm",
                            onPressed: () => calendarController.dateText.value == ""
                                ? calendarController.selectDateFromCalendar(context)
                                : Get.offAll(()=>SuccessfulPage(
                              name: name,
                              price: price,
                              date: calendarController.dateText.value,
                            )),
                            width: 170,
                          ),
                        ],
                      )),
                    )
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}

class FavoriteSection extends StatelessWidget {
  FavoriteSection({super.key});

  final TourismFavDioController tourismDioController =
      Get.put(TourismFavDioController());

  final MyFavoriteController favController = Get.put(MyFavoriteController());

  @override
  Widget build(BuildContext context) {
    if (tourismDioController.tourism.isEmpty) {
      return Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Favorite places",
            textAlign: TextAlign.start,
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: 15),
        CircularProgressIndicator()
      ]);
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Favorite places",
            textAlign: TextAlign.start,
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: 15),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal, // Enable horizontal scrolling
          child: Row(
            children: tourismDioController.tourism.map((item) {
              RxString itemId = item['id'].toString().obs;
              // print('Item id ${itemId.value}');
              String price = '\$${generatePrice()}';

              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10.0), // Add spacing
                child: GestureDetector(
                  onTap: () => Get.to(()=>BookingPage(
                    name: item['name'],
                    url: item['image'],
                    price: price,
                    desc: item['description'],
                  )),
                  child: Stack(
                    children: [
                      // Image container, occupying the full space in the stack
                      Container(
                        width: 120,
                        height: 160,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          image: DecorationImage(
                            image: NetworkImage(item['image']),
                            fit:
                                BoxFit.cover, // Image covers the full container
                          ),
                        ),
                      ),
                      // Semi-transparent overlay
                      Positioned.fill(
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.black.withOpacity(
                                  0.2) // Set opacity for the overlay
                              ),
                        ),
                      ),
                      // Name at Bottom-Left
                      Positioned(
                        bottom: 10,
                        left: 10,
                        child: Text(
                          item['name'],
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      // Heart for Favorite
                      Positioned(
                        top: 10,
                        right: 10,
                        child: Obx(() => Container(
                              child: GestureDetector(
                                onTap: () =>
                                    favController.toggleFav(itemId.value),
                                child: Icon(
                                  Icons.favorite,
                                  size: 18,
                                  color: favController.isFav(itemId.value)
                                      ? Colors.red
                                      : Colors.white,
                                ),
                              ),
                            )),
                      )
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}

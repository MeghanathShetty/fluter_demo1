import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../pages/category_page.dart';

class CheckLoginController extends GetxController{

  var checkLogin = false.obs;
  Future<void> checkLoginFun() async{
    final SharedPreferences prefs  = await SharedPreferences.getInstance();
    try{
      checkLogin.value = prefs.getBool("checkLogin") ?? false;
    }catch(e){
      print('Error retrieving check: $e');
    }
  }
}

class MyTextFieldController extends GetxController {
  var username = "".obs;
  var isUsernameValid = true.obs;

  void checkUsername(String name) {
    bool t = name.endsWith('.com');
    if(name == "") {
      isUsernameValid.value = true;
    } else if(t==false){
      isUsernameValid.value = false;
    } else {
      isUsernameValid.value = true;
    }
  }
}

class MyPassFieldController extends GetxController {
  var isObscure = true.obs;

  void toggleObscureText() {
    // print("Hello============================================");
    isObscure.value = !isObscure.value;
  }

  var pass = "".obs;
  var isPassValid = true.obs;

  void checkPass(String pass) {
    bool t = pass.length >= 8;
    if(pass == "") {
      isPassValid.value = true;
    } else if(t==false){
      isPassValid.value = false;
    } else {
      isPassValid.value = true;
    }
  }
}

class MyImageGridController extends GetxController {
  late RxList<Map<String, dynamic>> items;

  MyImageGridController();

  void setItems(RxList<Map<String, dynamic>> newItems) {
    items = newItems;
    // dashBoardCategoryItems = newItems;
  }

  void toggleImageCheck(int index) {
    items[index]['isChecked'].value = !(items[index]['isChecked'] as RxBool).value;
  }
}

class MyFavoriteController extends GetxController {
  var favorites = <String, RxBool>{}.obs;

  void toggleFav(String itemId) {
    if (!favorites.containsKey(itemId)) {
      favorites[itemId] = false.obs;
    }
    favorites[itemId]!.value = !favorites[itemId]!.value;
  }

  bool isFav(String itemId) {
    return favorites[itemId]?.value ?? false;
  }
}


class MySearchController extends GetxController{
  var name = "".obs;

  void setSearch(String str){
    name.value = str;
    // print("Here = == == = == = == = == == == = = == == =\n" + str);
  }
}

class MyCalendarController extends GetxController{
  var dateText = "".obs;
  @override
  // void onInit() {
  //   super.onInit();
  //   dateText.value = ""; // Reset the date whenever the controller is initialized
  //   print("Hello");
  // }

  Future<void> selectDateFromCalendar(BuildContext context) async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (selectedDate != null) {
      dateText.value = selectedDate.toString().substring(0, 10);
      // print("Selected date: $dateText");
    }
  }
}

// class MyLoginController extends GetxController{
//
// }
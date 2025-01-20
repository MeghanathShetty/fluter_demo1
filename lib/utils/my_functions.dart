import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';


//custom imports
import 'package:demo1/pages/category_page.dart';

void login() async {
  final SharedPreferences pref = await SharedPreferences.getInstance();

  await pref.setBool("checkLogin", true);
  Get.offAll(CategoryPage());
}

String getImageName(String path) {
  final String temp = path.split('/').last;
  // print("Helllo ==============================${temp}");
  final String name = temp.split('.').first;
  // print("HHHHHHHHHHHH ==============================${name}");
  return name;
}

int generatePrice() {
  final Random random = Random();
  return 500 + random.nextInt(501); // Generates a number between 500 and 1000
}
import 'package:demo1/pages/dashboard2_page.dart';
import 'package:demo1/pages/successful_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

//custom
import 'package:demo1/pages/dashboard_page.dart';
import 'package:demo1/pages/booking_page.dart';
import 'package:demo1/pages/login_page.dart';
import 'package:demo1/pages/category_page.dart';
import 'package:demo1/utils/my_controllers.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StarterPage extends StatelessWidget {
  const StarterPage({super.key});

  @override
  Widget build(BuildContext context) {

    final CheckLoginController cCtrl = Get.put(CheckLoginController());

    Future.delayed(Duration(seconds: 2), () async {

      // testing...........................
      // final SharedPreferences pref = await SharedPreferences.getInstance();
      // await pref.remove("checkLogin");
      // .......................................

      await cCtrl.checkLoginFun();
      cCtrl.checkLogin.value? Get.offAll(DashboardPage2()) : Get.offAll(LoginPage());

      // testing...........................
      // Get.offAll(CategoryPage());
      // ...........................................
    });

    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      body: Center( child:
          Image.asset('assets/images/logo1.png'),
        )
    );
  }
}


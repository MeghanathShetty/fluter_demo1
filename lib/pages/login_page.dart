import 'package:demo1/utils/my_controllers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

//custom
import 'package:demo1/utils/my_widgets.dart';
import 'package:demo1/pages/category_page.dart';
import 'package:demo1/utils/my_functions.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

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
          children: [
            Center(
                child: Padding(
                    padding: EdgeInsets.only(top: 100,bottom: 100),
                    child: Image.asset("assets/images/logo1.png"))
            ),
            SizedBox(
                width: screenWidth > 600 ? 400 : 300,
                // height: screenWidth > 600 ? 200 : 100,
              child: Column(
              children: [
                MyTextField( label: "Email", hint: "Enter your email",),
                SizedBox(height: 35,),
                MyPassTextField(label: "Password", hint: "Enter your password"),
                SizedBox(height: 50,),
                MyElevatedBtn(text: "Sign In", onPressed: login),
              ],
            )
            )
          ],
        ),
      ),
    );
  }
}

import 'package:demo1/pages/dashboard_page.dart';
import 'package:demo1/utils/my_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'dashboard2_page.dart';

class SuccessfulPage extends StatelessWidget {
  final String name, price, date;
  const SuccessfulPage({super.key, required this.name, required this.price, required this.date});

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
              SizedBox(height: 160),
              Image.asset("assets/images/SuccessImg.png"),
              SizedBox(height: 60),
                Text(
                  textAlign: TextAlign.left,
                  "Booking Successful",
                  style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
                ),
              SizedBox(height: 20),
              Text(
                textAlign: TextAlign.left,
                "$name is booked for $price on $date.\nGet everything ready"
                    " until its time to go an a trip.",
                style: TextStyle(fontSize: 15,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 40),
              Expanded(
                child: Align(alignment: Alignment.bottomCenter,child:
                SizedBox(
                    width: screenWidth>600? 400 : 300,
                    child: MyElevatedBtn(text: "Explore More", onPressed: ()=>Get.offAll(()=>DashboardPage2())))
                ),
              )
            ],
          ),
        ));
  }
}

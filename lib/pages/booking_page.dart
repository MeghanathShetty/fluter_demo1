import 'package:flutter/material.dart';
import '../utils/my_widgets.dart';

class BookingPage extends StatelessWidget {
  final String name, price, desc, url;
  const BookingPage({super.key, required this.name, required this.url,
    required this.price, required this.desc});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(url),
                fit: BoxFit.cover, // Covers the entire screen
              ),
            ),
          ),
          // Semi-transparent overlay
          Container(
            color: Colors.black.withOpacity(0.5),
          ),
          // Main Content
          Container(
            padding: EdgeInsets.all(30),
            height: double.maxFinite,
            width: double.maxFinite,
            child: BookingPageDetails(name: name, url: url, price: price, desc: desc),
          ),
        ],
      ),
    );
  }
}


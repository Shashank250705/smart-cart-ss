import 'package:flutter/material.dart';

//page 1
class Page1 extends StatelessWidget {
  const Page1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Image.asset(
            'asset/images/promotional_photo1.avif', // Replace with your promotional photo path
            width: double.infinity, // Adjust the width as needed
            height: 400, // Adjust the height as needed
            fit: BoxFit.fill, // Adjust the fit based on your design
          ),
        ),
      ),
    );
  }
}

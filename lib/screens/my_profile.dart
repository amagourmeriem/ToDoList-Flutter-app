import 'package:flutter/material.dart';

class MyProfilePage extends StatelessWidget {  // Make sure the class name matches here
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Profile"),
      ),
      body: Center(
        child: const Text("This is the profile page"),
      ),
    );
  }
}
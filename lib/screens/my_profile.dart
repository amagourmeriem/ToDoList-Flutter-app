import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class MyProfilePage extends StatelessWidget {
  Future<Map<String, String>> fetchProfile() async {
    final response = await http.get(Uri.parse('http://your-api-endpoint/profile'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return {
        'name': data['name'],
        'email': data['email'],
        'avatarUrl': data['avatarUrl'],
      };
    } else {
      throw Exception('Failed to load profile');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Profile'),
        backgroundColor: Color.fromARGB(255, 196, 152, 207),
      ),
      body: FutureBuilder<Map<String, String>>(
        future: fetchProfile(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Failed to load profile'));
          } else if (snapshot.hasData) {
            final profile = snapshot.data!;
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(profile['avatarUrl']!),
                    radius: 60,
                  ),
                  SizedBox(height: 10),
                  Text(
                    profile['name']!,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    profile['email']!,
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ],
              ),
            );
          } else {
            return Center(child: Text('No data available'));
          }
        },
      ),
    );
  }
}

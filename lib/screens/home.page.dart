import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 196, 152, 207),
          centerTitle: true,
          title: const Text(
            "Home page",
            style: TextStyle(fontSize: 30, color: Colors.white),
          )),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Column(
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage("images/avatar.png"),
                    radius: 30,
                  ),
                    Text("Meriem AMAGOUR",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      )),
                  Text("Mariemamagour@gmail.com",
                      style: TextStyle(color: Colors.white, fontSize: 20))
                ],
              ),
            ),
            ListTile(
                leading: const Icon(Icons.home),
                title: const Text('Covid Tracker'),
                onTap: () {
                  Navigator.pop(context);
                }),
            const Divider(
              color: Color.fromARGB(255, 196, 152, 207),
            ),
            ListTile(
                leading: const Icon(Icons.home),
                title: const Text('Emsi Chatbot'),
                onTap: () {
                  Navigator.pop(context);
                }),
            const Divider(
              color: Color.fromARGB(255, 196, 152, 207),
            ),
            ListTile(
                leading: const Icon(Icons.account_circle),
                title: const Text('Profil'),
                onTap: () {
                  Navigator.pop(context);
                }),
            const Divider(
              color: Color.fromARGB(255, 196, 152, 207),
            ),
            ListTile(
                leading: const Icon(Icons.settings),
                title: const Text('Settings'),
                onTap: () {
                  Navigator.pop(context);
                }),
            const Divider(
              color: Color.fromARGB(255, 196, 152, 207),
            ),
            ListTile(
                leading: const Icon(Icons.logout),
                title: const Text('Logout'),
                onTap: () {
                  Navigator.pop(context);
                }),
          ],
        ),
      ),
      body: const Center(
        child: Text("Welcome !!",
            style: TextStyle(fontSize: 40, color: Colors.blueGrey)),
      ),
    );
  }
}

import "package:flutter/material.dart";
import "package:flutter_application_1/screens/home.page.dart";
import "package:flutter_application_1/screens/login_screen.dart";
import "package:flutter_application_1/screens/register.page.dart";
import 'package:firebase_core/firebase_core.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyC1bwyGp4huLpYux7A3lekCFfoGjK3eOzs", // Replace with actual values
      appId: "1:867949138773:android:7fef4dcc5c498cc42615dc", // Replace with actual values
      messagingSenderId: "867949138773", // Replace with actual values
      projectId: "flutterapp-b3d9e", // Replace with actual values
    ),
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 196, 152, 207)),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      title: 'Meriem\'s App',
      //home: HomePage(),
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginPage(),
        '/home': (context) => HomePage(),
        '/register': (context) => RegisterPage(),
      },
    );
  }
}

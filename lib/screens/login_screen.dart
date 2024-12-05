import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formkey = GlobalKey<FormState>();

  final TextEditingController _mailcontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();

  bool _passVisible = false;

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    final emailPattern = r'^[^@]+@[^@]+\.[^@]+';
    final regex = RegExp(emailPattern);
    if (!regex.hasMatch(value)) {
      return 'Enter a valid email !';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    if (value.length < 6) {
      return 'Short Password. Enter a valid password!';
    }
    return null;
  }

  Future<void> signIn() async {
    try {
      // Attempt to sign in the user with Firebase Authentication
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
              email: _mailcontroller.text.trim(), // Trim any extra spaces
              password: _passwordcontroller.text.trim() // Trim any extra spaces
              );

      if (userCredential.user != null) {
        // If successful, navigate to the home screen
        Navigator.pushNamed(context, '/home');
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Welcome back!")));
      }
    } on FirebaseAuthException catch (e) {
      // Handle errors, such as wrong password, user not found, etc.
      print("FirebaseAuth error with code: ${e.code}");
      String errorMessage;
      switch (e.code) {
        case 'user-not-found':
          errorMessage = 'No user found for that email.';
          break;
        case 'wrong-password':
          errorMessage = 'Incorrect password provided.';
          break;
        case 'invalid-credential':
          errorMessage = 'votre email ou passord invalide';
          break;
        case 'user-disabled':
          errorMessage = 'This user has been disabled.';
          break;
        case 'too-many-requests':
          errorMessage = 'Too many requests. Try again later.';
          break;
        case 'operation-not-allowed':
          errorMessage = 'Signing in with email and password is not enabled.';
          break;
        default:
          errorMessage = 'An unexpected error occurred. Please try again.';
          break;
      }
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(errorMessage)));
    } on SocketException catch (e) {
      // Catch any other exceptions that might occur
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
              "Failed to login due to an unexpected error. Try again later.")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 196, 152, 207),
        title: Text(
          'Login Page',
          style: TextStyle(fontSize: 30, color: Colors.white),
        ),
      ),
      body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Form(
            key: _formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Image.asset(
                  "images/logo2.jpg",
                  width: 100,
                  height: 100,
                ),
                Text(
                  "Welcome Back !",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _mailcontroller,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)),
                    prefixIcon: Icon(Icons.email),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: _validateEmail,
                ),
                SizedBox(height: 30),
                TextFormField(
                  obscureText: !_passVisible,
                  controller: _passwordcontroller,
                  decoration: InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)),
                      prefixIcon: Icon(Icons.lock),
                      suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _passVisible = !_passVisible;
                            });
                          },
                          icon: Icon(_passVisible
                              ? Icons.visibility
                              : Icons.visibility_off))),
                  validator: _validatePassword,
                ),
                SizedBox(height: 30),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        backgroundColor:
                            const Color.fromARGB(255, 196, 152, 207)),
                    onPressed: () {
                      if (_formkey.currentState!.validate()) {
                        signIn(); // Call the signIn method if form is valid
                      }
                    },
                    child: Text(
                      'Login',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    )),
                TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/register');
                    },
                    child: const Text(
                      'Don\'t have an account yet? Register here',
                      style: TextStyle(color: Color.fromARGB(255, 95, 45, 64)),
                    )),
              ],
            ),
          )),
    );
  }
}

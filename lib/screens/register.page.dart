import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formkey = GlobalKey<FormState>();

  final TextEditingController _mailcontroller = TextEditingController();
  final TextEditingController _validatepasswordcontroller =
      TextEditingController();
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
      return 'Short Password .Enter a valid password !';
    }
    return null;
  }

  String? _validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    if (value != _passwordcontroller.text) {
      return 'Passwords do not match ';
    }
    return null;
  }

Future SignUp() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: _mailcontroller.text.trim(), // Get user email input
              password:
                  _passwordcontroller.text.trim() // Get user password input
              );
      if (userCredential.user != null) {
        // Navigate to the login page or home page after successful registration
        // Navigator.pushReplacementNamed(context, '/login');
        Navigator.pushNamed(context, '/login'); // Adjust as necessary
      }
    } on FirebaseAuthException catch (e) {
      // Handle errors, e.g., email already in use, weak password, etc.
      var errorMessage = "Failed to register. Check your information.";
      if (e.code == 'weak-password') {
        errorMessage = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        errorMessage = 'An account already exists for that email.';
      }
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(errorMessage)));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to register. Try again later.")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 196, 152, 207),
        title: Text(
          'Register Page',
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
                  "Welcome to Our Website !",
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
                      prefixIcon: Icon(Icons.password),
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
                TextFormField(
                  obscureText: !_passVisible,
                  controller: _validatepasswordcontroller,
                  decoration: InputDecoration(
                      labelText: 'Validate Password',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)),
                      prefixIcon: Icon(Icons.password),
                      suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _passVisible = !_passVisible;
                            });
                          },
                          icon: Icon(_passVisible
                              ? Icons.visibility
                              : Icons.visibility_off))),
                  validator: _validateConfirmPassword,
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
                        SignUp(); // Call the signup function directly
                      }
                    },
                    child: Text(
                      'Register',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    )),
                TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/login');
                    },
                    child: const Text(
                      'Already have an account ',
                      style: TextStyle(color: Color.fromARGB(255, 95, 45, 64)),
                    )),
              ],
            ),
          )),
    );
  }
}

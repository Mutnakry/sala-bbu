import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:sala_bu/app_url.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginGoogle(),
    );
  }
}

class LoginGoogle extends StatelessWidget {
  final _keyForm = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    // Get screen size
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double padding = screenWidth * 0.05; // 5% of screen width for padding

    return GestureDetector(
      onTap: () =>FocusScope.of(context).unfocus(),
    child: Scaffold(
    appBar: AppBar(
    title: const Text('Login User'),
    ),
      body: Form(
        key: _keyForm,
        child: ListView(
          children: <Widget>[
            SizedBox(height: screenHeight * 0.05), // 5% of screen height
            Center(
              child: CircleAvatar(
                radius: screenWidth * 0.2, // 20% of screen width
                backgroundColor: Colors.blueAccent, // Background image
                child: Image.network(
                  'https://cdn-icons-png.flaticon.com/512/2622/2622075.png', // Icon image
                  width: screenWidth * 0.3, // 6% of screen width
                  height: screenWidth * 0.3, // 6% of screen width
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.02), // 2% of screen height
            TextField(
              decoration: InputDecoration(
                hintText: 'Phone number, email or username',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                filled: true,
                fillColor: Colors.grey[200],
              ),
            ),
            SizedBox(height: screenHeight * 0.01), // 1% of screen height

            TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Required Username!';
                }
                return null;
              },
              decoration: InputDecoration(
                hintText: 'Password',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                filled: true,
                fillColor: Colors.grey[200],
              ),
              obscureText: true,
            ),
            SizedBox(height: screenHeight * 0.02), // 2% of screen height
            ElevatedButton(
              onPressed: () {
                // Add your create account logic here
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: screenHeight * 0.02), // 2% of screen height
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                backgroundColor: Colors.blue,
              ),
              child: Text('Login', style: TextStyle(fontSize: 16.0,color: Colors.white)),
            ),
            SizedBox(height: screenHeight * 0.01), // 1% of screen height

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  "Forgor your login detaiol ?",
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(width:1),
                TextButton(
                  onPressed: () {
                    //Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUpScreen()),);
                  },
                  child: const Text(
                    "Get help",
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              ],
            ),
            SizedBox(height: screenHeight * 0.02), // 2% of screen height
            Divider(),
            SizedBox(height: screenHeight * 0.02), // 2% of screen height

            Center(
              child: TextButton(
                onPressed: () {
                  // Add your "Already have account" logic here
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min, // To ensure button size wraps content
                  children: <Widget>[
                    Image.network(
                      'https://cdn4.iconfinder.com/data/icons/logos-brands-7/512/google_logo-google_icongoogle-512.png',
                      width: screenWidth * 0.09, // 10% of screen width
                      height: screenWidth * 0.09, // 10% of screen width
                    ),
                    Text(
                      'Connect with google',
                      style: TextStyle(color: Colors.blue, fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
            Center(
              child: TextButton(
                onPressed: () {
                  // Add your "Already have account" logic here
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min, // To ensure button size wraps content
                  children: <Widget>[
                    Image.network(
                      'https://1000logos.net/wp-content/uploads/2017/02/Facebook-Logosu.png',
                      width: screenWidth * 0.15, // 10% of screen width
                      height: screenWidth * 0.15, // 10% of screen width
                    ),
                    Text(
                      'Connect with google',
                      style: TextStyle(color: Colors.blue, fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  "Dons't have account ?",
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(width:1),
                TextButton(
                  onPressed: () {
                    //Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUpScreen()),);
                  },
                  child: const Text(
                    "Create new Account",
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
    );
  }
}

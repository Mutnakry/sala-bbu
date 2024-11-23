import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:sala_bu/app_url.dart';
import 'package:sala_bu/screen/login.dart';
import 'package:http/http.dart' as http;
import 'package:sala_bu/screen/userlogin.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SignUpScreen(),
    );
  }
}

class SignUpScreen extends StatelessWidget {
  final TextEditingController txtfullname = TextEditingController();
  final TextEditingController txtusername = TextEditingController();
  final TextEditingController txtuserpass = TextEditingController();
  final TextEditingController txtconformpass = TextEditingController();

  Future<void> registerUser(
      String fullname,
      String username,
      String userpass,
      BuildContext context
      ) async {
    var uri = Uri.parse("${AppUrl.url}register_user.php");
    EasyLoading.show(status: 'Loading...');
    try {
      final response = await http.post(
        uri,
        body: {
          'fullname': fullname,
          'userName': username,
          'userPass': userpass,
        },
      );

      print("Server response: ${response.body}");
      if (response.statusCode == 200) {
        EasyLoading.dismiss();
        final data = jsonDecode(response.body);
        if (data['success'] == 1) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(data['msg_success'])),
          );
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => LoginScreen()),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(data['msg_error'] ?? "Registration failed")),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error: ${response.statusCode} - ${response.reasonPhrase}")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: Unable to connect to server. $e")),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double padding = screenWidth * 0.05;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.all(padding),
        child: ListView(
          children: <Widget>[
            SizedBox(height: screenHeight * 0.05),
            Center(
              child: CircleAvatar(
                radius: screenWidth * 0.2,
                backgroundColor: Colors.blueAccent,
                child: Image.network(
                  'https://cdn-icons-png.flaticon.com/512/2622/2622075.png',
                  width: screenWidth * 0.3,
                  height: screenWidth * 0.3,
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.02),
            TextField(
              controller: txtfullname,
              decoration: InputDecoration(
                hintText: 'Full Name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                filled: true,
                fillColor: Colors.grey[200],
              ),
            ),
            SizedBox(height: screenHeight * 0.01),
            TextField(
              controller: txtusername,
              decoration: InputDecoration(
                hintText: 'User Names',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                filled: true,
                fillColor: Colors.grey[200],
              ),
            ),
            SizedBox(height: screenHeight * 0.01),
            TextField(
              controller: txtuserpass,
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
            SizedBox(height: screenHeight * 0.02),
            TextField(
              controller: txtconformpass,
              decoration: InputDecoration(
                hintText: 'Form Password',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                filled: true,
                fillColor: Colors.grey[200],
              ),
              obscureText: true,
            ),

            SizedBox(height: screenHeight * 0.02),
            ElevatedButton(
              onPressed: () {
                // Check if the password and confirm password fields match
                if (txtuserpass.text == txtconformpass.text) {
                  registerUser(
                      txtfullname.text,
                      txtusername.text,
                      txtuserpass.text,
                      context // context needs to be passed as the last parameter
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Passwords do not match.")),
                  );
                }
              },


              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                backgroundColor: Colors.blue,
              ),
              child: Text('CREATE ACCOUNT', style: TextStyle(fontSize: 16.0, color: Colors.white)),
            ),
            SizedBox(height: screenHeight * 0.01),
            Center(
              child: TextButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                },
                child: Text('Already have account?', style: TextStyle(color: Colors.blue, fontSize: 16)),
              ),
            ),
            SizedBox(height: screenHeight * 0.02),
            Divider(),
            SizedBox(height: screenHeight * 0.02),
            Center(
              child: TextButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => LoginGoogle()));
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Image.network(
                      'https://cdn4.iconfinder.com/data/icons/logos-brands-7/512/google_logo-google_icongoogle-512.png',
                      width: screenWidth * 0.09,
                      height: screenWidth * 0.09,
                    ),
                    Text(
                      'Connect with Google',
                      style: TextStyle(color: Colors.blue, fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
            Center(
              child: TextButton(
                onPressed: () {
                  // Add your Facebook login logic here
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Image.network(
                      'https://1000logos.net/wp-content/uploads/2017/02/Facebook-Logosu.png',
                      width: screenWidth * 0.09,
                      height: screenWidth * 0.09,
                    ),
                    Text(
                      'Connect with Facebook',
                      style: TextStyle(color: Colors.blue, fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

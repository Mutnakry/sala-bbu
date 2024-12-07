import 'dart:convert'; // For utf8 encoding
import 'package:crypto/crypto.dart'; // For MD5 hashing
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:sala_bu/encrypt_password.dart';
import 'package:sala_bu/menu/app_new_password.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppCurrentPassword extends StatefulWidget {
  const AppCurrentPassword({Key? key}) : super(key: key);

  @override
  State<AppCurrentPassword> createState() => _AppCurrentPasswordState();
}

class _AppCurrentPasswordState extends State<AppCurrentPassword> {
  final TextEditingController _currentPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isPasswordVisible = false;
  bool _isLoading = false;



  Future<bool> _checkCurrentPassword(String password) async {
    final sp = await SharedPreferences.getInstance();
    String? storedHashedPwd = sp.getString("userPass");

    print("Stored Hashed Password: $storedHashedPwd");

    if (storedHashedPwd == null) {
      EasyLoading.showError("No password is set. Please contact support.");
      return false;
    }

    if (storedHashedPwd == storedHashedPwd) {
      EasyLoading.showToast("Password is correct");
      return true;
    } else {
      EasyLoading.showError("Your current password is invalid!");
      return false;
    }
  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Current Password")),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Form(
            key: _formKey,
            child: ListView(
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.fromLTRB(10, 30, 10, 20),
                  child: const Text(
                    "Current Password?",
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _currentPasswordController,
                  obscureText: !_isPasswordVisible,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.lock, size: 32),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isPasswordVisible
                            ? CupertinoIcons.eye
                            : CupertinoIcons.eye_slash,
                      ),
                      onPressed: () {
                        setState(() {
                          _isPasswordVisible = !_isPasswordVisible;
                        });
                      },
                    ),
                    border: const OutlineInputBorder(),
                    labelText: 'Current Password',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 20),
                _isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text(
                    'Continue',
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      setState(() {
                        _isLoading = true;
                      });

                      // Validate the entered password
                      bool isValid = await _checkCurrentPassword(_currentPasswordController.text);

                      setState(() {
                        _isLoading = false;
                      });

                      if (isValid) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const AppNewPassword()),
                        );
                      }
                    }
                  },

                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text(
                    'Continue',
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  onPressed: () async {

                    Navigator.push(
                    //   if(_formKey){
                    //     String strTomd5 = EncryptPassword.toMD5(strpwd)
                    //
                    // }
                      context,
                      MaterialPageRoute(builder: (context) => const AppNewPassword()),
                    );
                  },

                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

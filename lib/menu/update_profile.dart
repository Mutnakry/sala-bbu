import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:sala_bu/app_url.dart';
import 'package:shared_preferences/shared_preferences.dart';


class UpdateProfileScreen extends StatefulWidget {
  final String? username;
  final String? fullname;
  final String? phonebumber;
  final String? email;
  final String? userId; // Add userId field

  UpdateProfileScreen({
    required this.username,
    required this.fullname,
    required this.phonebumber,
    required this.email,
    required this.userId, // Initialize userId
  });

  @override
  _UpdateProfileScreenState createState() => _UpdateProfileScreenState();
}


class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _username;
  String? _fullname;
  String? _phonebumber;
  String? _email;

  @override
  void initState() {
    super.initState();
    // Initialize form fields with data passed from previous screen
    _username = widget.username;
    _fullname = widget.fullname;
    _phonebumber = widget.phonebumber;
    _email = widget.email;
  }


  Future<void> _updateProfile() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save(); // Save form data

      try {
        var url = Uri.parse("${AppUrl.url}update_date_user.php"); // Your PHP endpoint
        var response = await http.post(url, body: {
          'userID': widget.userId,
          'username': _username!,
          'userEmail': _email!,
          'fullname': _fullname!,
          'phone': _phonebumber!,
        });

        print("Response Status Code: ${response.statusCode}");
        print("Response Body: ${response.body}");



        // Parse the response from the PHP script
        var result = json.decode(response.body);

        if (result['success'] == 1) {
          EasyLoading.showSuccess(result['message']);
          Navigator.pop(context); // Go back after success
        } else {
          EasyLoading.showError(result['message']);
        }
      } catch (e) {
        EasyLoading.showError('Error: $e');
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Profile'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(height: 20),
              TextFormField(
                initialValue: _username,
                decoration: const InputDecoration(labelText: 'Username'),
                onSaved: (value) => _username = value,
                validator: (value) => value!.isEmpty ? 'Username is required' : null,
              ),
              TextFormField(
                initialValue: _fullname,
                decoration: const InputDecoration(labelText: 'Full name'),
                onSaved: (value) => _fullname = value,
                validator: (value) => value!.isEmpty ? 'Full name is required' : null,
              ),
              TextFormField(
                initialValue: _phonebumber,
                decoration: const InputDecoration(labelText: 'Phone number'),
                onSaved: (value) => _phonebumber = value,
              ),
              TextFormField(
                initialValue: _email,
                decoration: const InputDecoration(labelText: 'Email'),
                onSaved: (value) => _email = value,
                validator: (value) =>
                value!.isEmpty || !value.contains('@') ? 'Enter a valid email' : null,
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: _updateProfile,
                child: const Text('Update Profile'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

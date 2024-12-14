import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:sala_bu/app_url.dart';
import 'package:sala_bu/menu/update_profile.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class AppMyProfile extends StatefulWidget {
  const AppMyProfile({super.key});

  @override
  State<AppMyProfile> createState() => _AppMyProfile();
}

class _AppMyProfile extends State<AppMyProfile> {
  final _keyForm = GlobalKey<FormState>();
  String? _username;
  String? _fullname;
  String? _phone;
  String? _email;
  String? _image = "default.png";
  File? _newImage;
  String? userId;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _pickImage() async {
    final file = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (file != null) {
      setState(() {
        _newImage = File(file.path);
      });

      try {
        var url = Uri.parse("${AppUrl.url}update_date_user.php");
        final request = http.MultipartRequest("POST", url);
        request.files.add(await http.MultipartFile.fromPath('image', _newImage!.path));

        final res = await request.send();
        if (res.statusCode == 200) {
          final data = await res.stream.bytesToString();
          final msg = json.decode(data);

          if (msg['success'] == 1) {
            // Update the image in shared preferences
            final sp = await SharedPreferences.getInstance();
            sp.setString("userImage", msg['image'] ?? 'default.png');

            EasyLoading.showSuccess(msg['message']);
            _loadUserData(); // Refresh user data to reflect new image
          } else {
            EasyLoading.showError(msg['message']);
          }
        } else {
          EasyLoading.showError('Failed to send data.');
        }
      } catch (e) {
        EasyLoading.showError('Error: $e');
      }
    }
  }

  Future<void> _loadUserData() async {
    final sp = await SharedPreferences.getInstance();
    setState(() {
      _username = sp.getString("userName");
      _fullname = sp.getString("fullname") ?? 'N/A';
      _phone = sp.getString("phone") ?? 'N/A';
      _email = sp.getString("userEmail") ?? 'N/A';
      _image = sp.getString("userImage") ?? 'default.png';
      userId = sp.getString("userID");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
      ),
      body: Form(
        key: _keyForm,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.grey, width: 2.0),
                    ),
                    child: CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.grey.shade300,
                      child: ClipOval(
                        child: _newImage != null
                            ? Image.file(
                          _newImage!,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                        )
                            : Image.network(
                          '${AppUrl.url}images/$_image',
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(
                              Icons.person,
                              size: 40,
                              color: Colors.white,
                            );
                          },
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Center(
                              child: CircularProgressIndicator(
                                value: loadingProgress.expectedTotalBytes != null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                    (loadingProgress.expectedTotalBytes ?? 1)
                                    : null,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: InkWell(
                      onTap: _pickImage, // Updated method name
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.blueAccent,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                        padding: const EdgeInsets.all(6),
                        child: const Icon(
                          Icons.camera_alt,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              Text(
                "$_fullname",
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'ACCOUNT DETAIL',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UpdateProfileScreen(
                            username: _username,
                            fullname: _fullname,
                            phonebumber: _phone,
                            email: _email,
                            userId: userId, // Pass the userId here
                          ),
                        ),
                      );

                    },
                    child: const Text(
                      'EDIT',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                  ),

                ],
              ),

              buildInfoRow('Username:', _username),
              buildInfoRow('Full Name:', _fullname),
              buildInfoRow('Phone Number:', _phone),
              buildInfoRow('Email:', _email),


            ],
          ),
        ),
      ),
    );
  }

  Widget buildInfoRow(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Text(value ?? 'N/A', style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:sala_bu/app_url.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sala_bu/encrypt_password.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppNewPassword extends StatefulWidget {
  const AppNewPassword({Key? key}) : super(key: key);

  @override
  State<AppNewPassword> createState() => _AppNewPasswordState();
}

class _AppNewPasswordState extends State<AppNewPassword> {
  final TextEditingController _confirmpasswordController = TextEditingController();
  final TextEditingController _newpasswordController = TextEditingController();
  final TextEditingController _currentPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool _isNewPasswordVisible = false;
  bool _isConfirnPasswordVisible = false;
  bool _isCurrentPasswordVisible = false;
  bool _isLoading = false;



  Future<void> _saveNewPassword() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    EasyLoading.show(status: 'Updating password...');

    try {
      final prefs = await SharedPreferences.getInstance();
      final userId = prefs.getString('USER_ID');
      final storedPassword = prefs.getString('userPass');

      if (userId == null || storedPassword == null) {
        EasyLoading.showError("Unable to retrieve user data.");
        return;
      }

      // Validate current password
      if (EncryptPassword.toMD5(_currentPasswordController.text.trim()) != storedPassword) {
        EasyLoading.showError("Current password is incorrect.");
        return;
      }

      // Validate new password
      final newPassword = _newpasswordController.text.trim();
      if (EncryptPassword.toMD5(newPassword) == storedPassword) {
        EasyLoading.showInfo("New password cannot be the same as the old password.");
        return;
      }

      final url = Uri.parse("${AppUrl.url}change_password.php");
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'userID': userId,
          'userPassword': newPassword, // Send plaintext password
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['success'] == 1) {
          EasyLoading.showSuccess("Password updated successfully.");
          prefs.setString('userPass', EncryptPassword.toMD5(newPassword));
          Navigator.pop(context);
        } else {
          EasyLoading.showError(data['msg'] ?? "Failed to update password.");
        }
      } else {
        EasyLoading.showError("Error: ${response.statusCode}");
      }
    } catch (e) {
      EasyLoading.showError("An error occurred: $e");
    } finally {
      EasyLoading.dismiss();
      setState(() {
        _isLoading = false;
      });
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("New Password")),
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
                    "New Password?",
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                  ),
                ),
                // Current Password Field
                _buildPasswordField(
                  controller: _currentPasswordController,
                  label: 'Current Password',
                  isVisible: _isCurrentPasswordVisible,
                  onToggleVisibility: () {
                    setState(() {
                      _isCurrentPasswordVisible = !_isCurrentPasswordVisible;
                    });
                  },
                ),
                const SizedBox(height: 16),
                // New Password Field
                _buildPasswordField(
                  controller: _newpasswordController,
                  label: 'New Password',
                  isVisible: _isNewPasswordVisible,
                  onToggleVisibility: () {
                    setState(() {
                      _isNewPasswordVisible = !_isNewPasswordVisible;
                    });
                  },
                ),
                const SizedBox(height: 16),
                // Confirm Password Field
                _buildPasswordField(
                  controller: _confirmpasswordController,
                  label: 'Confirm Password',
                  isVisible: _isConfirnPasswordVisible,
                  onToggleVisibility: () {
                    setState(() {
                      _isConfirnPasswordVisible = !_isConfirnPasswordVisible;
                    });
                  },
                  validator: (value) {
                    if (value != _newpasswordController.text.trim()) {
                      return 'Passwords do not match.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                // Save Button
                _isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text(
                    'Save',
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  onPressed: _saveNewPassword,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPasswordField({
    required TextEditingController controller,
    required String label,
    required bool isVisible,
    required VoidCallback onToggleVisibility,
    FormFieldValidator<String>? validator,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: !isVisible,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.lock, size: 32),
        suffixIcon: IconButton(
          icon: Icon(
            isVisible ? CupertinoIcons.eye : CupertinoIcons.eye_slash,
          ),
          onPressed: onToggleVisibility,
        ),
        border: const OutlineInputBorder(),
        labelText: label,
      ),
      validator: validator ??
              (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter $label';
            }
            return null;
          },
    );
  }
}

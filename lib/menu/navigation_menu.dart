import 'package:flutter/material.dart';
import 'package:sala_bu/app_url.dart';
import 'package:sala_bu/menu/app_current_password.dart';
import 'package:sala_bu/menu/app_my_profile.dart';
import 'package:sala_bu/screen/userlogin.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart'; // for Navigator

class NavigationMenu extends StatefulWidget {
  const NavigationMenu({Key? key}) : super(key: key);

  @override
  _NavigationMenuState createState() => _NavigationMenuState();
}

class _NavigationMenuState extends State<NavigationMenu> {
  String? _fullname;
  String? _email;
  String? _image = "default.png";

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  // Load user data from SharedPreferences
  Future<void> _loadUserData() async {
    final sp = await SharedPreferences.getInstance();

    setState(() {
      _fullname = sp.getString("userName");
      _email = sp.getString("userEmail");
      _image = sp.getString("userImage") ?? "default.png";  // fallback to default if null
    });
  }

  Future<void> _logoutUser(BuildContext context) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear(); // Clear all saved preferences
    prefs.setBool('IS_LOGGEDIN', false); // Explicitly set logged-in status to false

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
          (route) => false, // Remove all previous routes
    );
  }


  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(_fullname ?? 'Guest'),
            accountEmail: Text(_email ?? 'Not Available'),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Image.network(
                  '${AppUrl.url}images/$_image',
                  fit: BoxFit.cover,
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
            decoration: BoxDecoration(color: Colors.blueAccent),
          ),
          ListTile(
            leading: Icon(Icons.account_circle),
            title: Text("About us"),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.phone_in_talk),
            title: Text("Contact us"),
            onTap: () {},
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.discount),
            title: Text("Promotions"),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.question_mark),
            title: Text("FAQs"),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.message),
            title: Text("Feedback"),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.playlist_add),
            title: Text("Terms of Use"),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.person_off),
            title: Text("My profile"),
            onTap: () {
              Navigator.push(context,MaterialPageRoute(builder: (context)=> const AppMyProfile() ),);
            },
          ),
          ListTile(
            leading: Icon(Icons.password),
            title: Text("Change Password"),
            onTap: () {
              Navigator.push(context,MaterialPageRoute(builder: (context)=> const AppCurrentPassword() ),);
              // Navigator.push(context,MaterialPageRoute(builder: (context)=> const ChangePasswordScreen() ),);
            },
          ),
          ListTile(
            leading: Icon(Icons.logout_rounded),
            title: Text("Logout"),
            onTap: () {
              // Implement logout logic
              _logoutUser(context);
            },
          ),
        ],
      ),
    );
  }
}

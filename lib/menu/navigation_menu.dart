import 'package:flutter/material.dart';
class NavigationMenu extends StatelessWidget {
  const NavigationMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
              accountName: const Text("Nakry"),
              accountEmail: const Text("Nakry@gmail.com"),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(child:
              Image.network(
                'https://cdn.pixabay.com/photo/2020/07/01/12/58/icon-5359553_640.png'
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
            title: Text("Contect us"),
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
            title: Text("TErms of Use"),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.person_off),
            title: Text("My profile"),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.password),
            title: Text("chang Password"),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.logout_rounded),
            title: Text("Logout"),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

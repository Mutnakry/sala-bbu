// import 'package:flutter/material.dart';
// import 'package:sala_bu/app_image.dart';
// import 'package:sala_bu/app_url.dart';
// import 'package:sala_bu/menu/navigation_menu.dart';
// import 'package:sala_bu/screen/favorite_items.dart';
// import 'package:sala_bu/screen/group_screen.dart';
// import 'package:sala_bu/screen/new-order.dart';
// import 'package:sala_bu/screen/populor_items.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
//
//
// class AppDashboard extends StatefulWidget {
//   const AppDashboard({Key? key}) : super(key: key);
//
//   @override
//   State<AppDashboard> createState() => _AppDashboardState();
// }
//
// class _AppDashboardState extends State<AppDashboard> {
//   String? _fullname = 'Guest';
//   String? _image='default.png';
//
//   @override
//   void initState(){
//     super.initState();
//     _loadUserInfo();  /// call the menhod
//   }
//
//   Future<void> _loadUserInfo() async {
//     final sp = await SharedPreferences.getInstance();
//
//     setState(() {
//       _fullname = sp.getString("User_fullName") ?? 'Guest';
//       _image = sp.getString("User_Image") ?? "default.png";
//     });
//   }
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('BBU Store'),
//         backgroundColor: Colors.blue, // Set the AppBar color to blue
//         actions: [PopupMenuButton<int>(
//             itemBuilder: (context)=>[
//               const PopupMenuItem(
//                 value: 1,
//                   child: ListTile(
//                       leading: Icon(Icons.mail),
//                       title: Text("New Order"),
//                 ),
//               ),
//               const PopupMenuItem(
//                 value: 2,
//                 child: ListTile(
//                   leading: Icon(Icons.message),
//                   title: Text("Popular"),
//                 ),
//               ),
//               const PopupMenuItem(
//                 value: 3,
//                 child: ListTile(
//                   leading: Icon(Icons.favorite),
//                   title: Text("Favorite"),
//                 ),
//               ),
//               const PopupMenuItem(
//                 value: 4,
//                 child: ListTile(
//                   leading: Icon(Icons.group),
//                   title: Text("Group"),
//                 ),
//               ),
//             ],
//           onSelected: (value){
//             switch(value){
//               case 1:
//                 // go to order screen
//               Navigator.push(context,
//                   MaterialPageRoute(builder: (context)=> const NewOrder()));
//                 break;
//               case 2:
//                 Navigator.push(context,
//                     MaterialPageRoute(builder: (context)=> const PopulorItems()));
//               // go to message screen
//                 break;
//               case 3:
//                 Navigator.push(context,
//                     MaterialPageRoute(builder: (context)=> const FavoriteItems()));
//               // go to favorite screen
//                 break;
//               case 4:
//                 Navigator.push(context,
//                     MaterialPageRoute(builder: (context)=> const GroupScreen()));
//                 // go to froup
//                 break;
//             }
//           },
//          ),
//         ],
//       ),
//       drawer: const NavigationMenu(),
//       body: Container(
//         color:const Color(0xe4e4e4e4),
//         child: Stack(
//           children: <Widget>[
//             Container(
//               height: 80,
//               // color: Colors.blue, // Removed this line to avoid conflict with BoxDecoration
//               decoration: BoxDecoration(
//                 color: Colors.blue, // Set the background color of the container
//                 borderRadius: BorderRadius.only(
//                   bottomLeft: Radius.circular(20),
//                   bottomRight: Radius.circular(20),
//                 ),
//               ),
//             ),
//             ///// contect
//             ListView(
//               children:<Widget> [
//                 Container(
//                   height: 160,
//                   margin: const EdgeInsets.fromLTRB(10, 0, 10, 5),
//                   child:Card(
//                       child: Stack(
//                         children:<Widget> [
//                           Container(
//                           margin: EdgeInsets.all(10.0),
//                           child: Text(
//                             'Good Acternoon',
//                             style: TextStyle(
//                                 color: Colors.blue,
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ),
//                           Container(
//                             margin: EdgeInsets.fromLTRB(10, 35, 10, 10),
//                             child: Text(
//                               '$_fullname',
//                               style: TextStyle(
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.blue,fontSize: 24,
//                               ),
//                             ),
//                           ),
//                           Positioned(
//                             left: 10,
//                             bottom: 10,
//                             child: Row(
//                               children: <Widget>[
//                                 ElevatedButton(
//                                   style: ElevatedButton.styleFrom(
//                                     backgroundColor: Colors.blue,
//                                  shape:const RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.all(
//                                   Radius.circular(5.0)
//                                   ), // Set the button background color
//                                   ),
//                                   ),
//                                   onPressed: () {},
//                                   child: Text(
//                                     'My Order',
//                                     style: TextStyle(
//                                       fontSize: 16,
//                                       color: Colors.white, // Set the text color if needed
//                                     ),
//                                   ),
//                                 ),
//                                 const SizedBox(width: 10,),
//                                 OutlinedButton(
//                                   style: OutlinedButton.styleFrom(
//                                     shape:const RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.all(
//                                           Radius.circular(5.0)
//                                       ), // Set the button background color
//                                     ),
//                                   ),
//                                   onPressed: () {},
//                                   child: Text(
//                                     'My Order',
//                                     style: TextStyle(
//                                       fontSize: 16,
//                                       color: Colors.blueAccent, // Set the text color if needed
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           Positioned(
//                             top: 10,
//                               right: 10,
//                               bottom: 10,
//                               child: CircleAvatar(
//                                 radius: 40,
//                                 child: Padding(
//                                   padding: EdgeInsets.all(3.0),
//                                   child: ClipOval(
//                                     child: Image.network(
//
//                                       '${AppUrl.url}images/$_image' ?? '${AppUrl.url}images/default.png',
//                                       fit: BoxFit.cover,
//                                     ),
//                                     // onBackgroundImageError: (_, __) => const AssetImage('assets/images/default.png'),
//                                   ),
//                                 ),
//                               ),
//                           ),
//                           Positioned(
//                             top: 10,
//                             right: 10,
//                             bottom: 10,
//                             child: CircleAvatar(
//                               radius: 40,
//                               backgroundColor: Colors.grey[200],
//                               backgroundImage: _image != null && _image!.isNotEmpty
//                                   ? NetworkImage('${AppUrl.url}$_image')
//                                   : AssetImage('assets/images/default.png') as ImageProvider,
//                               onBackgroundImageError: (_, __) {
//                                 // Fallback to a default image if there's an error
//                               },
//                             ),
//                           ),
//
//                         ],
//                       ),
//                     ),
//                   ),
//                 GridView.count(crossAxisCount:2,
//                 shrinkWrap: true,
//                   physics:const NeverScrollableScrollPhysics(),
//                   children:<Widget> [
//                     //// cart 1  ///
//                     Container(
//                       margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
//                       child:Card(
//                         child: InkWell(
//                           onTap: (){
//                             Navigator.push(context, MaterialPageRoute(builder: (context)=>NewOrder()));
//                           },
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             mainAxisSize: MainAxisSize.min,
//                             children: [
//                               Icon(Icons.message, size: 100, color: Colors.teal),
//                               SizedBox(height: 10.0),
//                               Text('Contacts', style: TextStyle(fontSize: 16.0)),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                     //// cart 2  ///
//                     Container(
//                       margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
//                       child:Card(
//                         child: InkWell(
//                           onTap: (){
//                             Navigator.push(context, MaterialPageRoute(builder: (context)=>FavoriteItems()));
//                           },
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             mainAxisSize: MainAxisSize.min,
//                             children: [
//                               Icon(Icons.favorite, size: 100, color: Colors.teal),
//                               SizedBox(height: 10.0),
//                               Text('Contacts', style: TextStyle(fontSize: 16.0)),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//
//                     //// cart 3  ///
//                     Container(
//                       margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
//                       child:Card(
//                         child: InkWell(
//                           onTap: (){
//                             Navigator.push(context, MaterialPageRoute(builder: (context)=>NewOrder()));
//                           },
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             mainAxisSize: MainAxisSize.min,
//                             children: [
//                               Icon(Icons.shopping_cart, size: 100, color: Colors.teal),
//                               SizedBox(height: 10.0),
//                               Text('Contacts', style: TextStyle(fontSize: 16.0)),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                     //// cart 4 ///
//                     Container(
//                       margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
//                       child:const Card(
//                         child: Center(
//
//                           child: Column(
//                             mainAxisSize: MainAxisSize.min,
//                             children: [
//                               Icon(Icons.card_travel_rounded, size: 100, color: Colors.teal),
//                               SizedBox(height: 10.0),
//                               Text('Contacts', style: TextStyle(fontSize: 16.0)),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                     //// cart 5  ///
//                     Container(
//                       margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
//                       child:const Card(
//                         child: Center(
//                           child: Column(
//                             mainAxisSize: MainAxisSize.min,
//                             children: [
//                               Icon(Icons.question_mark, size: 100, color: Colors.teal),
//                               SizedBox(height: 10.0),
//                               Text('Contacts', style: TextStyle(fontSize: 16.0)),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                     //// cart 6 ///
//                     Container(
//                       margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
//                       child:const Card(
//                         child: Center(
//                           child: Column(
//                             mainAxisSize: MainAxisSize.min,
//                             children: [
//                               Icon(Icons.settings, size: 100, color: Colors.teal),
//                               SizedBox(height: 10.0),
//                               Text('Contacts', style: TextStyle(fontSize: 16.0)),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sala_bu/app_url.dart';
import 'package:sala_bu/menu/navigation_menu.dart';
import 'package:sala_bu/screen/favorite_items.dart';
import 'package:sala_bu/screen/group_screen.dart';
import 'package:sala_bu/screen/new-order.dart';
import 'package:sala_bu/screen/populor_items.dart';

class AppDashboard extends StatefulWidget {
  const AppDashboard({Key? key}) : super(key: key);

  @override
  State<AppDashboard> createState() => _AppDashboardState();
}

class _AppDashboardState extends State<AppDashboard> {
  String? _fullname = 'Guest';
  String? _image = 'default.png';

  @override
  void initState() {
    super.initState();
    _loadUserInfo();
  }

  Future<void> _loadUserInfo() async {
    final sp = await SharedPreferences.getInstance();
    setState(() {
      _fullname = sp.getString("userName") ?? 'Guest';
      _image = sp.getString("userImage") ?? "default.png";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BBU Store'),
        backgroundColor: Colors.blue,
        actions: [
          PopupMenuButton<int>(
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 1,
                child: ListTile(
                  leading: Icon(Icons.mail),
                  title: Text("New Order"),
                ),
              ),
              const PopupMenuItem(
                value: 2,
                child: ListTile(
                  leading: Icon(Icons.message),
                  title: Text("Popular"),
                ),
              ),
              const PopupMenuItem(
                value: 3,
                child: ListTile(
                  leading: Icon(Icons.favorite),
                  title: Text("Favorite"),
                ),
              ),
              const PopupMenuItem(
                value: 4,
                child: ListTile(
                  leading: Icon(Icons.group),
                  title: Text("Group"),
                ),
              ),
            ],
            onSelected: (value) {
              switch (value) {
                case 1:
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const NewOrder()),
                  );
                  break;
                case 2:
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const PopulorItems()),
                  );
                  break;
                case 3:
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const FavoriteItems()),
                  );
                  break;
                case 4:
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const GroupScreen()),
                  );
                  break;
              }
            },
          ),
        ],
      ),
      drawer: const NavigationMenu(),
      body: Container(
        color: const Color(0xe4e4e4e4),
        child: ListView(
          children: [
            _buildUserCard(),
            _buildGridMenu(context),
          ],
        ),
      ),
    );
  }

  Widget _buildUserCard() {
    return Container(
      margin: const EdgeInsets.fromLTRB(10, 10, 10, 5),
      child: Card(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Good Afternoon',
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _fullname ?? 'Guest',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                      fontSize: 24,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          ),
                        ),
                        onPressed: () {},
                        child: const Text(
                          'My Order',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      const SizedBox(width: 10),
                      OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          ),
                        ),
                        onPressed: () {},
                        child: const Text(
                          'Settings',
                          style: TextStyle(fontSize: 16, color: Colors.blue),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Positioned(
              top: 10,
              right: 10,
              child: CircleAvatar(
                radius: 40,
                backgroundColor: Colors.grey[200],
                backgroundImage: NetworkImage('${AppUrl.url}images/$_image'),
                onBackgroundImageError: (_, __) {
                  // Handle error here
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGridMenu(BuildContext context) {
    final List<Map<String, dynamic>> menuItems = [
      {"icon": Icons.message, "title": "Messages", "screen": const NewOrder()},
      {"icon": Icons.favorite, "title": "Favorites", "screen": const FavoriteItems()},
      {"icon": Icons.shopping_cart, "title": "Orders", "screen": const NewOrder()},
      {"icon": Icons.card_travel, "title": "Travel", "screen": const GroupScreen()},
      {"icon": Icons.question_mark, "title": "Help", "screen": const GroupScreen()},
      {"icon": Icons.settings, "title": "Settings", "screen": const GroupScreen()},
    ];

    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: menuItems.map((item) {
        return Container(
          margin: const EdgeInsets.all(10),
          child: Card(
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => item["screen"]),
                );
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(item["icon"], size: 100, color: Colors.teal),
                  const SizedBox(height: 10),
                  Text(item["title"], style: const TextStyle(fontSize: 16)),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}

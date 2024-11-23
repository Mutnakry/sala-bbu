import 'package:flutter/material.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BBU Store'),
        backgroundColor: Colors.blue, // Set the AppBar color to blue
        actions: [PopupMenuButton<int>(
            itemBuilder: (context)=>[
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
          onSelected: (value){
            switch(value){
              case 1:
                // go to order screen
              Navigator.push(context,
                  MaterialPageRoute(builder: (context)=> const NewOrder()));
                break;
              case 2:
                Navigator.push(context,
                    MaterialPageRoute(builder: (context)=> const PopulorItems()));
              // go to message screen
                break;
              case 3:
                Navigator.push(context,
                    MaterialPageRoute(builder: (context)=> const FavoriteItems()));
              // go to favorite screen
                break;
              case 4:
                Navigator.push(context,
                    MaterialPageRoute(builder: (context)=> const GroupScreen()));
                // go to froup
                break;
            }
          },
         ),
        ],
      ),
      drawer: const NavigationMenu(),
      body: Container(
        color:const Color(0xe4e4e4e4),
        child: Stack(
          children: <Widget>[
            Container(
              height: 80,
              // color: Colors.blue, // Removed this line to avoid conflict with BoxDecoration
              decoration: BoxDecoration(
                color: Colors.blue, // Set the background color of the container
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
            ),
            ///// contect
            ListView(
              children:<Widget> [
                Container(
                  height: 160,
                  margin: const EdgeInsets.fromLTRB(10, 0, 10, 5),
                  child:Card(
                      child: Stack(
                        children:<Widget> [
                          Container(
                          margin: EdgeInsets.all(10.0),
                          child: Text(
                            'Good Acternoon',
                            style: TextStyle(
                                color: Colors.blue,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                          Container(
                            margin: EdgeInsets.fromLTRB(10, 35, 10, 10),
                            child: Text(
                              'BBU',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.blue,fontSize: 24,
                              ),
                            ),
                          ),
                          Positioned(
                            left: 10,
                            bottom: 10,
                            child: Row(
                              children: <Widget>[
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.blue,
                                 shape:const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(5.0)
                                  ), // Set the button background color
                                  ),
                                  ),
                                  onPressed: () {},
                                  child: Text(
                                    'My Order',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white, // Set the text color if needed
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10,),
                                OutlinedButton(
                                  style: OutlinedButton.styleFrom(
                                    shape:const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(5.0)
                                      ), // Set the button background color
                                    ),
                                  ),
                                  onPressed: () {},
                                  child: Text(
                                    'My Order',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.blueAccent, // Set the text color if needed
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            top: 10,
                              right: 10,
                              bottom: 10,
                              child: CircleAvatar(
                                radius: 40,
                                child: Padding(
                                  padding: EdgeInsets.all(3.0),
                                  child: ClipOval(
                                    child: Image.network(
                                      'https://img.favpng.com/3/21/23/computer-icons-mobile-app-development-android-png-favpng-9xKBGkE07CG2VqArV2AVqGNHk_t.jpg',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                          ),
                        ],
                      ),
                    ),
                  ),
                GridView.count(crossAxisCount:2,
                shrinkWrap: true,
                  physics:const NeverScrollableScrollPhysics(),
                  children:<Widget> [
                    //// cart 1  ///
                    Container(
                      margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                      child:Card(
                        child: InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>NewOrder()));
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.message, size: 100, color: Colors.teal),
                              SizedBox(height: 10.0),
                              Text('Contacts', style: TextStyle(fontSize: 16.0)),
                            ],
                          ),
                        ),
                      ),
                    ),
                    //// cart 2  ///
                    Container(
                      margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                      child:Card(
                        child: InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>FavoriteItems()));
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.favorite, size: 100, color: Colors.teal),
                              SizedBox(height: 10.0),
                              Text('Contacts', style: TextStyle(fontSize: 16.0)),
                            ],
                          ),
                        ),
                      ),
                    ),

                    //// cart 3  ///
                    Container(
                      margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                      child:Card(
                        child: InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>NewOrder()));
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.shopping_cart, size: 100, color: Colors.teal),
                              SizedBox(height: 10.0),
                              Text('Contacts', style: TextStyle(fontSize: 16.0)),
                            ],
                          ),
                        ),
                      ),
                    ),
                    //// cart 4 ///
                    Container(
                      margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                      child:const Card(
                        child: Center(

                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.card_travel_rounded, size: 100, color: Colors.teal),
                              SizedBox(height: 10.0),
                              Text('Contacts', style: TextStyle(fontSize: 16.0)),
                            ],
                          ),
                        ),
                      ),
                    ),
                    //// cart 5  ///
                    Container(
                      margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                      child:const Card(
                        child: Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.question_mark, size: 100, color: Colors.teal),
                              SizedBox(height: 10.0),
                              Text('Contacts', style: TextStyle(fontSize: 16.0)),
                            ],
                          ),
                        ),
                      ),
                    ),
                    //// cart 6 ///
                    Container(
                      margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                      child:const Card(
                        child: Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.settings, size: 100, color: Colors.teal),
                              SizedBox(height: 10.0),
                              Text('Contacts', style: TextStyle(fontSize: 16.0)),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),

    );
  }
}

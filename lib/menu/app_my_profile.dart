// import 'dart:io';
//
// import 'package:flutter/material.dart';
// import 'package:sala_bu/app_url.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:image_picker/image_picker.dart';
//
// class AppMyProfile extends StatefulWidget {
//   const AppMyProfile({super.key});
//
//   @override
//   State<AppMyProfile> createState() => _MyProfileState();
// }
//
// class _MyProfileState extends State<AppMyProfile> {
//   final _keyForm = GlobalKey<FormState>();
//   String? _username;
//   String? _fullname;
//   String? _phone;
//   String? _email;
//   String? _image = "default.png";
//   File? _newImage;
//
//   @override
//   void initState(){
//     super.initState();
//     _loadUserData();
//   }
//
//   Future<void> _PickImag() async{
//     final file = await ImagePicker().pickImage(source:ImageSource.gallery);
//     if(file != null){
//       _newImage = File(file.path);
//     }
//   }
//
//   Future<void> _loadUserData() async {
//     final sp = await SharedPreferences.getInstance();
//     setState(() {
//       _username = sp.getString("userName");
//       _fullname = sp.getString("fullname") ?? 'N/A';
//       _phone = sp.getString("phone") ?? 'N/A';
//       _email = sp.getString("userEmail") ?? 'N/A';
//       _image = sp.getString("userImage") ?? 'default.png';
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('My Profile'),
//       ),
//       body: Form(
//         key: _keyForm,
//         child: Padding(
//           padding: const EdgeInsets.all(20.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Stack(
//                 children: [
//                   // Display the image
//                   Container(
//                     decoration: BoxDecoration(
//                       shape: BoxShape.circle,
//                       border: Border.all(
//                         color: Colors.grey, // Border color
//                         width: 2.0,         // Border width
//                       ),
//                     ),
//                     child: CircleAvatar(
//                       radius: 50,
//                       backgroundColor: Colors.grey.shade300,
//                       child: ClipOval(
//                         child: _newImage != null
//                             ? Image.file(
//                           _newImage!,
//                           fit: BoxFit.cover,
//                           width: double.infinity,
//                           height: double.infinity,
//                         )
//                             : Image.network(
//                           '${AppUrl.url}images/$_image',
//                           fit: BoxFit.cover,
//                           width: double.infinity,
//                           height: double.infinity,
//                           errorBuilder: (context, error, stackTrace) {
//                             return const Icon(
//                               Icons.person,
//                               size: 40,
//                               color: Colors.white,
//                             );
//                           },
//                           loadingBuilder: (context, child, loadingProgress) {
//                             if (loadingProgress == null) return child;
//                             return Center(
//                               child: CircularProgressIndicator(
//                                 value: loadingProgress.expectedTotalBytes != null
//                                     ? loadingProgress.cumulativeBytesLoaded /
//                                     (loadingProgress.expectedTotalBytes ?? 1)
//                                     : null,
//                               ),
//                             );
//                           },
//                         ),
//                       ),
//                     ),
//                   ),
//                   // Camera icon to update image
//                   Positioned(
//                     bottom: 0,
//                     right: 0,
//                     child: InkWell(
//                       onTap: _PickImag, // Trigger PickImag when the camera icon is tapped
//                       child: Container(
//                         decoration: BoxDecoration(
//                           color: Colors.blueAccent,
//                           shape: BoxShape.circle,
//                           border: Border.all(color: Colors.white, width: 2),
//                         ),
//                         padding: const EdgeInsets.all(6),
//                         child: const Icon(
//                           Icons.camera_alt,
//                           color: Colors.white,
//                           size: 20,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//
//               Text(
//                 "$_fullname",
//                 style: Theme.of(context)
//                     .textTheme
//                     .headlineMedium
//                     ?.copyWith(fontWeight: FontWeight.bold),
//               ),
//               const SizedBox(height: 16),
//               const Divider(),
//               const SizedBox(height: 10),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: const [
//                   Text(
//                     'ACCOUNT DETAIL',
//                     style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                       color: Colors.black,
//                     ),
//                   ),
//                   Text(
//                     'EDIT',
//                     style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                       color: Colors.blue,
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 16),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children:  [
//                   Text('Username:'),
//                   Text(
//                     '$_username',
//                     style: TextStyle(fontWeight: FontWeight.bold),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 15),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text('Full Name:'),
//                   Text(
//                     '$_fullname',
//                     style: TextStyle(fontWeight: FontWeight.bold),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 15),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text('Phone Number:'),
//                   Text(
//                     '$_phone',
//                     style: TextStyle(fontWeight: FontWeight.bold),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 15,),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text('Email:'),
//                   Text(
//                     '$_email',
//                     style: TextStyle(fontWeight: FontWeight.bold),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 16),
//               const Divider(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

class AppMyProfile extends StatefulWidget {
  const AppMyProfile({Key? key}) : super(key: key);

  @override
  State<AppMyProfile> createState() => _AppMyProfileState();
}

class _AppMyProfileState extends State<AppMyProfile> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}


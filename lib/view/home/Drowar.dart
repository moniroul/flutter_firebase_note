import 'package:flutter/material.dart';
import 'package:flutter_firebase_note/controller/authController.dart';
import 'package:flutter_firebase_note/view/widgets/widget.dart';
import 'package:get/get.dart';

class Drowar extends StatefulWidget {
  const Drowar({Key? key}) : super(key: key);

  @override
  _DrowarState createState() => _DrowarState();
}

class _DrowarState extends State<Drowar> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.maxFinite,
            child: DrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blue, Colors.purple],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage('assets/sanjid15.png'),
                  ),
                  text('MD:Sanjid', 24, FontWeight.w400, 0xFFFFFFFF),
                  Text(
                    'gamarsanged@gmail.com',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home, color: Colors.blue),
            title: Text('Home'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.person, color: Colors.green),
            title: Text('Profile'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.settings, color: Colors.grey),
            title: Text('Settings'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.logout, color: Colors.red),
            title: Text('Logout'),
            onTap: () async {
              final authCtr = Get.find<Authcontroller>();
              await authCtr.userLogout(context);
            },
          ),
        ],
      ),
    );
  }
}

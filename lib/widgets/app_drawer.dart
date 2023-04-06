import 'package:flutter/material.dart';
import '../screens/home_page.dart';
//import '../screens/image_picker_screen.dart';
import '../screens/show_images_screen.dart';
import 'package:amplify_authenticator/amplify_authenticator.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //final auth = Provider.of<Auth>(context, listen: false);

    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: Text('Data Viewer Drawer'),
            automaticallyImplyLeading: false,
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (ctx) => HomePage(),
                ),
              );
            },
          ),
          // ListTile(
          //   leading: Icon(Icons.cloud_upload),
          //   title: Text('Upload Images'),
          //   onTap: () async {
          //     Navigator.pushReplacement(
          //       context,
          //       MaterialPageRoute(
          //         builder: (ctx) => SelectImage(),
          //       ),
          //     );
          //   },
          // ),
          ListTile(
            leading: Icon(Icons.image),
            title: Text('View Images'),
            onTap: () async {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (ctx) => ListBucketScreen(),
                ),
              );
            },
          ),
          Expanded(
              flex: 1,
              child: Align(
                  alignment: Alignment.bottomCenter, child: SignOutButton())),
          SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }
}

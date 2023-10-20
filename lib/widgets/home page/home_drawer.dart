import 'package:assignment/pages/input_name_page.dart';
import 'package:assignment/widgets/warning_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(children: [
        ListTile(
          leading: Icon(Icons.exit_to_app,color: Colors.red,),
          title: Text('Exit app'),
          onTap: () {
            warningDialog(
              context: context,
              content: 'Are you sure you want to exit app',
              onYesPressed: () {
                SystemNavigator.pop();
              },
            );
          },
        ),
        ListTile(
          leading: Icon(Icons.delete_forever,color: Colors.red,),
          title: Text('Delete account'),
          onTap: () async {
            warningDialog(context: context, content: 'Are you sure you want to delete your account', onYesPressed: ()async{
              SharedPreferences prefs = await SharedPreferences.getInstance();
            await prefs.clear();
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (ctx) => InputNamePage(),
                ),
                (route) => false);
            }
            );
          },
        ),
      ]),
    );
  }
}

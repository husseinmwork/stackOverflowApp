import 'package:flutter/material.dart';
import 'package:todo_app/constants/colors.dart';
import 'package:todo_app/utils/routes/routes.dart';
import 'package:todo_app/widgets/image_avatar.dart';

class AppDrawer extends StatefulWidget {
  final String image;
  final String userName;
  final String? fullName;
  final String email;

  const AppDrawer({required this.image,required this.userName, this.fullName,required this.email}) ;

  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          _createHeader(),
          _createDrawerItem(
              icon: Icons.contacts, text: 'My Question', onTap: () {
                Navigator.of(context).pushNamed(Routes.my_question);
          }),
          _createDrawerItem(icon: Icons.event, text: 'Events', onTap: () {}),
          _createDrawerItem(icon: Icons.note, text: 'Notes', onTap: () {}),
          Divider(),
          _createDrawerItem(
              icon: Icons.collections_bookmark, text: 'Steps', onTap: () {}),
          _createDrawerItem(icon: Icons.face, text: 'Authors', onTap: () {}),
          _createDrawerItem(
              icon: Icons.account_box,
              text: 'Flutter Documentation',
              onTap: () {}),
          _createDrawerItem(
              icon: Icons.stars, text: 'Useful Links', onTap: () {}),
        ],
      ),
    );
  }

  Widget _createHeader() {
    return DrawerHeader(
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
        ),
        margin: EdgeInsets.zero,
        padding: EdgeInsets.zero,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ImageAvatar(
              radius: 40,
              onTap: () {},
              image: widget.image,
              borderRadius: 40,
            ),
            Text(widget.email),
            Text(widget.userName),
          ],
        ));
  }

  Widget _createDrawerItem(
      {required IconData icon,
      required String text,
      required GestureTapCallback onTap}) {
    return ListTile(
      title: Row(
        children: <Widget>[
          Icon(icon),
          Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Text(text),
          )
        ],
      ),
      onTap: onTap,
    );
  }
}

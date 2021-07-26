import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/constants/assets.dart';
import 'package:todo_app/constants/dimens.dart';
import 'package:todo_app/store/home/home_store.dart';
import 'package:todo_app/store/theme/theme_store.dart';
import 'package:todo_app/utils/routes/routes.dart';

class AppDrawer extends StatefulWidget {
  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  late HomeStore _store;
  late ThemeStore _themeStore;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _store = Provider.of<HomeStore>(context);
    _themeStore = Provider.of<ThemeStore>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          _createHeader(),

          // _createDrawerItem(
          //     icon: Icons.contacts,
          //     text: 'My Question',
          //     onTap: () {
          //       // Navigator.of(context).pushNamed(Routes.my_question);
          //     }),
          // _createDrawerItem(icon: Icons.event, text: 'Events', onTap: () {}),
          // _createDrawerItem(icon: Icons.note, text: 'Notes', onTap: () {}),
          // Divider(),
          // _createDrawerItem(
          //     icon: Icons.collections_bookmark, text: 'Steps', onTap: () {}),
          // _createDrawerItem(icon: Icons.face, text: 'Authors', onTap: () {}),
          // _createDrawerItem(
          //     icon: Icons.account_box,
          //     text: 'Flutter Documentation',
          //     onTap: () {}),
          _createDrawerItem(
              icon: Icons.logout,
              text: 'Logout',
              onTap: () {
                Navigator.of(context).pop();
                _store.logout();
                Navigator.of(context).pushReplacementNamed(Routes.login);
              }),
          _createDrawerItem(
              icon: Icons.settings,
              text: 'Settings',
              onTap: () {
                Navigator.of(context).pop();
              }),
        ],
      ),
    );
  }

  Widget _createHeader() {
    // onTap: () {
    //   Navigator.of(context).pop();
    //   Navigator.of(context).pushNamed(Routes.profile_screen);
    // },
    return UserAccountsDrawerHeader(
      accountName:  Text(_store.user?.username ?? "null" ,
          style: Theme.of(context).textTheme.bodyText1),
      accountEmail: Text(_store.user?.email ?? "null",
          style: Theme.of(context).textTheme.subtitle1),
      decoration: BoxDecoration(
        color:  Theme.of(context).primaryColor,
      ),
      otherAccountsPictures: [ _buildThemeButton(),],
      currentAccountPicture: CircleAvatar(
        radius: Dimens.imageDrawer,
        child: ClipOval(
          child: FadeInImage.assetNetwork(
            fit: BoxFit.cover,
            placeholder: Assets.placeHolder,
            height: double.infinity,
            width: double.infinity,
            image: _store.user?.image ?? "null",
            imageErrorBuilder: (_, __, ___) {
              return Image.asset(Assets.placeHolder, fit: BoxFit.cover);
            },
          ),
        ),
      ),
    );
  }

  Widget _buildThemeButton() => Observer(
    builder: (context) {
      return IconButton(
        onPressed: () {
          _themeStore.changeBrightnessToDark(!_themeStore.darkMode);
        },
        icon: Icon(
          _themeStore.darkMode ? Icons.brightness_5 : Icons.brightness_3,
        ),
      );
    },
  );
  Widget _createDrawerItem(
      {required IconData icon,
      required String text,
      required GestureTapCallback onTap}) {
    return ListTile(
      title: Row(
        children: <Widget>[
          Icon(icon, color: _themeStore.darkMode ? Colors.white : Colors.black),
          Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Text(
              text,
              style: Theme.of(context).textTheme.bodyText1?.copyWith(
                  color: _themeStore.darkMode ? Colors.white : Colors.black),
            ),
          )
        ],
      ),
      onTap: onTap,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/constants/assets.dart';
import 'package:todo_app/constants/dimens.dart';
import 'package:todo_app/store/language/language_store.dart';
import 'package:todo_app/store/profile/profile_store.dart';
import 'package:todo_app/store/theme/theme_store.dart';
import 'package:todo_app/utils/routes/routes.dart';
import 'package:todo_app/widgets/outlined_button.dart';
import 'package:todo_app/widgets/stack_overflow_indecator.dart';
import 'package:todo_app/widgets/user_image_avatar.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late LanguageStore _languageStore;
  late ProfileStore _store;
  late ThemeStore _themeStore;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _languageStore = Provider.of<LanguageStore>(context);
    _store = Provider.of<ProfileStore>(context);
    _themeStore = Provider.of<ThemeStore>(context);
    _store.getProfile();
  }

  @override
  void dispose() {
    super.dispose();
    _store.success = false;
  }

  @override
  Widget build(BuildContext context) {
    //todo send request after edit

    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  AppBar _buildAppBar() => AppBar(
        title: Text("Profile", style: Theme.of(context).textTheme.headline6?.copyWith(color: Colors.white)),
      );

  Widget _buildBody() => Stack(
        children: [
          Observer(
            builder: (_) => Visibility(
              visible: _store.success,
              replacement: StackOverFlowIndecator(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: Dimens.padding_large),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: Dimens.padding_xl),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _buildImage(),
                            Expanded(child: _buildRow()),
                          ],
                        ),
                        SizedBox(height: Dimens.padding_normal),
                        _buildFullName(),
                        SizedBox(height: Dimens.padding_normal),
                        _buildEmail(),
                        SizedBox(height: Dimens.padding_normal),
                        _buildUserName(),
                        SizedBox(height: Dimens.padding_xl),
                        _buildButton()
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      );

  Widget _buildImage() => UserImageAvatar(
      height: 100,
      width: 100,
      image: _store.profile?.image ?? "error",
      onTap: () {});

  Widget _buildFullName() => Text(
        _store.profile?.fullName ?? "null",
        style: Theme.of(context).textTheme.headline6?.copyWith(
              color: _themeStore.darkMode ? Colors.white : Colors.black,
            ),
      );

  Widget _buildUserName() => Text(
        _store.profile?.userName ?? "",
        style: Theme.of(context).textTheme.subtitle2?.copyWith(
              color: _themeStore.darkMode ? Colors.white : Colors.black,
            ),
      );

  Widget _buildEmail() => Text(
        _store.profile?.email ?? "",
        style: Theme.of(context).textTheme.subtitle2?.copyWith(
              color: _themeStore.darkMode ? Colors.white : Colors.black,
            ),
      );

  Widget _buildRow() => Container(
        padding: EdgeInsets.all(Dimens.padding_normal),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Text(
                  _store.profile?.score?.toString() ?? "0",
                  style: Theme.of(context).textTheme.headline6?.copyWith(
                        color:
                            _themeStore.darkMode ? Colors.white : Colors.black,
                      ),
                ),
                Text(
                  "Score",
                  style: Theme.of(context).textTheme.subtitle2?.copyWith(
                        color:
                            _themeStore.darkMode ? Colors.white : Colors.black,
                      ),
                ),
              ],
            ),
            SizedBox(
              height: Dimens.padding_xxl,
              child: VerticalDivider(
                color: _themeStore.darkMode ? Colors.white : Colors.black,
              ),
            ),
            Column(
              children: [
                Text(
                  _store.profile?.question?.length.toString() ?? "0",
                  style: Theme.of(context).textTheme.headline6?.copyWith(
                        color:
                            _themeStore.darkMode ? Colors.white : Colors.black,
                      ),
                ),
                Text(
                  "Question",
                  style: Theme.of(context).textTheme.subtitle2?.copyWith(
                        color:
                            _themeStore.darkMode ? Colors.white : Colors.black,
                      ),
                ),
              ],
            ),
            SizedBox(
              height: Dimens.padding_xxl,
              child: VerticalDivider(
                color: _themeStore.darkMode ? Colors.white : Colors.black,
              ),
            ),
            Column(
              children: [
                Text(
                  _store.profile?.answer?.length.toString() ?? "0",
                  style: Theme.of(context).textTheme.headline6?.copyWith(
                        color:
                            _themeStore.darkMode ? Colors.white : Colors.black,
                      ),
                ),
                Text(
                  "Answers",
                  style: Theme.of(context).textTheme.subtitle2?.copyWith(
                        color:
                            _themeStore.darkMode ? Colors.white : Colors.black,
                      ),
                ),
              ],
            ),
          ],
        ),
      );

  Widget _buildButton() => SizedBox(
        height: 40,
        child: OutlinedButtonS(
          borderColor: _themeStore.darkMode
              ? Colors.white
              : Theme.of(context).accentColor,
          titleColor: _themeStore.darkMode
              ? Colors.white
              : Theme.of(context).accentColor,
          onPressed: () async {
            final result = await Navigator.of(context)
                .pushNamed(Routes.edit_profile_screen);
            if (result == true) {
              _store.success = false;
              _store.getProfile();
            }
          },
          title: "Edit",
        ),
      );
}

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
import 'package:todo_app/widgets/arrow_back_icon.dart';

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
  Widget build(BuildContext context) {
    //todo send request after edit

    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  AppBar _buildAppBar() => AppBar(
        elevation: 4,
        leading: ArrowBackIcon(),
        //todo  LocaleKeys.goto_register.tr(), change language after complete all section profile
        title: Text("Profile", style: Theme.of(context).textTheme.headline6),
        actions: [
          TextButton(
            style: TextButton.styleFrom(backgroundColor: Colors.transparent),
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushNamed(Routes.edit_profile_screen);
            },
            child: Text(
              "Edit",
              style: Theme.of(context).textTheme.button,
            ),
          )
        ],
      );

  Widget _buildBody() => Observer(
        builder: (_) => Visibility(
          visible: _store.profile != null,
          replacement: Center(
            child: SpinKitFoldingCube(color: Colors.purple[200]),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                //todo add color
                // color:Colors.grey[800],
                height: MediaQuery.of(context).size.height * 0.40,
                width: double.infinity,
                child: Column(
                  children: [
                    SizedBox(height: Dimens.padding_xl),

                    _buildImage(),
                    SizedBox(height: Dimens.padding_normal),
                    _buildFullName(),
                    SizedBox(height: Dimens.padding_normal),
                    _buildEmail(),
                    SizedBox(height: Dimens.padding_normal),
                    _buildUserName(),
                  ],
                ),
              ),

              _buildRow(),
            ],
          ),
        ),
      );

  Widget _buildImage() => CircleAvatar(
        radius: Dimens.imageProfile,
        child: ClipOval(
          child: FadeInImage.assetNetwork(
            fit: BoxFit.cover,
            placeholder: Assets.placeHolder,
            height: double.infinity,
            width: double.infinity,
            image: _store.profile?.image ?? "null",
            imageErrorBuilder: (_, __, ___) {
              return Image.asset(Assets.placeHolder, fit: BoxFit.cover);
            },
          ),
        ),
      );

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

  Widget _buildRow() => Transform.translate(
    offset: Offset(0,-35),
    child: Card(
      elevation: Dimens.padding_mini,
      margin: EdgeInsets.symmetric(horizontal: Dimens.padding_normal),
      child: Container(
        padding: EdgeInsets.all(Dimens.padding_normal),
        child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Text(
                      _store.profile?.score?.toString() ?? "0",
                      style: Theme.of(context).textTheme.headline6?.copyWith(
                            color: _themeStore.darkMode ? Colors.white : Colors.black,
                          ),
                    ),
                    Text(
                      "Score",
                      style: Theme.of(context).textTheme.subtitle2?.copyWith(
                            color: _themeStore.darkMode ? Colors.white : Colors.black,
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
                            color: _themeStore.darkMode ? Colors.white : Colors.black,
                          ),
                    ),
                    Text(
                      "Question",
                      style: Theme.of(context).textTheme.subtitle2?.copyWith(
                            color: _themeStore.darkMode ? Colors.white : Colors.black,
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
                            color: _themeStore.darkMode ? Colors.white : Colors.black,
                          ),
                    ),
                    Text(
                      "Answers",
                      style: Theme.of(context).textTheme.subtitle2?.copyWith(
                            color: _themeStore.darkMode ? Colors.white : Colors.black,
                          ),
                    ),
                  ],
                ),
              ],
            ),
      ),
    ),
  );
}

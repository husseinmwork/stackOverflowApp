import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/constants/assets.dart';
import 'package:todo_app/constants/dimens.dart';
import 'package:todo_app/store/language/language_store.dart';
import 'package:todo_app/store/profile/profile_store.dart';
import 'package:todo_app/utils/routes/routes.dart';
import 'package:todo_app/widgets/arrow_back_icon.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late LanguageStore _languageStore;
  late ProfileStore _store;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _languageStore = Provider.of<LanguageStore>(context);
    _store = Provider.of<ProfileStore>(context);
    _store.getProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  AppBar _buildAppBar() => AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: ArrowBackIcon(),
        //todo  LocaleKeys.goto_register.tr(), change language after complete all section profile
        title: Text("Profile", style: Theme.of(context).textTheme.headline6),

        actions: [
          OutlinedButton(
              onPressed: () {
                Navigator.of(context).pushReplacementNamed(Routes.edit_profile_screen);
              },
              child: Text(
                "Edit",
                style: Theme.of(context).textTheme.button,
              ))
        ],
      );

  Widget _buildBody() => Observer(
        builder: (_) => Visibility(
          visible: _store.profile != null,
          replacement: Center(
            child: CircularProgressIndicator(),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildImage(),
              _buildFullName(),
              _buildEmail(),
              _buildUserName(),
              SizedBox(height: Dimens.padding_xl),
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

  Widget _buildFullName() => Text(_store.profile?.fullName ?? "null",
      style: Theme.of(context).textTheme.headline6);

  Widget _buildUserName() => Text(_store.profile?.userName ?? "",
      style: Theme.of(context).textTheme.subtitle2);

  Widget _buildEmail() => Text(_store.profile?.email ?? "",
      style: Theme.of(context).textTheme.subtitle2);

  Widget _buildRow() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: [
              Text(_store.profile?.score?.toString() ?? "0",
                  style: Theme.of(context).textTheme.headline6),
              Text("Score", style: Theme.of(context).textTheme.subtitle2),
            ],
          ),
          SizedBox(
            height: Dimens.padding_xxl,
            child: VerticalDivider(
              color: Colors.white,
            ),
          ),
          Column(
            children: [
              Text(_store.profile?.question?.length.toString() ?? "0",
                  style: Theme.of(context).textTheme.headline6),
              Text("Question", style: Theme.of(context).textTheme.subtitle2),
            ],
          ),
          SizedBox(
            height: Dimens.padding_xxl,
            child: VerticalDivider(
              color: Colors.white,
            ),
          ),
          Column(
            children: [
              Text(_store.profile?.answer?.length.toString() ?? "0",
                  style: Theme.of(context).textTheme.headline6),
              Text("Answers", style: Theme.of(context).textTheme.subtitle2),
            ],
          ),
        ],
      );
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/constants/assets.dart';
import 'package:todo_app/constants/dimens.dart';
import 'package:todo_app/store/profile/profile_store.dart';
import 'package:todo_app/utils/locale/app_localization.dart';
import 'package:todo_app/widgets/arrow_back_icon.dart';
import 'package:todo_app/widgets/todo_outlined_button.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late ProfileStore _store;
  late AppLocalizations appLocalizations;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _store = Provider.of<ProfileStore>(context);
    appLocalizations = AppLocalizations.of(context);
    _store.getProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      elevation: 0,
      centerTitle: true,
      title: Text("Profile", style: Theme.of(context).textTheme.subtitle1),
      leading: ArrowBackIcon(),
      actions: [
        TodoOutlinedButton(
          title: "Edit",
          onTap: () {},
        )
      ],
    );
  }

  Widget _buildBody() {
    return Container(
      height: double.infinity,
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 70,
            backgroundColor: Colors.red,

            child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: FadeInImage.assetNetwork(
                fit: BoxFit.cover,
                placeholder: Assets.placeHolder,
                width: 50,
                height: 60,
                //todo get image from api
                image: _store.profile!.image??"",
                imageErrorBuilder: (_, __, ___) {
                  return Image.asset(Assets.placeHolder);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }


}

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/constants/assets.dart';
import 'package:todo_app/constants/colors.dart';
import 'package:todo_app/constants/dimens.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:todo_app/store/language/language_store.dart';
import 'package:todo_app/store/profile/profile_store.dart';
import 'package:todo_app/utils/device/device_utils.dart';
import 'package:todo_app/utils/routes/routes.dart';
import 'package:todo_app/widgets/labeled_text_field.dart';
import 'package:todo_app/generated/locale_keys.g.dart';
import 'package:todo_app/widgets/todo_button.dart';

class EditProfileScreen extends StatefulWidget {
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late LanguageStore _languageStore;
  late ProfileStore _store;
  final picker = ImagePicker();

  //controller:-----------------------------------------------------------------
  TextEditingController _userNameController = TextEditingController();
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();

  //focus node:-----------------------------------------------------------------
  FocusNode _firstNameFocusNode = FocusNode();
  FocusNode _lastNameFocusNode = FocusNode();
  FocusNode _userNameFocusNode = FocusNode();
  FocusNode _emailFocusNode = FocusNode();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _languageStore = Provider.of<LanguageStore>(context);
    _store = Provider.of<ProfileStore>(context);
    if (_store.firstName == null &&
        _store.lastName == null &&
        _store.email == null &&
        _store.email == null) {
      _firstNameController.text = _store.profile?.firstName ?? "";
      _lastNameController.text = _store.profile?.lastName ?? "";
      _userNameController.text = _store.profile?.userName ?? "";
      _emailController.text = _store.profile?.email ?? "";
    }
  }

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      _store.image = File(pickedFile.path);
    } else {
      debugPrint('No image selected.;');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  AppBar _buildAppBar() => AppBar(
        title: Text(
          "Edit Profile",
          style: Theme.of(context)
              .textTheme
              .headline6
              ?.copyWith(color: Colors.white),
        ),
      );

  Widget _buildBody() => Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: Dimens.padding_xl),
              _buildImage(),
              _buildTextField(),
              _buildButton()
            ],
          ),
        ],
      );

  Widget _buildImage() => GestureDetector(
        onTap: () async {
          await getImage();
        },
        child: Stack(
          children: [
            Observer(
              builder: (_) => Container(
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                        color: Theme.of(context).accentColor, width: 2)),
                child: CircleAvatar(
                  radius: Dimens.imageProfile,
                  child: ClipOval(
                    child: _store.image == null
                        ? Image.network(
                            _store.profile!.image!,
                            fit: BoxFit.cover,
                            height: double.infinity,
                            width: double.infinity,
                          )
                        : Image.file(
                            _store.image!,
                            fit: BoxFit.cover,
                            height: double.infinity,
                            width: double.infinity,
                          ),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: CircleAvatar(
                radius: 18,
                backgroundColor: Theme.of(context).accentColor,
                child: Icon(Icons.add_a_photo_outlined,
                    size: 22, color: Colors.white),
              ),
            )
          ],
        ),
      );

  Widget _buildTextField() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Dimens.padding_large),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              children: [
                Expanded(
                  child: LabeledTextField(
                    focusNode: _firstNameFocusNode,
                    title: LocaleKeys.regs_text_field_lable_first_name.tr(),
                    textController: _firstNameController,
                    hint: LocaleKeys.regs_text_field_lable_first_name.tr(),
                    onChanged: (name) {
                      _store.firstName = name;
                    },
                    onFieldSubmitted: (value) {
                      FocusScope.of(context).requestFocus(_lastNameFocusNode);
                    },
                  ),
                ),
                SizedBox(width: Dimens.padding_large),
                Expanded(
                  child: LabeledTextField(
                    focusNode: _lastNameFocusNode,
                    title: LocaleKeys.regs_text_field_lable_last_name.tr(),
                    textController: _lastNameController,
                    hint: LocaleKeys.regs_text_field_lable_last_name.tr(),
                    onChanged: (name) {
                      _store.lastName = name;
                    },
                    onFieldSubmitted: (value) {
                      FocusScope.of(context).requestFocus(_userNameFocusNode);
                    },
                  ),
                ),
              ],
            ),
            LabeledTextField(
              focusNode: _userNameFocusNode,
              title: LocaleKeys.regs_text_field_lable_user_name.tr(),
              textController: _userNameController,
              hint: LocaleKeys.regs_text_field_lable_user_name.tr(),
              onChanged: (name) {
                _store.userName = name;
              },
              onFieldSubmitted: (value) {
                FocusScope.of(context).requestFocus(_emailFocusNode);
              },
            ),
            LabeledTextField(
              isIcon: false,
              title: LocaleKeys.regs_text_field_lable_email.tr(),
              textController: _emailController,
              hint: LocaleKeys.regs_text_field_hint_email.tr(),
              focusNode: _emailFocusNode,
              onChanged: (email) {
                _store.email = email;
              },
              onFieldSubmitted: (value) {},
            ),
          ],
        ),
      ),
    );
  }

  void onSaveTaped() async {
    final snackBar = SnackBar(
      content: Observer(
        builder: (_) => Text(
          _store.errorStore.errorMessage,
          style: TextStyle(color: Colors.white),
        ),
      ),
      behavior: SnackBarBehavior.fixed,
      backgroundColor: AppColors.DarkPurple,
      duration: Duration(seconds: 4),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  void dispose() {
    super.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _userNameController.dispose();
    _emailController.dispose();
  }

  Widget _buildButton() => Container(
        margin: EdgeInsets.symmetric(
            horizontal: Dimens.padding_large, vertical: Dimens.padding_normal),
        child: RoundedButton(
          loading: _store.loading,
          onPressed: () async {
            DeviceUtils.hideKeyboard(context);
            await _store.updateProfile().then((value) {
              Navigator.of(context).pop(true);
              _store.firstName = null;
              _store.lastName = null;
              _store.userName = null;
              _store.email = null;
              _store.loading = false;
            }).catchError((e) {
              _store.loading = false;
              if (_store.errorEditProfile) onSaveTaped();
            });
          },
          title: "Edit",
        ),
      );
}

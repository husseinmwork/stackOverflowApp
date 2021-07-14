import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/constants/assets.dart';
import 'package:todo_app/constants/dimens.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:todo_app/store/language/language_store.dart';
import 'package:todo_app/store/profile/profile_store.dart';
import 'package:todo_app/utils/device/device_utils.dart';
import 'package:todo_app/widgets/arrow_back_icon.dart';
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
    _firstNameController.text = _store.profile?.firstName??"";
    _lastNameController.text  = _store.profile?.lastName??"";
    _userNameController.text  = _store.profile?.userName??"";
    _emailController.text  = _store.profile?.email??"";
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
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  AppBar _buildAppBar() => AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: ArrowBackIcon(),
        //todo  LocaleKeys.goto_register.tr(), change language after complete all section profile
        title:
            Text("Edit Profile", style: Theme.of(context).textTheme.headline6),
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
              _buildTextField(),
            ],
          ),
        ),
      );

  Widget _buildImage() => GestureDetector(
   onTap: ()async{
     await getImage();
   },
    child: Stack(
          children: [
            CircleAvatar(
              radius: Dimens.imageProfile,
              child: ClipOval(
                child: _store.image == null
                    ? Icon(Icons.add_a_photo, size: Dimens.padding_xxl)
                    : Image.file(
                  _store.image!,
                  fit: BoxFit.cover,
                  height: double.infinity,
                  width: double.infinity,
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: CircleAvatar(
                radius: 25,
                backgroundColor: Colors.green,
                child: Icon(Icons.add_a_photo_outlined,
                    size: 35, color: Colors.white),
              ),
            )
          ],
        ),
  );

  Widget _buildTextField() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Dimens.padding_xl),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            LabeledTextField(
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
            LabeledTextField(
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
            RoundedButton(
              onPressed: () async {
                DeviceUtils.hideKeyboard(context);
                _store.updateProfile();
                // if (_formStore.canLogin) {
                //   await _store.login();
                //   if (_store.errorLogin) onSaveTaped();
                // } else {
                //   showErrorMessage('Please check all fields', context);
                // }
              },
              title: Text("Edit", style: Theme.of(context).textTheme.button),
            ),
          ],
        ),
      ),
    );
  }
}

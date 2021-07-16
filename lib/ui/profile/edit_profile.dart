import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
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
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  AppBar _buildAppBar() => AppBar(
    elevation: 4,
        leading: MaterialButton(
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(
                  color: Color(0xFF5E6272),
                ),
                borderRadius: BorderRadius.circular(Dimens.borderIcon)),
            child: Icon(
              Icons.arrow_back,
            ),
          ),
          onPressed: () {
            Navigator.of(context).pushReplacementNamed(Routes.profile_screen);
          },
        ),
        //todo  LocaleKeys.goto_register.tr(), change language after complete all section profile
        title:
            Text("Edit Profile", style: Theme.of(context).textTheme.headline6),
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
            ],
          ),
          Align(
            alignment: Alignment.center,
            child: Observer(
              builder: (_) => Visibility(
                visible: _store.loading == true,
                child: SpinKitFoldingCube(color: Colors.purple[200]),
              ),
            ),
          ),
          Observer(builder: (_) {
            return _store.success
                ? _navigateToLoginScreen(context)
                : _buildClosed();
          }),
        ],
      );

  Widget _buildImage() => GestureDetector(
        onTap: () async {
          await getImage();
        },
        child: Stack(
          children: [
            Observer(
              builder: (_) => CircleAvatar(
                radius: Dimens.imageProfile,
                child: ClipOval(
                  child: _store.image == null
                      ? Image.asset(Assets.placeHolder, fit: BoxFit.cover)
                      : Image.file(
                          _store.image!,
                          fit: BoxFit.cover,
                          height: double.infinity,
                          width: double.infinity,
                        ),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: CircleAvatar(
                radius: 22,
                backgroundColor: Colors.green,
                child: Icon(Icons.add_a_photo_outlined,
                    size: 30, color: Colors.white),
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
                await _store.updateProfile();
                if (_store.errorEditProfile) onSaveTaped();
                _store.firstName = null;
                _store.lastName = null;
                _store.userName = null;
                _store.email= null;
              },
              title: Text("Edit", style: Theme.of(context).textTheme.button),
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

  ///this  Navigation to another page
  _buildClosed() {
    return SizedBox.shrink();
  }

  Widget _navigateToLoginScreen(BuildContext context) {
    Future.delayed(Duration.zero, () {
      Navigator.of(context).pushReplacementNamed(Routes.profile_screen);
      _store.loading = false;
    });
    _store.success = false;
    return Container();
  }

  @override
  void dispose() {
    super.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _userNameController.dispose();
    _emailController.dispose();
  }
}

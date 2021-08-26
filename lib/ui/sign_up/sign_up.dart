import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/constants/app_theme.dart';
import 'package:todo_app/constants/dimens.dart';
import 'package:todo_app/generated/locale_keys.g.dart';
import 'package:todo_app/packages/toast.dart';
import 'package:todo_app/store/form/form_store.dart';
import 'package:todo_app/store/sign_up/sign_up.dart';
import 'package:todo_app/store/theme/theme_store.dart';
import 'package:todo_app/utils/device/device_utils.dart';
import 'package:todo_app/utils/routes/routes.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:todo_app/utils/todo/todo_utils.dart';
import 'package:todo_app/widgets/labeled_text_field.dart';
import 'package:todo_app/widgets/todo_button.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen>
    with SingleTickerProviderStateMixin {
  //controller:-----------------------------------------------------------------
  TextEditingController _userNameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();

  //focus node:-----------------------------------------------------------------
  FocusNode _firstNameFocusNode = FocusNode();
  FocusNode _lastNameFocusNode = FocusNode();
  FocusNode _userNameFocusNode = FocusNode();
  FocusNode _passwordFocusNode = FocusNode();
  FocusNode _confirmPasswordFocusNode = FocusNode();
  FocusNode _emailFocusNode = FocusNode();

  final _formStore = FormStore();
  late SignUpStore _store;
  late ThemeStore _themeStore;
  final picker = ImagePicker();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _store = Provider.of<SignUpStore>(context);
    _themeStore = Provider.of<ThemeStore>(context);
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

  AppBar _buildAppBar() {
    return AppBar(
      title: Text(LocaleKeys.sign_up.tr(),
          style: Theme.of(context)
              .textTheme
              .headline6
              ?.copyWith(color: Colors.white)),
    );
  }

  Widget _buildBody() => _buildElement();

  Widget _buildElement() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Dimens.padding_xl),
        child: Column(
          children: [
            SizedBox(height: Dimens.padding_xxl),
            _buildImage(),
            SizedBox(height: Dimens.padding_xxl),
            _buildTextField(),
            SizedBox(height: Dimens.padding_xxl),
            _buildButtonRegistration(),
            SizedBox(height: Dimens.padding_normal),
            _buildButtonLogin(),
          ],
        ),
      ),
    );
  }

  Widget _buildImage() => GestureDetector(
        onTap: () async {
          await getImage();
        },
        child: Observer(
          builder: (_) => Container(
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                    color: Theme.of(context).accentColor,
                    width: Dimens.border_VerySmall)),
            child: CircleAvatar(
              backgroundColor: Colors.transparent,
              radius: Dimens.image,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(Dimens.image),
                child: _store.image == null
                    ? Icon(Icons.person, size: 80)
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
      );

  Widget _buildTextField() {
    //todo add all String into language en json
    return Container(
      child: Column(
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
              SizedBox(width: Dimens.padding_normal),
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
          SizedBox(height: Dimens.padding_large),
          Row(
            children: [
              Expanded(
                child: Observer(
                  builder: (_) => LabeledTextField(
                    focusNode: _userNameFocusNode,
                    title: LocaleKeys.regs_text_field_lable_user_name.tr(),
                    textController: _userNameController,
                    hint: LocaleKeys.regs_text_field_lable_user_name.tr(),
                    errorText: _formStore.formErrorStore.userName,
                    onChanged: (name) {
                      _formStore.setUserName(name);

                      _store.userName = name;
                    },
                    onFieldSubmitted: (value) {
                      FocusScope.of(context).requestFocus(_emailFocusNode);
                    },
                  ),
                ),
              ),
              SizedBox(width: Dimens.padding_normal),
              Expanded(
                child: Observer(
                  builder: (_) => LabeledTextField(
                    isIcon: false,
                    title: LocaleKeys.regs_text_field_lable_email.tr(),
                    textController: _emailController,
                    hint: LocaleKeys.regs_text_field_hint_email.tr(),
                    focusNode: _emailFocusNode,
                    errorText: _formStore.formErrorStore.userEmail,
                    onChanged: (email) {
                      _formStore.setUserId(email);
                      _store.email = email;
                    },
                    onFieldSubmitted: (value) {
                      FocusScope.of(context).requestFocus(_passwordFocusNode);
                    },
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: Dimens.padding_large),
          Observer(
            builder: (_) => LabeledTextField(
              focusNode: _passwordFocusNode,
              isObscure: _store.showPassword,
              isIcon: true,
              icon:
                  _store.showPassword ? Icons.visibility_off : Icons.visibility,
              onTap: () {
                _store.showPassword = !_store.showPassword;
              },
              title: LocaleKeys.login_text_field_password_title.tr(),
              textController: _passwordController,
              hint: LocaleKeys.login_text_field_hint_password.tr(),
              errorText: _formStore.formErrorStore.password,
              onChanged: (password) {
                _formStore.setPassword(password);
                _store.password = password;
              },
              onFieldSubmitted: (value) {
                FocusScope.of(context).requestFocus(_confirmPasswordFocusNode);
              },
            ),
          ),
          SizedBox(height: Dimens.padding_large),
          Observer(
            builder: (_) => LabeledTextField(
              focusNode: _confirmPasswordFocusNode,
              isObscure: _store.showConfirmPassword,
              isIcon: true,
              icon: _store.showConfirmPassword
                  ? Icons.visibility_off
                  : Icons.visibility,
              onTap: () {
                _store.showConfirmPassword = !_store.showConfirmPassword;
              },
              title: LocaleKeys.login_text_field_password_title.tr(),
              textController: _confirmPasswordController,
              hint: LocaleKeys.login_text_field_hint_password.tr(),
              errorText: _formStore.formErrorStore.confirmPassword,
              onChanged: (password) {
                _formStore.setConfirmPassword(password);
              },
              onFieldSubmitted: (value) async {
                DeviceUtils.hideKeyboard(context);
                if (_formStore.canRegister) {
                  await _store.signUp().then((value) {
                    Navigator.of(context).pushReplacementNamed(Routes.login);
                  }).catchError((e) {
                    Toast.show(_store.errorStore.errorMessage, context,
                        duration: 3);
                  });
                } else {
                  Toast.show('Please check all fields', context, duration: 2);
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButtonRegistration() {
    return Observer(
      builder: (_) => RoundedButton(
          loading: _store.loading,
          onPressed: () async {
            DeviceUtils.hideKeyboard(context);
            if (_formStore.canRegister) {
              await _store.signUp().then((value) {
                Navigator.of(context).pushReplacementNamed(Routes.login);
              }).catchError((e) {
                Toast.show(_store.errorStore.errorMessage, context,
                    duration: 3);
              });
            } else {
              Toast.show('Please check all fields', context, duration: 2);
            }
          },
          title: LocaleKeys.sign_up.tr()),
    );
  }

  Widget _buildButtonLogin() {
    return MaterialButton(
      onPressed: () {
        Navigator.of(context).pushReplacementNamed(Routes.login);
      },
      child: Center(
        child: Text(
          LocaleKeys.goto_login.tr(),
          style: textTheme.bodyText2?.copyWith(
              color: _themeStore.darkMode ? Colors.white : Colors.black),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/constants/colors.dart';
import 'package:todo_app/constants/dimens.dart';
import 'package:todo_app/store/form/form_store.dart';
import 'package:todo_app/store/language/language_store.dart';
import 'package:todo_app/store/login/login.dart';
import 'package:todo_app/store/theme/theme_store.dart';
import 'package:todo_app/utils/device/device_utils.dart';
import 'package:todo_app/utils/routes/routes.dart';
import 'package:todo_app/utils/todo/todo_utils.dart';
import 'package:todo_app/widgets/arrow_back_icon.dart';
import 'package:todo_app/widgets/labeled_text_field.dart';
import 'package:todo_app/widgets/todo_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:todo_app/generated/locale_keys.g.dart';
import 'package:material_dialog/material_dialog.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _emailController = TextEditingController();

  //stores:---------------------------------------------------------------------
  final _formStore = FormStore();
  late LoginStore _store;
  late ThemeStore _themeStore;
  late LanguageStore _languageStore;

  FocusNode _passwordFocusNode = FocusNode();
  FocusNode _emailFocusNode = FocusNode();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _store = Provider.of<LoginStore>(context);
    _themeStore = Provider.of<ThemeStore>(context);
    _languageStore = Provider.of<LanguageStore>(context);

    _store
      ..userName = _emailController.text = "husseinqq"
      ..password = _passwordController.text = "hussein";
    _store.userName = "husseinqq";
    _store.password = "hussein";
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      if (context.locale == Locale("ar")) {
        _languageStore.setSelectedLanguage(Language.ar);
      } else if (context.locale == Locale("en")) {
        _languageStore.setSelectedLanguage(Language.en);
      }
    });
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
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      leading: ArrowBackIcon(),
      actions: [
        _buildThemeButton(),
        IconButton(
            icon: Icon(Icons.language),
            onPressed: () {
              _buildLanguageDialog();
            }),
      ],
    );
  }

  Widget _buildThemeButton() {
    return Observer(
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
  }

  Widget _buildBody() {
    return Stack(
      children: [
        _buildElement(),
        Align(
          alignment: Alignment.center,
          child: Observer(
            builder: (_) => Visibility(
              visible: _store.loading,
              child: CircularProgressIndicator(),
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
  }

  Widget _buildElement() {
    TextTheme textTheme = Theme.of(context).textTheme;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: Dimens.padding_xl, vertical: Dimens.padding_xxl),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(LocaleKeys.login.tr(),
                style: textTheme.headline4?.copyWith(
                    color: _themeStore.darkMode ? Colors.white : Colors.black)),
            SizedBox(
              height: Dimens.padding_xxl,
            ),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Observer(
                    builder: (_) => LabeledTextField(
                      isIcon: false,
                      onTap: () {
                        _store.showPassword = !_store.showPassword;
                      },
                      title: LocaleKeys.login_text_field_email_title.tr(),
                      textController: _emailController,
                      hint: LocaleKeys.login_text_field_email_title.tr(),
                      errorText: _formStore.formErrorStore.userEmail,
                      onChanged: (email) {
                        _formStore.setUserId(_emailController.text);
                        _store.userName = email;
                      },
                      focusNode: _emailFocusNode,
                      onFieldSubmitted: (value) {
                        FocusScope.of(context).requestFocus(_passwordFocusNode);
                      },
                    ),
                  ),
                  SizedBox(
                    height: Dimens.padding_xxl,
                  ),
                  Observer(
                    builder: (_) => LabeledTextField(
                      isObscure: _store.showPassword,
                      isIcon: true,
                      icon: _store.showPassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                      onTap: () {
                        _store.showPassword = !_store.showPassword;
                      },
                      title: LocaleKeys.login_text_field_password_title.tr(),
                      textController: _passwordController,
                      hint: LocaleKeys.login_text_field_hint_password.tr(),
                      errorText: _formStore.formErrorStore.password,
                      onChanged: (password) {
                        _formStore.setPassword(_passwordController.text);
                        _store.password = password;
                      },
                      focusNode: _passwordFocusNode,
                    ),
                  ),
                  MaterialButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(Routes.email_screen);
                    },
                    child: Container(
                      alignment: Alignment.centerRight,
                      child: Text(
                        LocaleKeys.login_btn_forgot_password.tr(),
                        style: textTheme.bodyText2?.copyWith(
                            color: _themeStore.darkMode
                                ? Colors.white
                                : Colors.black),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: Dimens.padding_xxl,
            ),
            RoundedButton(
                onPressed: () {
                  _store.login();
                  // if (_formStore.canLogin) {
                  //   DeviceUtils.hideKeyboard(context);
                  //   _store.login();
                  // } else {
                  //   showErrorMessage('Please check all fields', context);
                  // }
                },
                title: Text(LocaleKeys.login.tr(),
                    style: Theme.of(context).textTheme.button)),
            SizedBox(
              height: Dimens.padding_normal,
            ),
            MaterialButton(
              onPressed: () {
                Navigator.of(context).pushReplacementNamed(Routes.sign_up);
              },
              child: Center(
                child: Text(
                  LocaleKeys.goto_register.tr(),
                  style: textTheme.bodyText2?.copyWith(
                      color:
                          _themeStore.darkMode ? Colors.white : Colors.black),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _buildClosed() {
    return SizedBox.shrink();
  }

  Widget _navigateToLoginScreen(BuildContext context) {
    Future.delayed(Duration.zero, () {
      Navigator.of(context).pushReplacementNamed(Routes.home);
      _store.loading = false;
    });
    _store.success = false;
    return Container();
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

//toast
// Observer(builder: (_)=>_store.resultForgetPassword.isEmpty?SizedBox(height: 0): _showToast(context)),
// Widget _showToast(BuildContext context) {
//   Future.delayed(Duration.zero, () {
//     showToast(_store.resultForgetPassword['detail'], duration: 4  , gravity: 1 );
//   });
//   return SizedBox.shrink();
// }

//
//   void showToast(String msg, {int? duration, int? gravity}) {
//     Toast.show(msg, context, duration: duration, gravity: gravity);
//   }

  _buildLanguageDialog() {
    showDialogLang<String>(
      context: context,
      child: MaterialDialog(
          borderRadius: Dimens.border_mid,
          enableFullWidth: true,
          title: Text(
            LocaleKeys.home_tv_choose_language.tr(),
            style: Theme.of(context).textTheme.subtitle2,
          ),
          headerColor: Theme.of(context).primaryColor,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          closeButtonColor: Colors.white,
          enableCloseButton: true,
          enableBackButton: false,
          onCloseButtonClicked: () {
            Navigator.of(context).pop();
          },
          children: [
            _buildListTileLang(() {
              Navigator.of(context).pop();
              _languageStore.selectedLanguage = Language.ar;
              context.setLocale(Locale('ar'));
            }, LocaleKeys.arabic.tr()),
            _buildListTileLang(() {
              Navigator.of(context).pop();
              _languageStore.selectedLanguage = Language.en;
              context.setLocale(Locale('en'));
            },  LocaleKeys.english.tr()),
          ]),
    );
  }

  _buildListTileLang(Function onTap, title) {
    return ListTile(
      dense: true,
      contentPadding: EdgeInsets.all(0.0),
      title: Text(title , style: Theme.of(context).textTheme.bodyText2?.copyWith(
        color:  _themeStore.darkMode?Colors.white:Colors.black

      ),),
      onTap: () {
        onTap();
      },
    );
  }
}

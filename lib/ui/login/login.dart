import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/constants/colors.dart';
import 'package:todo_app/constants/dimens.dart';
import 'package:todo_app/packages/toast.dart';
import 'package:todo_app/store/form/form_store.dart';
import 'package:todo_app/store/language/language_store.dart';
import 'package:todo_app/store/login/login.dart';
import 'package:todo_app/store/theme/theme_store.dart';
import 'package:todo_app/utils/device/device_utils.dart';
import 'package:todo_app/utils/locale/app_localization.dart';
import 'package:todo_app/utils/routes/routes.dart';
import 'package:todo_app/utils/todo/todo_utils.dart';
import 'package:todo_app/widgets/arrow_back_icon.dart';
import 'package:todo_app/widgets/labeled_text_field.dart';
import 'package:todo_app/widgets/todo_button.dart';
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



  late AppLocalizations appLocalizations;

  FocusNode _passwordFocusNode = FocusNode();
  FocusNode _emailFocusNode = FocusNode();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _store = Provider.of<LoginStore>(context);
    _themeStore = Provider.of<ThemeStore>(context);
    appLocalizations = AppLocalizations.of(context);
    _languageStore = Provider.of<LanguageStore>(context);

    _store
      ..userName = _emailController.text = "husseinqq"
      ..password = _passwordController.text = "hussein";
    _store.userName = "husseinqq";
    _store.password = "hussein";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: ArrowBackIcon(),
        actions: [_buildThemeButton()],
      ),
      body: _buildBody(),
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

        //todo this is false awy please change this way
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
            Text(appLocalizations.translate("login"),
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
                      title: appLocalizations
                          .translate("login_text_field_email_title"),
                      textController: _emailController,
                      hint: appLocalizations
                          .translate("login_text_field_hint_email"),
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
                      title: appLocalizations
                          .translate("login_text_field_password_title"),
                      textController: _passwordController,
                      hint: appLocalizations
                          .translate("login_text_field_hint_password"),
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
                        appLocalizations.translate("login_btn_forgot_password"),
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
                  if (_formStore.canLogin) {
                    DeviceUtils.hideKeyboard(context);
                    _store.login();
                  } else {
                    showErrorMessage('Please check all fields', context);
                  }
                },
                title: Text(appLocalizations.translate("login"),
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
                  appLocalizations.translate("goto_register"),
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

  void showToast(String msg, {int? duration, int? gravity}) {
    Toast.show(msg, context, duration: duration, gravity: gravity);
  }

  //todo  this function of navigator of screen
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
}

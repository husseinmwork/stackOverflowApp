import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/constants/colors.dart';
import 'package:todo_app/constants/dimens.dart';
import 'package:todo_app/constants/gradient.dart';
import 'package:todo_app/store/form/form_store.dart';
import 'package:todo_app/store/sign_up/sign_up.dart';
import 'package:todo_app/store/theme/theme_store.dart';
import 'package:todo_app/utils/device/device_utils.dart';
import 'package:todo_app/utils/locale/app_localization.dart';
import 'package:todo_app/utils/routes/routes.dart';
import 'package:todo_app/utils/todo/todo_utils.dart';
import 'package:todo_app/widgets/arrow_back_icon.dart';
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

  late SignUpStore _store;
  final _formStore = FormStore();
  late ThemeStore _themeStore;
  late AppLocalizations appLocalizations;
  AnimationController? progressController;
  Animation<double>? animation;

  @override
  void initState() {
    super.initState();
    progressController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 2000));
    animation = Tween<double>(begin: 0, end: 100).animate(progressController!)
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _store = Provider.of<SignUpStore>(context);
    appLocalizations = AppLocalizations.of(context);
    _themeStore = Provider.of<ThemeStore>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: ArrowBackIcon(),
      ),
      body: _buildBody(),
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
        padding: const EdgeInsets.only(
            left: Dimens.padding_xl, right: Dimens.padding_xl),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(appLocalizations.translate("sign_up"),
                style: textTheme.headline4?.copyWith(
                    color: _themeStore.darkMode ? Colors.white : Colors.black)),
            SizedBox(height: Dimens.padding_large),
            _buildTextField(),
            SizedBox(height: Dimens.padding_xl),
            RoundedButton(
                onPressed: () {
                  // progressController!.forward();
                  _store.signUp();
                  // if (_formStore.canRegister) {
                  //   DeviceUtils.hideKeyboard(context);
                  //   _store.signUp();
                  // } else {
                  //   showErrorMessage('Please check all fields', context);
                  // }
                },
                title: Text(appLocalizations.translate("sign_up"),
                    style: Theme.of(context).textTheme.button)),
            SizedBox(
              height: Dimens.padding_normal,
            ),
            MaterialButton(
              onPressed: () {
                Navigator.of(context).pushReplacementNamed(Routes.login);
              },
              child: Center(
                child: Text(
                  appLocalizations.translate("goto_login"),
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
                  title: "first name",
                  textController: _firstNameController,
                  hint: "First Name",
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
                  title: "last name",
                  textController: _lastNameController,
                  hint: "Last Name",
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
                child: LabeledTextField(
                  focusNode: _userNameFocusNode,
                  title: "user name",
                  textController: _userNameController,
                  hint: "User Name",
                  onChanged: (name) {
                    _store.userName = name;
                  },
                  onFieldSubmitted: (value) {
                    FocusScope.of(context).requestFocus(_emailFocusNode);
                  },
                ),
              ),
              SizedBox(width: Dimens.padding_normal),
              Expanded(
                child: Observer(
                  builder: (_) => LabeledTextField(
                    isIcon: false,
                    title: appLocalizations
                        .translate("regs_text_field_lable_email"),
                    textController: _emailController,
                    hint: appLocalizations
                        .translate("regs_text_field_hint_email"),
                    focusNode: _emailFocusNode,
                    errorText: _formStore.formErrorStore.userEmail,
                    onChanged: (email) {
                      // _formStore.setUserId(email);
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
              title:
                  appLocalizations.translate("login_text_field_password_title"),
              textController: _passwordController,
              hint:
                  appLocalizations.translate("login_text_field_hint_password"),
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
              isObscure: _store.showPassword,
              isIcon: true,
              icon:
                  _store.showPassword ? Icons.visibility_off : Icons.visibility,
              onTap: () {
                _store.showPassword = !_store.showPassword;
              },
              title:
                  appLocalizations.translate("regs_text_field_password_title"),
              textController: _confirmPasswordController,
              hint: appLocalizations.translate("regs_text_field_hint_password"),
              errorText: _formStore.formErrorStore.confirmPassword,
              onChanged: (password) {
                _formStore.setConfirmPassword(password);
              },
            ),
          ),
        ],
      ),
    );
  }

  //todo  this function of navigator of screen
  _buildClosed() {
    //todo this error from this from: 0.0 must be set zero into animation in another way
    // if (animation!.value == 100) {
    //   progressController!.reverse();
    // }

    return SizedBox.shrink();
  }

  Widget _navigateToLoginScreen(BuildContext context) {
    Future.delayed(Duration.zero, () {
      Navigator.of(context).pushReplacementNamed(Routes.login);
      _store.loading = false;
    });
    // if (animation!.value == 100) progressController!.reverse(from: 0.0);
    _store.success = false;
    return Container();
  }
}
//
// CustomPaint(
// foregroundPainter: CircleProgress(animation!.value),
// // this will add custom painter after child
// child: Container(
// width: 100,
// height: 100,
// child: GestureDetector(
// onTap: () {},
// child: Center(
// child: Text(
// "${animation!.value.toInt()} %",
// style: TextStyle(
// fontSize: 20,
// fontWeight: FontWeight.bold,
// color: Colors.white),
// ),
// ),
// ),
// ),
// ),

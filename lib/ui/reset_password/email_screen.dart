import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/constants/app_theme.dart';
import 'package:todo_app/constants/colors.dart';
import 'package:todo_app/constants/dimens.dart';
import 'package:todo_app/generated/locale_keys.g.dart';
import 'package:todo_app/packages/polygon_shape.dart';
import 'package:todo_app/store/form/form_store.dart';
import 'package:todo_app/store/reset_password/reset_password.dart';
import 'package:todo_app/store/theme/theme_store.dart';
import 'package:todo_app/ui/reset_password/otp.dart';
import 'package:todo_app/utils/device/device_utils.dart';
import 'package:todo_app/utils/routes/routes.dart';
import 'package:todo_app/utils/todo/todo_utils.dart';
import 'package:todo_app/widgets/labeled_text_field.dart';
import 'package:todo_app/widgets/todo_button.dart';
import 'package:easy_localization/easy_localization.dart';

class EmailScreen extends StatefulWidget {
  @override
  _EmailScreenState createState() => _EmailScreenState();
}

class _EmailScreenState extends State<EmailScreen> {
  TextEditingController _emailController = TextEditingController();
  final _formStore = FormStore();

  late ResetPasswordStore _store;
  late ThemeStore _themeStore;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _store = Provider.of<ResetPasswordStore>(context);
    _themeStore = Provider.of<ThemeStore>(context);
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
        elevation: 0.0,   );

  Widget _buildBody() {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: Dimens.padding_xl),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildTitle(),
              _buildTextField(),
              _buildButton(),
            ],
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: Observer(
            builder: (_) => Visibility(
              visible: _store.loading,
              child: CircularProgressIndicator(
              ),
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

  Widget _buildTitle() {
    return Row(
      children: [
        Text(LocaleKeys.reset_password.tr(),
            style: textTheme.headline4?.copyWith(
                color: _themeStore.darkMode ? Colors.white : Colors.black)),

        // PolygonShape(),
        Expanded(
          child: Transform.translate(
            offset: Offset(90, 0),
            child: Transform.rotate(
              angle: Dimens.padding_normal,
              child: ShapeOfView(
                width: 120,
                height: 120,
                shape: PolygonShape(numberOfSides: 6),
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget _buildTextField() {
    return Container(
      width: double.infinity,
      height: 100,
      child: Observer(
        builder: (_) => LabeledTextField(
          isIcon: false,
          title: LocaleKeys.regs_text_field_lable_email.tr(),
          textController: _emailController,
          hint: LocaleKeys.regs_text_field_lable_email.tr(),
          errorText: _formStore.formErrorStore.userEmail,
          onChanged: (email) {
            _formStore.setUserId(email);
            _store.email = email;
          },
          onFieldSubmitted: (value) {
            // FocusScope.of(context).requestFocus(_passwordFocusNode);
          },
        ),
      ),
    );
  }

  Widget _buildButton() {
    return RoundedButton(
        title: LocaleKeys.reset_password.tr(),
        onPressed: () async {
          DeviceUtils.hideKeyboard(context);
          if (_formStore.canSendEmail) {
            await _store.passwordResetRequest();
            if(_store.errorSendEmail)
              onSaveTaped();

          } else {
            showErrorMessage(
                "please Enter a valid Email", context);
          }
        });
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
      Navigator.of(context).pushReplacementNamed(Routes.otp_screen);
      _store.loading = false;
    });
    _store.success = false;
    return Container();
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/constants/app_theme.dart';
import 'package:todo_app/constants/colors.dart';
import 'package:todo_app/constants/dimens.dart';
import 'package:todo_app/generated/locale_keys.g.dart';
import 'package:todo_app/packages/polygon_shape.dart';
import 'package:todo_app/packages/toast.dart';
import 'package:todo_app/store/form/form_store.dart';
import 'package:todo_app/store/reset_password/reset_password.dart';
import 'package:todo_app/store/theme/theme_store.dart';
import 'package:todo_app/utils/device/device_utils.dart';
import 'package:todo_app/utils/routes/routes.dart';
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
        title: Text(
          "Send Email",
          style: Theme.of(context)
              .textTheme
              .headline6
              ?.copyWith(color: Colors.white),
        ),
      );

  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Dimens.padding_large),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildTitle(),
          _buildTextField(),
          _buildButton(),
        ],
      ),
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
            onFieldSubmitted: (value) async {
              DeviceUtils.hideKeyboard(context);
              if (_formStore.canSendEmail) {
                await _store.passwordResetRequest().then((value) {
                  Navigator.of(context).pushReplacementNamed(Routes.otp_screen);
                }).catchError((e) {
                  Toast.show(_store.errorStore.errorMessage, context,
                      duration: 3);
                });
              } else {
                Toast.show("please Enter a valid Email", context, duration: 2);
              }
            }),
      ),
    );
  }

  Widget _buildButton() {
    return Observer(
      builder: (_) => RoundedButton(
          loading: _store.loading,
          title: LocaleKeys.reset_password.tr(),
          onPressed: () async {
            DeviceUtils.hideKeyboard(context);
            if (_formStore.canSendEmail) {
              await _store.passwordResetRequest().then((value) {
                Navigator.of(context).pushReplacementNamed(Routes.otp_screen);
              }).catchError((e) {
                Toast.show(_store.errorStore.errorMessage, context,
                    duration: 3);
              });
            } else {
              Toast.show("please Enter a valid Email", context, duration: 2);
            }
          }),
    );
  }
}

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/constants/dimens.dart';
import 'package:todo_app/generated/locale_keys.g.dart';
import 'package:todo_app/store/reset_password/reset_password.dart';
import 'package:todo_app/store/theme/theme_store.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:todo_app/widgets/labeled_text_field.dart';
import 'package:todo_app/widgets/todo_button.dart';

class OtpScreen extends StatefulWidget {


  @override
  _OtpScreenState createState() => new _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen>
    with SingleTickerProviderStateMixin {
  // Constants
  final int time = 5;

  TextEditingController _newPasswordController = TextEditingController();

  // Variables
  late Size _screenSize;
  int? _currentDigit;
  int? _firstDigit;
  int? _secondDigit;
  int? _thirdDigit;
  int? _fourthDigit;

  Timer? timer;
  int? totalTimeInSeconds;

  String userName = "";
  bool didReadNotifications = false;
  int unReadNotificationsCount = 0;

  late ThemeStore _themeStore;
  late ResetPasswordStore _store;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _store = Provider.of<ResetPasswordStore>(context);
    _themeStore = Provider.of<ThemeStore>(context);
  }

  // Return "Verification Code" label
  get _getVerificationCodeLabel {
    return Text(LocaleKeys.otp_screen_verification_code.tr(),
        textAlign: TextAlign.center,
        //todo h4 text
        style: Theme.of(context).textTheme.headline6?.copyWith(
            color: _themeStore.darkMode ? Colors.white : Colors.black));
  }

  // Return "Email" label
  get _getEmailLabel {
    return Text(
      LocaleKeys.otp_screen_please_enter_OTP_gmail.tr(),
      textAlign: TextAlign.center,
      style: Theme.of(context)
          .textTheme
          .subtitle2
          ?.copyWith(color: _themeStore.darkMode ? Colors.white : Colors.black),
    );
  }



  // Returns "OTP" input part
  get _getInputPart {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          child: Column(
            children: [
              _getVerificationCodeLabel,
              _getEmailLabel,
            ],
          ),
        ),
        _otpTextField(),
        _buildNewPassword(),
        _buildButton(),
        // _getOtpKeyboard
      ],
    );
  }

  @override
  void dispose() {
    _newPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: Container(
        width: _screenSize.width,
        child: _getInputPart,
      ),
    );
  }

  // Returns "Otp custom text field"
  Widget _otpTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Dimens.padding_xl),
      child: OTPTextField(
        length: 6,
        width: MediaQuery.of(context).size.width,
        fieldWidth: 50,
        style: TextStyle(fontSize: 17, color: Colors.white),
        otpFieldStyle: OtpFieldStyle(
          enabledBorderColor: Colors.white,
          focusBorderColor: Colors.green,
        ),
        textFieldAlignment: MainAxisAlignment.spaceAround,
        fieldStyle: FieldStyle.underline,
        onChanged: (otp) => _store.otp = int.parse(otp),
        onCompleted: (pin) {
          // print("Completed: " + pin);
        },
      ),
    );
  }

  Widget _buildNewPassword() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Dimens.padding_xl),
      child: LabeledTextField(
        textController: _newPasswordController,
        title: "New Password",
        hint: "New Password",
        onChanged: (newPass) {
          _store.newPassword = newPass;
        },
      ),
    );
  }

  Widget _buildButton() {
    return Container(
      margin:
          EdgeInsets.only(bottom: Dimens.padding_xxl, top: Dimens.border_mid),
      padding: EdgeInsets.symmetric(horizontal: Dimens.padding_xl),
      child: RoundedButton(
        onPressed: () {
          _store.sendOtpAndNewPassword();
        },
        title: LocaleKeys.otp_screen_resend_OTP.tr(),

      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/constants/app_theme.dart';
import 'package:todo_app/constants/colors.dart';
import 'package:todo_app/constants/dimens.dart';
import 'package:todo_app/store/form/form_store.dart';
import 'package:todo_app/store/reset_password/reset_password.dart';
import 'package:todo_app/store/theme/theme_store.dart';
import 'package:todo_app/utils/locale/app_localization.dart';
import 'package:todo_app/utils/routes/routes.dart';
import 'package:todo_app/widgets/arrow_back_icon.dart';
import 'package:todo_app/widgets/labeled_text_field.dart';
import 'package:todo_app/widgets/todo_button.dart';

class EmailScreen extends StatefulWidget {
  @override
  _EmailScreenState createState() => _EmailScreenState();
}

class _EmailScreenState extends State<EmailScreen> {
  TextEditingController _emailController = TextEditingController();
  final _formStore = FormStore();

  late AppLocalizations _appLocalizations;
  late ResetPasswordStore _store;
  late ThemeStore _themeStore;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _store = Provider.of<ResetPasswordStore>(context);
    _appLocalizations = AppLocalizations.of(context);
    _themeStore = Provider.of<ThemeStore>(context);
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
    );
  }

  Widget _buildBody() {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Padding(
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
    );
  }

  Widget _buildTitle() {
    return Text(_appLocalizations.translate("reset_password"),
        style: textTheme.headline4?.copyWith(
            color: _themeStore.darkMode ? Colors.white : Colors.black));
  }

  Widget _buildTextField() {
    return Container(
      width: double.infinity,
      height: 100,
      child: Observer(
        builder: (_) => LabeledTextField(
          isIcon: false,
          title: _appLocalizations.translate("regs_text_field_lable_email"),
          textController: _emailController,
          hint: _appLocalizations.translate("regs_text_field_hint_email"),
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
        title: Text(_appLocalizations.translate("reset_password"),
            style: Theme.of(context).textTheme.button),
        onPressed: () async {
          await _store.passwordResetRequest();
          if (_store.success == false && _store.loading == true) {
            onSaveTaped();
          } else {
            Navigator.of(context).pushNamed(Routes.otp);
          }
          // if (_formStore.canForgetPassword) {
          //   _store.passwordResetRequest();
          //
          // } else {
          //   showErrorMessage(
          //       "please Enter a valid Email", context);
          // }
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
}

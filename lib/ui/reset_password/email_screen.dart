import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/constants/colors.dart';
import 'package:todo_app/store/form/form_store.dart';
import 'package:todo_app/store/reset_password/reset_password.dart';
import 'package:todo_app/utils/locale/app_localization.dart';
import 'package:todo_app/utils/routes/routes.dart';
import 'package:todo_app/utils/todo/todo_utils.dart';
import 'package:todo_app/widgets/arrow_back_icon.dart';
import 'package:todo_app/widgets/labeled_text_field.dart';
import 'package:todo_app/widgets/todo_button.dart';
import 'package:todo_app/widgets/todo_outlined_button.dart';

class EmailScreen extends StatefulWidget {
  @override
  _EmailScreenState createState() => _EmailScreenState();
}

class _EmailScreenState extends State<EmailScreen> {
  TextEditingController _emailController = TextEditingController();
  final _formStore = FormStore();

  late AppLocalizations appLocalizations;
  late ResetPasswordStore _store;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _store = Provider.of<ResetPasswordStore>(context);
    appLocalizations = AppLocalizations.of(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: ArrowBackIcon(),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 100,
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  width: double.infinity,
                  height: 100,
                  child: LabeledTextField(
                    isIcon: false,
                    title: "your email",
                    textController: _emailController,
                    hint: "email",
                    onChanged: (email) {
                      _store.email = email;
                    },
                  ),
                ),
              ),
            ],
          ),
          RoundedButton(
              title: Text("reset password"),
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
              })
        ],
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
}

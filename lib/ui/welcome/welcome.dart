import 'package:another_flushbar/flushbar_helper.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/constants/colors.dart';
import 'package:todo_app/constants/dimens.dart';
import 'package:todo_app/constants/gradient.dart';
import 'package:todo_app/packages/polygon_shape.dart';
import 'package:todo_app/packages/welcom_animation.dart';
import 'package:todo_app/store/form/form_store.dart';
import 'package:todo_app/store/welcome/welcome_store.dart';
import 'package:todo_app/utils/locale/app_localization.dart';
import 'package:todo_app/utils/device/device_utils.dart';
import 'package:todo_app/utils/routes/routes.dart';
import 'package:todo_app/widgets/labeled_text_field.dart';
import 'package:todo_app/widgets/todo_button.dart';

///style of this screen
const _titleStyle =
    TextStyle(fontSize: 32, fontWeight: FontWeight.w600, color: Colors.white);

class Welcome extends StatefulWidget {
  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> with SingleTickerProviderStateMixin {
  TextEditingController _emailController = TextEditingController();

  late AppLocalizations appLocalizations;
  //stores:---------------------------------------------------------------------

  late WelcomeStore _store;
  final _formStore = FormStore();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _store = Provider.of<WelcomeStore>(context);
    appLocalizations = AppLocalizations.of(context);
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
              // decoration: BoxDecoration(
              //   gradient: AppGradient.scaffoldGradient,
              // ),
              child: _buildBody()),
          IgnorePointer(
            child: AnimationScreen(color: Theme
                .of(context)
                .accentColor),
          ),
        ],
      ),
    );
  }

  Widget _buildBody() {
    return Padding(
        padding: const EdgeInsets.only(
            left: Dimens.padding_xl, right: Dimens.padding_xl),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildTitle(),
            _buildTextField(),
            _buildButton(),
          ],
        ));
  }

  Widget _buildTitle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          appLocalizations.translate("welcome_title"),
          style: _titleStyle,
        ),
        Transform.translate(
          offset: Offset(90, 0),
          child: Transform.rotate(
            angle: 11,
            child: ShapeOfView(
              shape: PolygonShape(
                numberOfSides: 6,
              ),
              child: Container(
                height: 100,
                width: 100,
                color: AppColors.shapeColor,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTextField() {
    return Observer(
      builder:(_)=> LabeledTextField(
        isIcon: true,
        icon: Icons.clear,
        onTap: () {
          _emailController.text = '';
        },
        title: appLocalizations.translate("welcome_text_field_title"),
        textController: _emailController,
        hint: appLocalizations.translate("welcome_text_field_hint"),
        onChanged: (name) {
          // _store.firstName = name;
          _formStore.setUserId(_emailController.text);
        },
        errorText: _store.formErrorStore.userEmail,

      ),
    );
  }

  Widget _buildButton() {
    return Row(
      children: [
        Expanded(
          child: RoundedButton(
              onPressed: () {
                Navigator.of(context)
                    .pushNamed(Routes.login, arguments: _emailController.text);
              },
              title:Text( appLocalizations.translate("login"),style: Theme.of(context).textTheme.button)),
        ),
        SizedBox(width: Dimens.padding_normal),
        Expanded(
          child: RoundedButton(
              onPressed: () {
                // if (_formStore.canLogin) {
                //   DeviceUtils.hideKeyboard(context);
                  Navigator.of(context).pushNamed(Routes.sign_up,
                      arguments: _emailController.text);
                // } else {
                //   _showErrorMessage('Please fill in all fields');
                // }
              },
              title:Text( appLocalizations.translate("login"),style: Theme.of(context).textTheme.button)),
        ),
      ],
    );
  }


  // General Methods:-----------------------------------------------------------
  _showErrorMessage(String message) {
    if (message.isNotEmpty) {
      Future.delayed(Duration(milliseconds: 0), () {
        if (message.isNotEmpty) {
          FlushbarHelper.createError(
            message: message,
            title: AppLocalizations.of(context).translate('home_tv_error'),
            duration: Duration(seconds: 3),
          )
            ..show(context);
        }
      });
    }
  }
}

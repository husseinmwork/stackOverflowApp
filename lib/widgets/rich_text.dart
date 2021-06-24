import 'package:flutter/material.dart';
import 'package:todo_app/utils/locale/app_localization.dart';

const _boldStyle =
    TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold);

const _normalStyle = TextStyle(
    color: Color(0xFF5E6272), fontSize: 13, fontWeight: FontWeight.normal);

class TodoRichText extends StatefulWidget {
  final String? email;

  const TodoRichText({this.email});

  @override
  _TodoRichTextState createState() => _TodoRichTextState();
}

class _TodoRichTextState extends State<TodoRichText> {
  late AppLocalizations appLocalizations;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    appLocalizations = AppLocalizations.of(context);
  }

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(children: [
        TextSpan(
          text: appLocalizations.translate("using"),
          style: _normalStyle,
        ),
        //todo show the email in this
        TextSpan(
          // recognizer: TapGestureRecognizer()
          //   ..onTap = () {
          //     print('Terms and Conditions Single Tap');
          //   },
          text: "${widget.email}",
          style: _boldStyle,
        ),
        TextSpan(
          text: appLocalizations.translate("to_login"),
          style: _normalStyle,
        ),
      ]),
    );
  }
}

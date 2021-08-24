import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/constants/colors.dart';
import 'package:todo_app/constants/dimens.dart';
import 'package:todo_app/store/theme/theme_store.dart';

class RoundedButton extends StatefulWidget {
  final Function onPressed;
  final String title;

  final bool? loading;

  const RoundedButton(
      {required this.onPressed, required this.title, this.loading});

  @override
  _RoundedButtonState createState() => _RoundedButtonState();
}

class _RoundedButtonState extends State<RoundedButton> {
  late ThemeStore _themeStore;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _themeStore = Provider.of<ThemeStore>(context);
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
          minimumSize: Size(double.infinity, 48),
          primary: Colors.white,
          backgroundColor: Theme.of(context).accentColor),
      onPressed: () {
        widget.onPressed();
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            widget.title.toUpperCase(),
            style: Theme.of(context).textTheme.button?.copyWith(
                color: _themeStore.darkMode ? Colors.black : Colors.white),
          ),
          widget.loading == true
              ? SizedBox(
                  width: Dimens.padding_small,
                )
              : SizedBox.shrink(),
          Visibility(
            visible: widget.loading == true,
            child: SizedBox(
                height: 28,
                width: 28,
                child: CircularProgressIndicator(
                    backgroundColor:
                        _themeStore.darkMode ? Colors.black : Colors.white)),
          )
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/constants/colors.dart';
import 'package:todo_app/constants/dimens.dart';
import 'package:todo_app/store/theme/theme_store.dart';

class LabeledTextField extends StatefulWidget {
  final String? hint;
  final bool isObscure;
  final TextInputType? inputType;
  final TextEditingController textController;
  final EdgeInsets padding;
  final bool isNumber;
  final Color hintColor;
  final FocusNode? focusNode;
  final ValueChanged? onFieldSubmitted;
  final ValueChanged? onChanged;
  final bool isIcon;
  final bool autoFocus;
  final IconData? icon;
  final String? maxLetter;
  final String? errorText;
  final TextInputAction? inputAction;
  final String title;
  final Function? onTap;

  LabeledTextField({
    Key? key,
    this.maxLetter,
    this.errorText,
    required this.textController,
    this.isNumber = false,
    this.inputType,
    this.isIcon = false,
    this.onTap,
    this.hint,
    this.icon,
    this.isObscure = false,
    required this.title,
    this.padding = const EdgeInsets.all(0),
    this.hintColor = Colors.grey,
    this.focusNode,
    this.onFieldSubmitted,
    this.onChanged,
    this.autoFocus = false,
    this.inputAction,
  }) : super(key: key);

  @override
  _LabeledTextFieldState createState() => _LabeledTextFieldState();
}

class _LabeledTextFieldState extends State<LabeledTextField> {
  late ThemeStore _themeStore;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _themeStore = Provider.of<ThemeStore>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title.toUpperCase(),
          style: Theme.of(context).textTheme.overline,
        ),
        TextFormField(
          textAlign: TextAlign.start,
          controller: widget.textController,
          focusNode: widget.focusNode,
          onFieldSubmitted: widget.onFieldSubmitted,
          onChanged: widget.onChanged,
          autofocus: widget.autoFocus,
          textInputAction: widget.inputAction,
          obscureText: this.widget.isObscure,
          inputFormatters: [
            if (widget.isNumber)
              FilteringTextInputFormatter.allow(RegExp("[0-9]"))
          ],
          keyboardType: this.widget.inputType,
          style: Theme.of(context).textTheme.subtitle2?.copyWith(
              color: _themeStore.darkMode ? Colors.white : Colors.black),
          decoration: InputDecoration(
            hintText: this.widget.hint,
            errorText: widget.errorText,
            counter: widget.maxLetter == null
                ? null
                : Text(
                    widget.maxLetter!,
                    style: Theme.of(context).textTheme.caption,
                  ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF262A34)),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                  color: _themeStore.darkMode
                      ? Colors.amber[500]!
                      : AppColors.DarkPurple),
            ),
            hintStyle: Theme.of(context).textTheme.subtitle2?.copyWith(
                color: _themeStore.darkMode ? Colors.white : Colors.black ),
            suffixIcon: IconButton(
              onPressed: widget.isIcon
                  ? () {
                      widget.onTap!();
                    }
                  : null,
              icon: widget.isIcon
                  ? Container(
                      padding: EdgeInsets.all(Dimens.padding_mini),
                      decoration: BoxDecoration(
                          color: Color(0xFF262A34),
                          borderRadius:
                              BorderRadius.circular(Dimens.borderMax)),
                      child: Icon(
                        widget.icon,
                        color: _themeStore.darkMode
                            ? Color(0xFF5E6272)
                            : Colors.white,
                        size: 20,
                      ),
                    )
                  : SizedBox.shrink(),
            ),
            counterText: '',
          ),
        ),
      ],
    );
  }
}

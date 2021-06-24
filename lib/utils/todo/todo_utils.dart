import 'package:another_flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/constants/strings.dart';
import 'package:todo_app/utils/locale/app_localization.dart';

///validation method
// General Methods:-----------------------------------------------------------
showErrorMessage(String message , BuildContext context) {
  if (message.isNotEmpty) {
    Future.delayed(Duration(milliseconds: 0), () {
      if (message.isNotEmpty) {
        FlushbarHelper.createError(
          message: message,
          title: AppLocalizations.of(context).translate('home_tv_error'),
          duration: Duration(seconds: 3),
        )..show(context);
      }
    });
  }
  return SizedBox.shrink();
}

/// date pattern
const String baseDP = "yyyy-MM-dd";
extension date on DateTime {
   changeFormat({String pattern = Strings.baseDP}) {
    final DateFormat formatter = DateFormat(pattern);
    final String formatted = formatter.format(this);
    return formatted;
  }
}

extension mapper on Map<String, dynamic?> {
  /// this delete if value is null
  Map<String, dynamic> removeNull() {
    this.removeWhere((key, value) => value == null);
    return this;
  }

  valueAt(int index) {

    debugPrint("this.values.elementAt(index)");
    debugPrint(this.values.toString());
    return this.values.elementAt(index);
  }

  keyAt(int index) => this.keys.elementAt(index);
}
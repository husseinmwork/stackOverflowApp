import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:material_dialog/material_dialog.dart';
import 'package:todo_app/constants/dimens.dart';
import 'package:todo_app/constants/strings.dart';

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

showDialogLang<T>({required BuildContext context, required Widget child}) {
  showDialog<T>(
    context: context,
    builder: (BuildContext context) => child,
  ).then<void>((T? value) {
    // The value passed to Navigator.pop() or null.
  });
}

buildDeleteDialog({
  required BuildContext context,
  required Function close,
  required Function delete,
  required String content,
  required String title,
}) {
  showGeneralDialog(
      barrierColor: Colors.black.withOpacity(0.5),
      transitionBuilder: (context, a1, a2, widget) {
        final curvedValue = Curves.easeInOutBack.transform(a1.value) - 1.0;
        return Transform(
          transform: Matrix4.translationValues(0.0, curvedValue * 200, 0.0),
          child: Opacity(
            opacity: a1.value,
            child: MaterialDialog(
              actions: [
                ElevatedButton(
                  onPressed: () {
                    close();
                  },
                  child: Text(
                    "CANCEL",
                    style: Theme.of(context).textTheme.button?.copyWith(
                          color: Colors.white,
                        ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    delete();
                  },
                  child: Text(
                    "OK",
                    style: Theme.of(context)
                        .textTheme
                        .button
                        ?.copyWith(color: Colors.white),
                  ),
                ),
              ],
              content: Text(
                content,
                style: Theme.of(context).textTheme.subtitle2,
              ),
              borderRadius: Dimens.border_mid,
              enableFullWidth: true,
              title: Text(
                title,
                style: Theme.of(context)
                    .textTheme
                    .subtitle1
                    ?.copyWith(color: Colors.white),
              ),
              headerColor: Theme.of(context).primaryColor,
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              enableCloseButton: false,
              enableBackButton: false,
            ),
          ),
        );
      },
      transitionDuration: Duration(milliseconds: 400),
      barrierDismissible: true,
      barrierLabel: '',
      context: context,
      pageBuilder: (context, animation1, animation2) {
        return Text("");
      });
}

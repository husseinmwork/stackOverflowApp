import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/constants/dimens.dart';
import 'package:todo_app/widgets/outlined_button.dart';
import 'package:todo_app/widgets/todo_button.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
    );
  }

  Widget _buildBody() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            RichText(
              text: TextSpan(children: [
                TextSpan(
                  text: "Stack",
                  style: Theme.of(context).textTheme.headline4,
                ),
                TextSpan(
                  text: "overflow",
                  style: Theme.of(context).textTheme.headline4?.copyWith(
                      color: /*_themeStore.darkMode? AppColors.lightPurple:*/ Colors
                          .amber),
                ),
              ]),
            ),
            Column(
              children: [
                Text(
                  "Welcome!",
                  style: Theme.of(context).textTheme.headline5,
                ),
                SizedBox(height: Dimens.padding_xxl),
                RoundedButton(
                    onPressed: () {},
                    title: Text("Sign In",
                        style: Theme.of(context).textTheme.subtitle1)),
                SizedBox(height: Dimens.padding_large),
                OutlinedButtonS(
                  onPressed: () {},
                  title: Text("Sign Up",
                      style: Theme.of(context)
                          .textTheme
                          .subtitle1
                          ?.copyWith(color: Colors.amber)),
                ),
                SizedBox(height: Dimens.padding_xxl),
                RichText(
                  text: TextSpan(children: [
                    TextSpan(
                      text: "Language ",
                      style: Theme.of(context)
                          .textTheme
                          .headline6
                          ?.copyWith(fontWeight: FontWeight.w400),
                    ),
                    TextSpan(
                        text: "English",
                        style: Theme.of(context).textTheme.headline6),
                  ]),
                ),
              ],
            )
          ],
        ),
      );
}

import 'package:flutter/material.dart';
import 'package:todo_app/constants/assets.dart';
import 'package:todo_app/constants/dimens.dart';

class UserImageAvatar extends StatelessWidget {
  final String image;
  final double? width;
  final double? height;
  final Function onTap;

  UserImageAvatar(
      {required this.image, this.width, this.height, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap.call();
      },
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.amber),
        ),
        child: CircleAvatar(
          radius: Dimens.cardQuestionImage,
          child: ClipOval(
            child: FadeInImage.assetNetwork(
              fit: BoxFit.cover,
              placeholder: Assets.placeHolder,
              height: double.infinity,
              width: double.infinity,
              image: image,
              imageErrorBuilder: (_, __, ___) {
                return Image.asset(Assets.placeHolder, fit: BoxFit.cover);
              },
            ),
          ),
        ),
      ),
    );
  }
}

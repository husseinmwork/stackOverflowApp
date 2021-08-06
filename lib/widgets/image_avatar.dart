// import 'package:flutter/material.dart';
// import 'package:todo_app/constants/assets.dart';
// import 'package:todo_app/constants/dimens.dart';
//
// class ImageAvatar extends StatelessWidget {
//   final Function onTap;
//   final String image;
//   final double radius;
//   final double borderRadius;
//
//   ImageAvatar({required this.onTap , required this.image , required this.radius , this.borderRadius =Dimens.border_image });
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         onTap();
//       },
//       child: CircleAvatar(
//         radius: radius,
//         backgroundColor: Colors.red,
//         child: ClipRRect(
//           borderRadius: BorderRadius.circular(borderRadius),
//           child: FadeInImage.assetNetwork(
//             fit: BoxFit.cover,
//             placeholder: Assets.placeHolder,
//             width: 50,
//             height: 60,
//             //todo get image from api
//             image:image,
//             imageErrorBuilder: (_, __, ___) {
//               return Image.asset(Assets.placeHolder);
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }

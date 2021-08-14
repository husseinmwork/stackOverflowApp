import 'package:flutter/material.dart';
import 'package:todo_app/constants/strings.dart';

class StackOverFlowLike extends StatelessWidget {
  final String? hsVoted;
  final Function like;
  final Function desLike;

  const StackOverFlowLike(
      {required this.like, required this.desLike, required this.hsVoted});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          _buildLike(),
          _buildNumLikeAndDisLike(),
          _buildDisLike(),
        ],
      ),
    );
  }

  Widget _buildLike() => IconButton(
      icon: (hsVoted != null && hsVoted == Strings.like)
          ? Icon(Icons.thumb_up)
          : Icon(Icons.thumb_up_alt_outlined, color: Colors.white),
      onPressed: () {
        like();
      });

  Widget _buildNumLikeAndDisLike() => Text("4");

  Widget _buildDisLike() => IconButton(
      icon: (hsVoted != null && hsVoted == Strings.desLike)
          ? Icon(Icons.thumb_down)
          : Icon(Icons.thumb_down_alt_outlined),
      onPressed: () {
        desLike();
      });
}
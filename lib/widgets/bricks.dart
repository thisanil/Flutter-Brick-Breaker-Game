import 'package:brick_breaker1/utils/colors.dart';
import 'package:flutter/material.dart';

class MyBrick extends StatelessWidget {
  final brickX;
  final brickY;
  final brickWidth;
  final brickHeight;
  final brickBroken;
  const MyBrick(
      {super.key,
      required this.brickX,
      required this.brickY,
      required this.brickWidth,
      required this.brickHeight,
      required this.brickBroken});

  @override
  Widget build(BuildContext context) {
    return brickBroken?Container(): Container(
      alignment: Alignment(brickX, brickY),
      height: MediaQuery.of(context).size.height * brickHeight / 2,
      width: MediaQuery.of(context).size.width * brickWidth / 2,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: AppColors.scondryColor),
    );
  }
}

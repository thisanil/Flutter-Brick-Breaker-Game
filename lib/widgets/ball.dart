
import 'package:flutter/material.dart';

import '../utils/colors.dart';

class MyBall extends StatelessWidget {
  final double ballx;
  final double bally;
  const MyBall({super.key, required this.ballx, required this.bally});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment(ballx, bally),
      child: Container(
        height: 15,
        width: 15,
        decoration: BoxDecoration(
            color: AppColors.scondryColor, shape: BoxShape.circle),
      ),
    );
  }
}

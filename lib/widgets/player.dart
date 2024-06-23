import 'package:brick_breaker1/utils/colors.dart';
import 'package:flutter/material.dart';

class MyPlayer extends StatelessWidget {
  final double playerX;
  final playerWidth;
  const MyPlayer({super.key, required this.playerX, this.playerWidth});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment((2*playerX+playerWidth)/(2-playerWidth),0.9),
      child: Container(
        height: 10,
        width: MediaQuery.of(context).size.width*playerWidth/1.5,
        decoration: BoxDecoration(
          color: AppColors.scondryColor,
          borderRadius: BorderRadius.circular(15)
        ),
        
      ),
    );
  }
}

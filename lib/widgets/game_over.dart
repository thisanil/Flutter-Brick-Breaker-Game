import 'package:brick_breaker1/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class GameOver extends StatelessWidget {
  final bool isGameOver;
  const GameOver({super.key, required this.isGameOver});

  @override
  Widget build(BuildContext context) {
    return isGameOver
        ? Container(
            alignment: const Alignment(0, -0.3),
            child: Text("G A M E   O V E R", style: TextStyle(color: AppColors.deepPurple400Color,fontSize: 20,fontWeight: FontWeight.w600,height: 1.6),),
          )
        : Container();
  }
}

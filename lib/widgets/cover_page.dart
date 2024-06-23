import 'package:brick_breaker1/utils/colors.dart';
import 'package:flutter/material.dart';

class CoverScreen extends StatelessWidget {
  final bool hasGameStarted;
  const CoverScreen({super.key, required this.hasGameStarted});

  @override
  Widget build(BuildContext context) {
    return hasGameStarted
        ? Container()
        : Container(
            alignment: const Alignment(0, -0.1),
            child: Text(
              "Tap to Play",
              style: TextStyle(color: AppColors.deepPurple400Color,fontSize: 20,fontWeight: FontWeight.w600,height: 1.6),
            ),
          );
  }
}

import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BrickBreakGame extends StatefulWidget {
  @override
  _BrickBreakGameState createState() => _BrickBreakGameState();
}

class _BrickBreakGameState extends State<BrickBreakGame> with SingleTickerProviderStateMixin {
  double ballX = 0;
  double ballY = 0;
  double ballVelocityX = 1;
  double ballVelocityY = 1;
  double paddleX = 0;
  final double paddleWidth = 0.2;
  final double paddleHeight = 0.05;
  List<Brick> bricks = [];
  Timer? gameTimer;

  @override
  void initState() {
    super.initState();
    _initializeBricks();
    gameTimer = Timer.periodic(Duration(milliseconds: 16), _updateGame);
  }

  @override
  void dispose() {
    gameTimer?.cancel();
    super.dispose();
  }

  void _initializeBricks() {
    for (double i = -1; i < 1; i += 0.3) {
      for (double j = -0.5; j < 0; j += 0.1) {
        bricks.add(Brick(brickX: i, brickY: j));
      }
    }
  }

  void _updateGame(Timer timer) {
    setState(() {
      ballX += ballVelocityX * 0.01;
      ballY += ballVelocityY * 0.01;

      // Ball collision with walls
      if (ballX <= -1 || ballX >= 1) ballVelocityX = -ballVelocityX;
      if (ballY <= -1) ballVelocityY = -ballVelocityY;

      // Ball collision with paddle
      if (ballY >= 1 - paddleHeight &&
          ballX >= paddleX - paddleWidth / 2 &&
          ballX <= paddleX + paddleWidth / 2) {
        ballVelocityY = -ballVelocityY;
      }

      // Ball collision with bricks
      for (var brick in bricks) {
        if (!brick.brickBroken &&
            ballX >= brick.brickX &&
            ballX <= brick.brickX + 0.2 &&
            ballY >= brick.brickY &&
            ballY <= brick.brickY + 0.1) {
          brick.brickBroken = true;
          ballVelocityY = -ballVelocityY;
          break;
        }
      }

      // Ball falls off the screen
      if (ballY >= 1) {
        ballX = 0;
        ballY = 0;
        ballVelocityX = 1;
        ballVelocityY = 1;
      }
    });
  }

  void _onHorizontalDragUpdate(DragUpdateDetails details) {
    setState(() {
      paddleX += details.primaryDelta! / MediaQuery.of(context).size.width * 2;
      paddleX = max(-1 + paddleWidth / 2, min(1 - paddleWidth / 2, paddleX));
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragUpdate: _onHorizontalDragUpdate,
      child: Stack(
        children: [
          // Ball
          Positioned(
            left: (ballX + 1) / 2 * MediaQuery.of(context).size.width,
            top: (ballY + 1) / 2 * MediaQuery.of(context).size.height,
            child: Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
            ),
          ),
          // Paddle
          Positioned(
            left: (paddleX + 1) / 2 * MediaQuery.of(context).size.width -
                (paddleWidth / 2) * MediaQuery.of(context).size.width,
            bottom: 0,
            child: Container(
              width: paddleWidth * MediaQuery.of(context).size.width,
              height: paddleHeight * MediaQuery.of(context).size.height,
              color: Colors.blue,
            ),
          ),
          // Bricks
          for (var brick in bricks)
            if (!brick.brickBroken)
              Positioned(
                left: (brick.brickX + 1) / 2 * MediaQuery.of(context).size.width,
                top: (brick.brickY + 1) / 2 * MediaQuery.of(context).size.height,
                child: Container(
                  width: 0.2 * MediaQuery.of(context).size.width,
                  height: 0.1 * MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
        ],
      ),
    );
  }
}

class Brick {
  final double brickX;
  final double brickY;
  bool brickBroken;

  Brick({
    required this.brickX,
    required this.brickY,
    this.brickBroken = false,
  });
}
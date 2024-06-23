import 'dart:async';

import 'package:brick_breaker1/widgets/ball.dart';
import 'package:brick_breaker1/widgets/bricks.dart';
import 'package:brick_breaker1/widgets/cover_page.dart';
import 'package:brick_breaker1/utils/colors.dart';
import 'package:brick_breaker1/widgets/game_over.dart';
import 'package:brick_breaker1/widgets/player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

enum direction { UP, DOWN ,LEFT,RIGHT}

class _HomePageState extends State<HomePage> {
  double ballx = 0;
  double bally = 0;
  double ballxIncrements = 0.01;
  double ballyIncrements = 0.01;
  double playerX = -0.2;
  var ballYDirection = direction.DOWN;
  var ballXDirection = direction.LEFT;
  double playerWidth = 0.4; //out of 2
  bool hasGameStarted = false;
  bool brickBroken = false;

  bool isGameOver = false;

  // brick veriable
  static double firstbrickX = -0.5;
  static double firstbrickY = -0.9;
  static double brickGap=0.2;
  static double brickWidth = 0.4; //out of 2
  static double brickHeight = 0.05; //out of 2
  List Mybricks=[
    [firstbrickX,firstbrickY,false],
    [firstbrickX+brickWidth+brickGap,firstbrickY,false],
  ];
  void startGame() {
    hasGameStarted = true;
    Timer.periodic(Duration(milliseconds: 10), (timer) {
      updateDiraction();
      moveBall();
      if (isPlayerDead()) {
        timer.cancel();
        isGameOver = true;
      }
      checkForBricksBroken();
    });
  }

  void checkForBricksBroken() {
    if (ballx >= Mybricks[0][0] &&
        ballx <= Mybricks[0][0] + brickWidth &&
        bally >= Mybricks[0][1]+brickHeight &&
        brickBroken==false
        ) {
     setState(() {
        brickBroken = true;
        ballYDirection = direction.DOWN;
     });
    }
  }

  bool isPlayerDead() {
    if (bally >= 1) {
      return true;
    }
    return false;
  }

  void moveBall() {
    setState(() {
      if (ballXDirection == direction.LEFT) {
        ballx -= ballxIncrements;
      } else if (ballXDirection == direction.RIGHT) {
        ballx += ballxIncrements;
      }

      if (ballYDirection == direction.DOWN) {
        bally += ballyIncrements;
      } else if (ballYDirection == direction.UP) {
        bally -= ballyIncrements;
      }
    });
  }

  void updateDiraction() {
    setState(() {
      if (bally >= 0.9 && ballx >= playerX && ballx <= playerX + playerWidth) {
        ballYDirection = direction.UP;
      } else if (bally <= -1) {
        ballYDirection = direction.DOWN;
      }

      if(ballx>=1)
        {
          ballXDirection=direction.LEFT;
        }
      else if(ballx<=-1){
        ballXDirection=direction.RIGHT;
      }

    });
  }

  // move player left
  void moveLeft() {
    if (!(playerX - 0.2 <= -1.2)) {
      setState(() {
        playerX -= 0.2;
      });
    }
  }

  //move player Right
  void moveRight() {
    if (!(playerX + 0.2 >= 1.2)) {
      setState(() {
        playerX += 0.2;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
      focusNode: FocusNode(),
      autofocus: true,
      onKey: (event) {
        if (event.isKeyPressed(LogicalKeyboardKey.arrowLeft)) {
          moveLeft();
        } else if (event.isKeyPressed(LogicalKeyboardKey.arrowRight)) {
          moveRight();
        }
      },
      child: GestureDetector(
        onTap: startGame,
        child: Scaffold(
          backgroundColor: AppColors.primaryColor,
          body: Center(
            child: Stack(
              children: [
                //Tap to play

                MyBrick(brickX: Mybricks[0][0], brickY: Mybricks[0][1], brickWidth: brickWidth, brickHeight: brickHeight, brickBroken: brickBroken),
                CoverScreen(hasGameStarted: hasGameStarted),
                //game Over
                GameOver(isGameOver: isGameOver),
                //Ball
                MyBall(ballx: ballx, bally: bally),
                //Player
                MyPlayer(
                  playerX: playerX,
                  playerWidth: playerWidth,
                ),
                MyBrick(brickX: Mybricks[1][0], brickY: Mybricks[1][1], brickWidth: brickWidth, brickHeight: brickHeight, brickBroken: brickBroken),

              ],
            ),
          ),
        ),
      ),
    );
  }
}

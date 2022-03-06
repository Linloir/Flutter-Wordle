/*
 * @Author       : Linloir
 * @Date         : 2022-03-05 20:56:05
 * @LastEditTime : 2022-03-06 12:14:57
 * @Description  : The display widget of the wordle game
 */

import 'package:flutter/material.dart';
import 'package:wordle/validation_provider.dart';
import './input_pannel.dart';
import './event_bus.dart';
import 'dart:math' as math;

class WordleDisplayWidget extends StatefulWidget {
  const WordleDisplayWidget({Key? key}) : super(key: key);

  @override
  State<WordleDisplayWidget> createState() => _WordleDisplayWidgetState();
}

class _WordleDisplayWidgetState extends State<WordleDisplayWidget> with TickerProviderStateMixin{
  int r = 0;
  int c = 0;
  bool onAnimation = false;
  late final List<List<Map<String, dynamic>>> inputs;

  void _validationAnimation(List<int> validation) async {
    onAnimation = true;
    for(int i = 0; i < 5; i++) {
      setState((){
        inputs[r][i]["State"] = validation[i];
        print('Set $r, $i to state ${validation[i]}');
      });
      await Future.delayed(const Duration(seconds: 1));
    }
    onAnimation = false;
    r++;
    c = 0;
  }

  @override
  void initState() {
    super.initState();
    inputs = [
      for(int i = 0; i < 6; i++)
        [
          for(int j = 0; j < 5; j++)
            {
              "Letter": "",
              "State": 0,
              "InputAnimationController": AnimationController(
                duration: const Duration(milliseconds: 50), 
                reverseDuration: const Duration(milliseconds: 100),
                vsync: this
              ),
            }
        ]
    ];
    mainBus.onBus(
      event: "Attempt",
      onEvent: (args) {
        print('Heard');
        List<int> validation = args;
        print(validation);
        _validationAnimation(validation);
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<InputNotification>(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          for(int i = 0; i < 6; i++)
            Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for(int j = 0; j < 5; j++)
                    AnimatedBuilder(
                      animation: inputs[i][j]["InputAnimationController"],
                      builder: (context, child) {
                        return Transform.scale(
                          scale: Tween<double>(begin: 1, end: 1.1).evaluate(inputs[i][j]["InputAnimationController"]),
                          child: child,
                        );
                      },
                      child: AspectRatio(
                        aspectRatio: 1,
                        child: LayoutBuilder(
                            builder: (context, constraints) {
                              return AnimatedSwitcher(
                                duration: const Duration(milliseconds: 750),
                                switchInCurve: Curves.easeOut,
                                reverseDuration: const Duration(milliseconds: 10),
                                transitionBuilder: (child, animation) {
                                  return AnimatedBuilder(
                                    animation: animation,
                                    child: child,
                                    builder: (context, child) {
                                      var _animation = Tween<double>(begin: math.pi / 2, end: 0).animate(animation);
                                      // return ConstrainedBox(
                                      //   constraints: BoxConstraints.tightFor(height: constraints.maxHeight * _animation.value),
                                      //   child: child,
                                      // );
                                      return Transform(
                                        transform: Matrix4.rotationX(_animation.value),
                                        alignment: Alignment.center,
                                        child: child,
                                      );
                                    }
                                  );
                                },
                                child: Padding(
                                  key: ValueKey((inputs[i][j]["State"] == 0 || inputs[i][j]["State"] == 3) ? 0 : 1),
                                  padding: const EdgeInsets.all(5.0),
                                  child: DecoratedBox(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: inputs[i][j]["State"] == 1 ? Colors.green[600]! :
                                             inputs[i][j]["State"] == 2 ? Colors.yellow[800]! : 
                                             inputs[i][j]["State"] == 3 ? Colors.grey[850]! :
                                             inputs[i][j]["State"] == -1 ? Colors.grey[700]! :
                                             Colors.grey[400]!,
                                        width: 3.0,
                                      ),
                                      color: inputs[i][j]["State"] == 1 ? Colors.green[600]! :
                                             inputs[i][j]["State"] == 2 ? Colors.yellow[800]! : 
                                             inputs[i][j]["State"] == -1 ? Colors.grey[700]! :
                                             Colors.white,
                                    ),
                                    child: Center(
                                      child: Text(
                                        inputs[i][j]["Letter"],
                                        style: TextStyle(
                                          color: inputs[i][j]["State"] == 3 ? Colors.grey[850]! : Colors.white,
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          
                        ),
                      )
                      
                    ),
                ],
              ),
            ),
          InputPannelWidget(),
        ],
      ),
      onNotification: (noti) {
        print('Get');
        if(noti.type == InputType.singleCharacter) {
          if(r < 6 && c < 5 && !onAnimation) {
            setState((){
              inputs[r][c]["Letter"] = noti.msg;
              inputs[r][c]["State"] = 3;
              var controller = inputs[r][c]["InputAnimationController"] as AnimationController;
              controller.forward().then((value) => controller.reverse());
              c++;
            });
          }
        }
        return false;
      },
    );
  }
}

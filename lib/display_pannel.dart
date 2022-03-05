/*
 * @Author       : Linloir
 * @Date         : 2022-03-05 20:56:05
 * @LastEditTime : 2022-03-05 23:51:16
 * @Description  : The display widget of the wordle game
 */

import 'package:flutter/material.dart';
import 'package:wordle/validation_provider.dart';
import './event_bus.dart';

class WordleDisplayWidget extends StatefulWidget {
  const WordleDisplayWidget({Key? key}) : super(key: key);

  @override
  State<WordleDisplayWidget> createState() => _WordleDisplayWidgetState();
}

class _WordleDisplayWidgetState extends State<WordleDisplayWidget> {
  int r = 0;
  int c = 0;
  var inputs = <List<String>>[for(int i = 0; i < 6; i++) [for(int j = 0; j < 5; j++) "A"]];

  @override
  void initState() {
    super.initState();
    mainBus.onBus(
      event: "Attempt",
      onEvent: (args) {

      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<InputNotification>(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          for(int r = 0; r < 6; r++)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for(int c = 0; c < 5; c++)
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Container(
                      constraints: const BoxConstraints.tightFor(width: 100.0, height: 100.0),
                      child: Center(
                        child: Text(
                          inputs[r][c],
                          style: TextStyle(
                            fontSize: 50.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey[600]!,
                          width: 3.0,
                        )
                      ),
                    ),
                  )
              ],
            )
        ],
      ),
      onNotification: (noti) {
        if(noti.type == InputType.singleCharacter) {
          if(r <= 6 && c <= 5) {
            setState((){
              inputs[r].add(noti.msg);
            });
          }
        }
        return true;
      },
    );
  }
}

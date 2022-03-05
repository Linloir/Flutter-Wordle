/*
 * @Author       : Linloir
 * @Date         : 2022-03-05 21:40:51
 * @LastEditTime : 2022-03-05 23:06:28
 * @Description  : Validation Provider class
 */

import 'package:flutter/material.dart';
import './event_bus.dart';

enum InputType { singleCharacter, inputConfirmation }

class InputNotification extends Notification {
  const InputNotification({required this.type, required this.msg});

  final InputType type;
  final String msg;
}

class ValidationProvider extends StatefulWidget {
  const ValidationProvider({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  State<ValidationProvider> createState() => _ValidationProviderState();
}

class _ValidationProviderState extends State<ValidationProvider> {
  String answer = "WORDLE";
  Set<String> letterSet = <String>{'W', 'O', 'R', 'D', 'L', 'E'};
  String curAttempt = "";
  int curAttemptCount = 0;
  bool acceptInput = true;

  void _newGame(String answer) {
    this.answer = answer;
    letterSet.clear();
    letterSet.addAll(answer.split(''));
    curAttempt = "";
    curAttemptCount = 0;
    acceptInput = true;
  }

  void _onGameWin() {
    acceptInput = false;
    _showResult(true);
  }

  void _onGameLoose() {
    acceptInput = false;
    _showResult(false);
  }

  void _showResult(bool result) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Result'),
          content: Text(result ? "Won" : "Lost"),
        );
      }
    );
  }

  bool _isWordValidate(String word) {
    return true;
  }

  @override
  void initState(){
    super.initState();
    mainBus.onBus(event: "NewGame", onEvent: (args) => _newGame(args as String));
    mainBus.onBus(event: "Result", onEvent: (args) => args as bool ? _onGameWin() : _onGameLoose());
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<InputNotification>(
      child: widget.child,
      onNotification: (noti) {
        if(noti.type == InputType.inputConfirmation){
          if(curAttempt.length < 5) {
            //Not enough
            return false;
          }
          else {
            //Check validation
            if(_isWordValidate(curAttempt)) {
              //emit current attempt
              mainBus.emit(
                event: "Attempt",
                args: {
                  "Attempt": curAttempt,
                  "AttemptCount": curAttemptCount,
                }
              );
              curAttempt = "";
              curAttemptCount++;
            }
            else{
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text('Info'),
                    content: const Text('Not a word!'),
                    actions: [
                      TextButton(
                        child: const Text('OK'),
                        onPressed: () => Navigator.of(context).pop(),
                      )
                    ],
                  );
                }
              );
            }
          }
        }
        else{
          if(acceptInput && curAttempt.length < 5) {
            curAttempt += noti.msg;
          }
        }
        return false;
      },
    );
  }
}

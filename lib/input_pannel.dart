/*
 * @Author       : Linloir
 * @Date         : 2022-03-05 20:55:53
 * @LastEditTime : 2022-03-06 12:17:55
 * @Description  : Input pannel class
 */

import 'package:flutter/material.dart';
import 'package:wordle/validation_provider.dart';
import './event_bus.dart';

class InputPannelWidget extends StatefulWidget {
  const InputPannelWidget({Key? key}) : super(key: key);

  @override
  State<InputPannelWidget> createState() => _InputPannelWidgetState();
}

class _InputPannelWidgetState extends State<InputPannelWidget> {
  @override
  void initState() {
    super.initState();
    
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ElevatedButton(
          child: const Text('A'),
          onPressed: () {
            const InputNotification(type: InputType.singleCharacter, msg: "A").dispatch(context);
          },
        ),
        ElevatedButton(
          child: const Text('W'),
          onPressed: () {
            const InputNotification(type: InputType.singleCharacter, msg: "W").dispatch(context);
          },
        ),
        ElevatedButton(
          child: const Text('O'),
          onPressed: () {
            const InputNotification(type: InputType.singleCharacter, msg: "O").dispatch(context);
          },
        ),
        ElevatedButton(
          child: const Text('R'),
          onPressed: () {
            const InputNotification(type: InputType.singleCharacter, msg: "R").dispatch(context);
          },
        ),
        ElevatedButton(
          child: const Text('Submit'),
          onPressed: () {
            const InputNotification(type: InputType.inputConfirmation, msg: "").dispatch(context);
          },
        ),
      ],
    );
  }
}
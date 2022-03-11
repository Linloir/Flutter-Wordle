/*
 * @Author       : Linloir
 * @Date         : 2022-03-05 20:41:41
 * @LastEditTime : 2022-03-11 14:54:15
 * @Description  : Offline page
 */

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:wordle/event_bus.dart';
import 'package:wordle/validation_provider.dart';
import 'package:wordle/display_pannel.dart';
import 'package:wordle/instruction_pannel.dart';
import 'package:wordle/popper_generator.dart';

class GamePage extends StatefulWidget {
  const GamePage({Key? key, required this.database, required this.wordLen, required this.maxChances, required this.gameMode}) : super(key: key);

  final Map<String, List<String>> database;
  final int wordLen;
  final int maxChances;
  final int gameMode;

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> with TickerProviderStateMixin{
  late AnimationController _controller;

  void _onGameEnd(dynamic args) {
    var result = args as bool;
    if(result == true) {
      _controller.forward().then((v) {
        _controller.reset();
        mainBus.emit(event: "Result", args: result);
      }
      );
    }
    else {
      mainBus.emit(event: "Result", args: result);
    }
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 2000));
    mainBus.onBus(event: "ValidationEnds", onEvent: _onGameEnd);
  }

  @override
  void dispose() {
    mainBus.offBus(event: "ValidationEnds", callBack: _onGameEnd);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var mode = Theme.of(context).brightness;
    return Stack(
      children: [
        Positioned.fill(
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Theme.of(context).brightness == Brightness.dark ? Colors.grey[850] : Colors.white,
              elevation: 0.0,
              shadowColor: Colors.transparent,
              toolbarHeight: 80.0,
              titleTextStyle: TextStyle(
                color: Theme.of(context).brightness == Brightness.dark ? Colors.grey[100] : Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              ),
              title: const Text('WORDLE'),
              centerTitle: true,
              //iconTheme: const IconThemeData(color: Colors.black),
              actions: [
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 750),
                  reverseDuration: const Duration(milliseconds: 750),
                  switchInCurve: Curves.bounceOut,
                  switchOutCurve: Curves.bounceIn,
                  transitionBuilder: (child, animation) {
                    var rotateAnimation = Tween<double>(begin: 0, end: 2 * pi).animate(animation);
                    var opacAnimation = Tween<double>(begin: 0, end: 1).animate(animation);
                    return AnimatedBuilder(
                      animation: rotateAnimation,
                      builder: (context, child) {
                        return Transform(
                          transform: Matrix4.rotationZ(rotateAnimation.status == AnimationStatus.reverse ? 2 * pi - rotateAnimation.value : rotateAnimation.value),
                          alignment: Alignment.center,
                          child: Opacity(
                            opacity: opacAnimation.value,
                            child: child,
                          ),
                        );
                      },
                      child: child,
                    );
                  },
                  child: IconButton(
                    key: ValueKey(mode),
                    icon: mode == Brightness.light ? const Icon(Icons.dark_mode_outlined) : const Icon(Icons.dark_mode),
                    onPressed: () => mainBus.emit(event: "ToggleTheme", args: []),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.help_outline_outlined),
                  //color: Colors.black,
                  onPressed: (){
                    showInstructionDialog(context: context);
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.refresh_rounded),
                  //color: Colors.black,
                  onPressed: (){
                    mainBus.emit(event: "NewGame", args: []);
                  },
                ),
              ],
            ),
            body: Container(
              child: ValidationProvider(
                database: widget.database,
                wordLen: widget.wordLen,
                maxChances: widget.maxChances,
                gameMode: widget.gameMode,
                child: WordleDisplayWidget(wordLen: widget.wordLen, maxChances: widget.maxChances),
              ),
              color: Theme.of(context).brightness == Brightness.dark ? Colors.grey[850] : Colors.white,
            ),
          ),
        ),
        Positioned.fill(
          child: PartyPopperGenerator(
            direction: PopDirection.fowardX,
            motionCurveX: FunctionCurve(func: (t) {
              return - t * t / 2 + t;
            }),
            motionCurveY: FunctionCurve(func: (t) {
              return 4 / 3 * t * t - t / 3;
            }),
            numbers: 50,
            posX: -60.0,
            posY: 30.0,
            pieceHeight: 15.0,
            pieceWidth: 30.0,
            controller: _controller,
          ),
        ),
        Positioned.fill(
          child: PartyPopperGenerator(
            direction: PopDirection.backwardX,
            motionCurveX: FunctionCurve(func: (t) {
              return - t * t / 2 + t;
            }),
            motionCurveY: FunctionCurve(func: (t) {
              return 4 / 3 * t * t - t / 3;
            }),
            numbers: 50,
            posX: -60.0,
            posY: 30.0,
            pieceHeight: 15.0,
            pieceWidth: 30.0,
            controller: _controller,
          ),
        ),
      ],
    );
  }
}

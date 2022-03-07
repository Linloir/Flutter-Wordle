/*
 * @Author       : Linloir
 * @Date         : 2022-03-05 20:41:41
 * @LastEditTime : 2022-03-07 09:30:56
 * @Description  : Offline page
 */

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:wordle/event_bus.dart';
import 'package:wordle/validation_provider.dart';
import './display_pannel.dart';

class OfflinePage extends StatefulWidget {
  const OfflinePage({Key? key}) : super(key: key);

  @override
  State<OfflinePage> createState() => _OfflinePageState();
}

class _OfflinePageState extends State<OfflinePage> with TickerProviderStateMixin{
  @override
  Widget build(BuildContext context) {
    var mode = Theme.of(context).brightness;
    return Scaffold(
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
        title: const Text('WORDLE OFFLINE'),
        centerTitle: true,
        //iconTheme: const IconThemeData(color: Colors.black),
        actions: [AnimatedSwitcher(
            duration: const Duration(milliseconds: 750),
            reverseDuration: const Duration(milliseconds: 750),
            switchInCurve: Curves.bounceInOut,
            switchOutCurve: Curves.bounceInOut,
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
            icon: const Icon(Icons.refresh_rounded),
            //color: Colors.black,
            onPressed: (){
              mainBus.emit(event: "NewGame", args: []);
            },
          ),
        ],
      ),
      body: Container(
        child: const ValidationProvider(
          child: WordleDisplayWidget(),
        ),
        color: Theme.of(context).brightness == Brightness.dark ? Colors.grey[850] : Colors.white,
      ),
    );
  }
}

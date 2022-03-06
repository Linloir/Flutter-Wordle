/*
 * @Author       : Linloir
 * @Date         : 2022-03-05 20:41:41
 * @LastEditTime : 2022-03-06 11:41:41
 * @Description  : Offline page
 */

import 'package:flutter/material.dart';
import 'package:wordle/validation_provider.dart';
import './display_pannel.dart';
import './input_pannel.dart';

class OfflinePage extends StatefulWidget {
  const OfflinePage({Key? key}) : super(key: key);

  @override
  State<OfflinePage> createState() => _OfflinePageState();
}

class _OfflinePageState extends State<OfflinePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        shadowColor: Colors.transparent,
        toolbarHeight: 80.0,
        titleTextStyle: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 20.0,
        ),
        title: const Text('WORDLE OFFLINE'),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            color: Colors.black,
            onPressed: (){},
          )
        ],
      ),
      body: Column(
        children: const <Widget>[
          Expanded(
            child: ValidationProvider(
              child: WordleDisplayWidget(),
            )
          ),
        ],
      ),
    );
  }
}

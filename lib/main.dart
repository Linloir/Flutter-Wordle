/*
 * @Author       : Linloir
 * @Date         : 2022-03-05 20:21:34
 * @LastEditTime : 2022-03-05 20:46:33
 * @Description  : 
 */
import 'package:flutter/material.dart';
import './offline.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wordle',
      theme: ThemeData(
        primarySwatch: Colors.blue
      ),
      routes: {
        "/": (context) => const HomePage(),
        "/Offline": (context) => const OfflinePage(),
      },
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          child: const Text('Offline'),
          onPressed: () => Navigator.of(context).pushNamed("/Offline"),
        )
      )
    );
  }
}
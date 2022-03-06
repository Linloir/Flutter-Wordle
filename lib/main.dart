/*
 * @Author       : Linloir
 * @Date         : 2022-03-05 20:21:34
 * @LastEditTime : 2022-03-06 16:08:09
 * @Description  : 
 */
import 'package:flutter/material.dart';
import './offline.dart';
import './generator.dart';

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
    return FutureBuilder(
      future: Words.importWordsDatabase(),
      builder: (context, snapshot) {
        if(snapshot.connectionState == ConnectionState.done) {
          return Scaffold(
            body: Center(
              child: ElevatedButton(
                child: const Text('Offline'),
                onPressed: () => Navigator.of(context).pushNamed("/Offline"),
              ),
            ),
          );
        }
        else {
          return const Center(
            child: SizedBox(
              height: 100.0,
              width: 100.0,
              child: CircularProgressIndicator(
                strokeWidth: 5.0,
              ),
            ),
          );
        }
      },
    );
    
    // Scaffold(
    //   body: Center(
    //     child: ElevatedButton(
    //       child: const Text('Offline'),
    //       onPressed: () => Navigator.of(context).pushNamed("/Offline"),
    //     )
    //   )
    // );
  }
}
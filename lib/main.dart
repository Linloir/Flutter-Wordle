/*
 * @Author       : Linloir
 * @Date         : 2022-03-05 20:21:34
 * @LastEditTime : 2022-03-07 09:20:28
 * @Description  : 
 */
import 'package:flutter/material.dart';
import 'package:wordle/event_bus.dart';
import './offline.dart';
import './generator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  var brightness = Brightness.light;

  void _onThemeChange(dynamic args) {
    setState(() {
      brightness = brightness == Brightness.light ? Brightness.dark : Brightness.light;
    });
  }

  @override
  void initState() {
    super.initState();
    mainBus.onBus(event: "ToggleTheme", onEvent: _onThemeChange);
  }

  @override
  void dispose(){
    mainBus.offBus(event: "ToggleTheme", callBack: _onThemeChange);
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wordle',
      theme: ThemeData(
        primarySwatch: Colors.grey,
        brightness: brightness,
      ),
      routes: {
        "/": (context) => const HomePage(),
        "/Offline": (context) => const OfflinePage(),
      },
      initialRoute: "/",
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
              child: Padding(
                padding: const EdgeInsets.all(50.0),
                child: AspectRatio(
                  aspectRatio: 16 / 9,
                    child: OutlinedButton(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'OFFLINE PLAYGROUND',
                                style: TextStyle(
                                  color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.grey[850]!,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                              // Padding(
                              //   padding: const EdgeInsets.symmetric(vertical: 8.0),
                              //   child: Container(
                              //     width: 80.0,
                              //     height: 8.0,
                              //     decoration: BoxDecoration(
                              //       color: Colors.grey[800],
                              //       borderRadius: BorderRadius.circular(3.5),
                              //     ),
                              //   ),
                              // ),
                              Text(
                                'Play Wordle game offline using local word database',
                                style: TextStyle(
                                  color: Colors.grey[500],
                                  fontSize: 12.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all<OutlinedBorder?>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                        padding: MaterialStateProperty.all<EdgeInsets?>(const EdgeInsets.all(0)),
                      ),
                      onPressed: () {
                        Navigator.of(context).pushNamed("/Offline");
                        mainBus.emit(event: "NewGame", args: []);
                      }
                    )
                  ),
              )
            ),
          );
        }
        else {
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 60.0,
                    width: 60.0,
                    child: CircularProgressIndicator(
                      strokeWidth: 6.0,
                      color: Colors.grey[850],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Text('Loading library', 
                      style: TextStyle(
                        color: Colors.grey[850]!, 
                        fontSize: 16.0, 
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
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
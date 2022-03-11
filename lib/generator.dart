/*
 * @Author       : Linloir
 * @Date         : 2022-03-06 15:03:57
 * @LastEditTime : 2022-03-11 13:56:33
 * @Description  : Word generator
 */

import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

Future<Set<String>> generateDictionary() async {
  // Directory documentRoot = await getApplicationDocumentsDirectory();
  // String dicPath = documentRoot.path + Platform.pathSeparator + dicName + ".txt";
  // File dicFile = File(dicPath);
  String dicContents = await rootBundle.loadString("assets/All.txt");
  Set<String> database = {};
  LineSplitter.split(dicContents).forEach((line) {
    database.add(line.toUpperCase());
  });
  return database;
}

Future<Map<String, List<String>>> generateQuestionSet({required String dicName, required int wordLen}) async {
  // Directory documentRoot = await getApplicationDocumentsDirectory();
  // String dicPath = documentRoot.path + Platform.pathSeparator + dicName + ".txt";
  // File dicFile = File(dicPath);
  String dicContents = await rootBundle.loadString("assets/" + dicName + ".txt");
  Map<String, List<String>> database = {};
  LineSplitter.split(dicContents).forEach((line) {
    var vowelStart = line.indexOf('[');
    var vowelEnd = line.indexOf(']');
    var word = "";
    var vowel = "";
    var explain = "";
    word = line.substring(0, vowelStart == -1 ? null : vowelStart).trim().toUpperCase();
    if(vowelStart != -1){
      vowel = line.substring(vowelStart, vowelEnd + 1).trim();
      explain = line.substring(vowelEnd + 1).trim();
    }
    if(wordLen == -1 || word.length == wordLen) {
      database[word] = [vowel, explain];
    }
  });
  return database;
}

Future<String> fetchOnlineWord() async {
  await Future.delayed(const Duration(seconds: 2));
  return "BINGO";
}

String getNextWord(Map<String, List<String>> database) {
  var rng = Random();
  return database.keys.elementAt(rng.nextInt(database.length));
}

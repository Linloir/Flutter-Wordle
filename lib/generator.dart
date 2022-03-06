/*
 * @Author       : Linloir
 * @Date         : 2022-03-06 15:03:57
 * @LastEditTime : 2022-03-06 16:16:14
 * @Description  : Word generator
 */

import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'dart:math';

abstract class Words {
  static Set<String> dataBase = <String>{};

  static Future<void> importWordsDatabase() async {
    var data = await rootBundle.loadString('assets/txt/words_alpha.txt');
    dataBase.addAll(LineSplitter.split(data));
  }
  
  static Future<String> generateWord() async{
    int bound = dataBase.length;
    if(bound == 0) {
      await Words.importWordsDatabase();
      bound = dataBase.length;
    }
    var rng = Random();
    return dataBase.elementAt(rng.nextInt(bound));
  }

  static bool isWordValidate(String word) {
    return dataBase.lookup(word.toLowerCase()) != null;
  }
}


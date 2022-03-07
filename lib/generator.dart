/*
 * @Author       : Linloir
 * @Date         : 2022-03-06 15:03:57
 * @LastEditTime : 2022-03-07 15:55:48
 * @Description  : Word generator
 */

import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'dart:math';

abstract class Words {
  static Set<String> dataBase = <String>{};
  static Set<String> dictionary = <String>{};
  static int _length = 5;
  static String _cache = "";
  //static Map<String, String> explainations = {};

  static Future<bool> importWordsDatabase({int length = 5}) async {
    //explainations.clear();
    if(length != _length || dataBase.isEmpty || dictionary.isEmpty){
      _length = length;
      dataBase.clear();
      _cache = "";
      try {
        var data = await rootBundle.loadString('assets/popular.txt');
        LineSplitter.split(data).forEach((line) {
          if(line.length == length && dataBase.lookup(line.substring(0,length - 1)) == null && dataBase.lookup(line.substring(0, length - 2)) == null) {
            dataBase.add(line.toLowerCase());
          }
          _cache = line;
        });
      } catch (e) {
        throw "Failed loading question database";
      }
      try {
        var data = await rootBundle.loadString('assets/unixWords.txt');
        LineSplitter.split(data).forEach((line) {
          if(line.length == length && dictionary.lookup(line.substring(0,length - 1)) == null && dictionary.lookup(line.substring(0, length - 2)) == null) {
            dictionary.add(line.toLowerCase());
          }
          _cache = line;
        });
      } catch (e) {
        throw "Failed loading validation database";
      }
    }
    if(dataBase.isEmpty) {
      throw "Empty question database";
    }
    else if(dictionary.isEmpty) {
      throw "Empty validation database";
    }
    return true;
  }

  static Future<String> generateWord() async {
    int bound = dataBase.length;
     if(bound == 0) {
       try{
        await Words.importWordsDatabase(length: _length);
       } catch (e) {
        return 'crash';
       }
       bound = dataBase.length;
     }
    var rng = Random();
    String res = dataBase.elementAt(rng.nextInt(bound));
    if(dictionary.lookup(res) == null) {
      dictionary.add(res);
    }
    return res;
  }

  static bool isWordValidate(String word) {
    return dictionary.lookup(word.toLowerCase()) != null;
  }
}


/*
 * @Author       : Linloir
 * @Date         : 2022-03-10 22:07:28
 * @LastEditTime : 2022-03-10 22:07:29
 * @Description  : Scroll behavior
 */

import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

class MyScrollBehavior extends ScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}
